package com.team.follow.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.block.Service.BlockService;
import com.team.block.VO.BlockVO;
import com.team.chat.Service.ChatService;
import com.team.follow.Service.FollowService;
import com.team.follow.VO.FollowVO;
import com.team.member.Service.MemberServiceImpl;
import com.team.member.VO.MemberVO;
import com.team.message.Service.MessageService;

@Controller
public class FollowController {

	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberServiceImpl memberService;

	@Autowired
	MessageService messageService;
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private BlockService blockService;

	// 팔로우 버튼 눌렀을때.
	@RequestMapping(value = "/follow", method = RequestMethod.POST)
	@ResponseBody
	public int Follow(@RequestBody FollowVO vo, Model model) {
		//System.out.println("follow 호출");

		int result = 0;

		// 블락된 상태면 팔로우 할 수 없음.
		BlockVO bvo = new BlockVO();
		bvo.setBlocker_id(vo.getFollower_id());
		bvo.setBlocking_id(vo.getFollowing_id());
		if(blockService.IsBlocked(bvo) == true)
			return -1;
		
		if (followService.IsFollowing(vo)) {
			System.out.println("이미 팔로우 되어있음.");
			result = 0;

		}else {
			followService.InsertFollowing(vo);
			//System.out.println("컨트롤러에서 팔로우 처리 완료");
			result = 1;
		}

		return result;
	}
	
	
	@RequestMapping(value = "/unfollow", method = RequestMethod.POST)
	@ResponseBody
	public int UnFollow(@RequestBody FollowVO vo, Model model) {
		//System.out.println("UnFollow 호출");
		int result = 0;

		if (followService.IsFollowing(vo)) {
			followService.DeleteFollowing(vo);
			//System.out.println("컨트롤러에서 언팔로우 완료");
			result = 1;
		} else {
			System.out.println("팔로우 되어있지 않음.");
			result = 0;
		}

		return result;

	}

	// 팔로우 목록 페이지 요청 처리
	@RequestMapping(value = { "{id}/follower", "{id}/following" })
	public String ShowFollowList(@PathVariable String id, Model model, HttpServletRequest request) throws Exception {

		// uri 에서 id/~~~ 에서 ~~~ 값을 뽑아내는 부분
		String uri = request.getRequestURI();
		String type = "";
		Pattern pattern = Pattern.compile("(?<=" + id + "\\/)\\w+");
		Matcher data = pattern.matcher(uri);
		if (data.find()) {
			type = data.group();
		}
		/// ---------
		
		// id에 해당하는 프로필을 가져온다. 
		// MemberInterceptor에서 처리 한 후 가져오는것.
		MemberVO memberVo = (MemberVO)request.getAttribute("vo");
		
		//읽지 않은 쪽지 개수 조회
		int count = messageService.countList(memberVo);
		//채팅방 개수 조회
		int count2 = chatService.countList(memberVo);
		
		model.addAttribute("chatCount", count2);
		model.addAttribute("profile",memberVo);
		model.addAttribute("messageCount", count);
		model.addAttribute("chatCount", count2);
		model.addAttribute("type", type); // 팔로우 페이지인지 팔로잉 페이지인지
		model.addAttribute("page_id", id); // 보여줄 페이지의 아이디값

		return "main.jsp?center=follow/list";

	}

	// 팔로워 목록
	@RequestMapping(value = "/getFollowerList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getFollowerList(@RequestBody Map<String, String> FollowInfo) {
		return getFollowList(FollowInfo,0);

	}

	// 팔로잉 목록
	@RequestMapping(value = "/getFollowingList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getFollowingList(@RequestBody Map<String, String> FollowInfo) {
		
		
		return getFollowList(FollowInfo,1);

	}
	
	public List<Map<String, Object>> getFollowList(Map<String, String> FollowInfo, int Type) {
											// map(my_id로그인 아이디, id페이지 아이디, pageNum페이지 번호), 
											// Type = 0일때 follower 목록 / 1일때 following 목록
		
		
		// 페이지 번호에 10 곱해서 저장. (0, 10, 20 단위 글 보려고)
		int pageNum = Integer.parseInt(FollowInfo.get("pageNum")) * 10;
		FollowInfo.put("pageNum", String.valueOf(pageNum));
		
		// 팔로우 목록 담을 리스트
		List<FollowVO> follow;
		
		if(Type == 0)
			follow = followService.GetAllFollower(FollowInfo);
		else
			follow = followService.GetAllFollowing(FollowInfo);
		
		// 팔로워, 팔로잉, 차단 수 가져오기.
		String pageID = FollowInfo.get("id");
		String followerNum = String.valueOf(followService.getCountFollower(pageID));
		String followingNum = String.valueOf(followService.getCountFollowing(pageID));
		String blockingNum = String.valueOf(blockService.getCountBlocking(pageID));
		
		
		// 팔로워 id,팔로우여부 담을 리스트 맵 생성
		List<Map<String, Object>> followlist = new ArrayList<>();
		
		int index = 0;
		
		// 리스트의 값들을 하나씩 체크.
		for (FollowVO temp : follow) {
			//System.out.println(aa.getFollower_id() + " " + aa.getFollowing_id());
			// 임시 맵
			Map<String, Object> tempMap = new HashMap<>();
			
			String target_id = "";
			if(Type == 0)
				target_id = temp.getFollower_id();
			else
				target_id = temp.getFollowing_id();
				
			// 팔로우 여부 체크하기 위해서 (내아이디, 대상 아이디) 담을 FollowVO 생성

			if (!FollowInfo.get("my_id").equals("")) {
				
				FollowVO vo = new FollowVO();
				vo.setFollower_id(FollowInfo.get("my_id"));
				vo.setFollowing_id(target_id);


				// 팔로우 여부 확인
				String isfollowing = String.valueOf(followService.IsFollowing(vo));
				tempMap.put("isfollowed", isfollowing);
			} else {
				tempMap.put("isfollowed", "");
			}

			tempMap.put("target_id", target_id);


			// 멤버의 프로필 값을 가져온다.
			MemberVO memVO = memberService.getMember(target_id);
			
			tempMap.put("memVO", memVO);
			
			
			
			// 팔로워, 팔로잉 수
			if(index == 0) {
				tempMap.put("followerNum", followerNum);
				tempMap.put("followingNum", followingNum);
				tempMap.put("blockingNum", blockingNum);
			}
			
			index++;
			
			followlist.add(tempMap);

		}
		
		
		if(followlist.size() == 0) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("followerNum", followerNum);
			tempMap.put("followingNum", followingNum);
			tempMap.put("blockingNum", blockingNum);
			followlist.add(tempMap);
		}
		return followlist;
	}

	// 팔로우 되어있는지 안되어있는지 체크 여부.
	@RequestMapping(value = "/isFollowed", method = RequestMethod.POST)
	@ResponseBody
	public int isFollowed(@RequestBody FollowVO vo, Model model) {

		int result = 0;

		followService.IsFollowing(vo);

		if (followService.IsFollowing(vo))
			result = 1;
		else
			result = 0;

		return result;

	}
	
	
	// 팔로우 추천 목록
	@RequestMapping(value = "/SuggestionFollow", method = RequestMethod.POST)
	@ResponseBody
	public List<FollowVO> getSuggestionFollowList(@RequestBody String id){
	
		List<FollowVO> recommend = followService.getNotFollowingList(id);
		return recommend;
		
	}

	

}
