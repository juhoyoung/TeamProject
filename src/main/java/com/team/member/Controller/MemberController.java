package com.team.member.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.team.block.Service.BlockService;
import com.team.block.VO.BlockVO;
import com.team.chat.Service.ChatService;
import com.team.follow.Service.FollowService;
import com.team.follow.VO.FollowVO;
import com.team.member.Service.MemberServiceImpl;
import com.team.member.VO.MemberVO;
import com.team.message.Service.MessageService;

@Controller
@SessionAttributes("member")
public class MemberController {

	@Autowired
	MemberServiceImpl memberService;
	
	@Autowired
	MessageService messageService;
	
	@Autowired
	FollowService followService;
	
	@Autowired
	BlockService blockService;
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping("/check")
	public String check() {
		return "member/check";
	}
	
	@RequestMapping("/delete.do")
	public String memberDelete(@RequestParam String ID, @RequestParam String PWD, Model model,HttpServletRequest request) {
		boolean result = memberService.checkPw(ID,PWD);
		
		if(result) {
			memberService.deleteMember(ID);
			request.getSession().removeAttribute("member");
			model.addAttribute("msg","탈퇴 되었습니다.");
			return "login";
		}else {
			model.addAttribute("message","비밀번호 불일치");
			model.addAttribute("member",memberService.getMember(ID));
			return "/mypage";
		}
	}
	
	@RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
	public @ResponseBody String AjaxView(  
		        @RequestParam("ID") String ID){
		String str = "";
		int idcheck = memberService.idCheck(ID);
		if(idcheck==1){ //이미 존재하는 계정
			str = "NO";	
		}else{	//사용 가능한 계정
			str = "YES";	
		}
		return str;
	}
	
	@RequestMapping("/signUp")
	public String insertMember(Model model) {
		model.addAttribute("member", new MemberVO());
		return "member/signUp";
	}
	

	@RequestMapping("/insertOk")
	//@Valid(벨리드:미리체크 하겠다는 뜻)어노테이션기호를 사용하여 
	//작성한 회원 내용정보가 있는 MybatisMember(DTO)객체의 유효성 체크를 한다.
	//BindingResult result로 유효성체크의 결과정보를 전달 받는다.
	public String insertOk(@Valid MemberVO member, BindingResult result, Map<String, BindingResult> model) {
		
		model.put(BindingResult.class.getName()+".member", result);
		if(result.hasErrors()) { //에러가 있으면
			System.out.println(result.toString());
			System.out.println("회원가입시 오류가 발생했습니다.");
			return "member/signUp";
		}else {
			//에러가 없으면 DB에 작성한 내용 insert
			System.out.println(member.getPIC()); 
			
			memberService.InsertMember(member);
			return "login";
		}
	}
	
	@RequestMapping("{ID}/mypage")
	public String mypageMember(@PathVariable String ID, HttpSession session, Model model) throws Exception {
		MemberVO vo = memberService.getMember(ID);
		
		
		MemberVO sessionVO = (MemberVO)session.getAttribute("member");
		
		int count = messageService.countList(vo);
		//채팅방 개수 조회
		int count2 = chatService.countList(vo);
		
		model.addAttribute("messageCount", count);
		model.addAttribute("chatCount", count2);
		
		// uri의 ID값과 로그인 정보랑 다를때 main으로 이동하게 변경
		if(!ID.equals(sessionVO.getID())) {
			return "redirect:/main";
		}
		//model.addAttribute("member",vo);
		model.addAttribute("profile",vo);
		return "main.jsp?center=member/mypage";
	}
	
	@RequestMapping("/mypageOk")
	public String mypageOk(@Valid MemberVO member,BindingResult result, Map<String, BindingResult> model, Model mo, HttpSession session) {
		
		MemberVO proMem = (MemberVO)session.getAttribute("member");
		mo.addAttribute("profile", proMem);
		model.put(BindingResult.class.getName()+".member", result);
		if(result.hasErrors()) {
			System.out.println(result.toString());
			System.out.println("회원정보 수정시 오류가 발생");
			return "main.jsp?center=member/mypage";
		}else {
			memberService.updateMember(member);
			return "login";
		}
	}
	
	//search?keyword=~~~ 로 요청시 처리
	@RequestMapping("/search")
	public String getSearchList(@RequestParam String keyword, HttpSession session ,Model model) throws Exception {
	
		// 로그인 여부 체크하기 위해 세션값 받아옴.
		MemberVO memVO = (MemberVO)session.getAttribute("member");
		
		// 로그인 되어있는 상태에서만 값을 보내준다.
		if(memVO != null) {		
			int count = messageService.countList(memVO);
			//채팅방 개수 조회
			int count2 = chatService.countList(memVO);
			model.addAttribute("profile", memVO);
			model.addAttribute("messageCount", count);
			model.addAttribute("chatCount", count2);
		}
		model.addAttribute("keyword", keyword);
		
		
		return "main.jsp?center=member/search";
	}
	
	@RequestMapping("/getSearchList")
	@ResponseBody
	public List<Map<String, String>> SearchMemberList(@RequestBody Map<String, String> searchInfo, HttpSession session) {
		// 맵에 담긴 정보 <검색어, 페이지번호>
		
		// 리턴 해줘야 하는 정보 (아이디,이메일,프로필사진,팔로우여부)
		//System.out.println("getSeachList 호출완료.");
		//System.out.println("getSearchList " + searchInfo.get("keyword") + " " + searchInfo.get("pageNum"));
		
		// 정보를 12개씩 표현하겠다는 뜻.
		String pageNum = String.valueOf(Integer.parseInt(searchInfo.get("pageNum")) * 12);
		
		searchInfo.put("pageNum", pageNum);
		
		// 검색값 얻어오기
		List<MemberVO> member = memberService.GetSearchMember(searchInfo);
		
		// 로그인 여부 체크하기 위해 세션값 받아옴.
		MemberVO memVO = (MemberVO)session.getAttribute("member");
		
		
		
		// 팔로우 여부를 맵으로 저장. <아이디, 팔로우여부>
		List<Map<String, String>> searchInfoList = new ArrayList<>();
		
		
			
		for (MemberVO temp : member) {
			Map<String, String> tempMap = new HashMap<>();
			String isFollowed = "";
			String isBlocked = "";
			
			
				
			// 세션 member가 존재할때. = 로그인 되어있을때만.
			if (memVO != null) {
				// temp의 ID가 로그인된 ID와 같으면 무시한다.
				if (memVO.getID().equals(temp.getID()))
					continue;
				

				FollowVO fVo = new FollowVO();
				fVo.setFollower_id(memVO.getID());
				fVo.setFollowing_id(temp.getID());
				isFollowed = String.valueOf(followService.IsFollowing(fVo));
				
				BlockVO bvo = new BlockVO();
				bvo.setBlocker_id(memVO.getID());
				bvo.setBlocking_id(temp.getID());
				isBlocked = String.valueOf(blockService.IsBlocking(bvo));

			}


			// 이미지 비어있을때 기본 이미지로 변경.
			if(temp.getPIC() == null || temp.getPIC().equals("")) {
				temp.setPIC("/resources/img/baby.jpg");
			}
			
			tempMap.put("sMem_id", temp.getID());
			tempMap.put("sMem_email", temp.getEMAIL());
			tempMap.put("sMem_pic", temp.getPIC());
			tempMap.put("isfollowed", isFollowed);
			tempMap.put("isblocked", isBlocked);
			searchInfoList.add(tempMap);
		}
		
		
		
		
		return searchInfoList;
	}
	

}

