package com.team.chat.Controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.team.chat.Service.ChatService;
import com.team.chat.VO.ChatPageMaker;
import com.team.chat.VO.ChatSearchVO;
import com.team.chat.VO.ChatVO;
import com.team.member.Service.MemberServiceImpl;
import com.team.member.VO.MemberVO;
import com.team.message.Service.MessageService;

@Controller
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	MemberServiceImpl memberService;
	
	@Autowired
	MessageService messageService;
	
	@Inject
	public ChatController(ChatService chatService) {
		this.chatService = chatService;
	}
	
	//채팅 리스트
	@RequestMapping(value="{id}/multiChatList", method=RequestMethod.GET)
	public String multiChatList(@PathVariable String id, HttpSession session, Model model)throws Exception{
		MemberVO memberVO = (MemberVO) session.getAttribute("member");			
		model.addAttribute("profile", memberVO);
			
		return "chat/chat-ing";
	}
	
	//채팅할 사람 검색
	@RequestMapping(value="{id}/chatSearch", method=RequestMethod.GET)
	public String chatSearch(@PathVariable String id, HttpSession session, Model model)throws Exception{
		MemberVO memberVO = (MemberVO) session.getAttribute("member");			
		model.addAttribute("profile", memberVO);
				
		return "chat/chatSearch";
	}
	
	//검색 결과 
	@RequestMapping(value="{id}/chatSearchList", method=RequestMethod.GET)
	public String chat_search(@ModelAttribute("ChatSearchVO")ChatSearchVO chatSearchVO, @PathVariable String id, HttpSession session, Model model)throws Exception{
		MemberVO memberVO = (MemberVO) session.getAttribute("member");			
		
		if(memberVO != null) {		
			int count = messageService.countList(memberVO);
			model.addAttribute("profile", memberVO);
			model.addAttribute("messageCount", count);
		}
		
		ChatPageMaker chatPageMaker = new ChatPageMaker();
		chatPageMaker.setCri(chatSearchVO);
		chatPageMaker.setTotalCount(chatService.count(chatSearchVO));
		
		model.addAttribute("chatlist", chatService.list(chatSearchVO));
		model.addAttribute("chatPageMaker", chatPageMaker);
					
		return "chat/chatSearchList";
	}
	
	//채팅 접속
	@RequestMapping(value="{id}/multiChat", method=RequestMethod.GET)
	public String multiChat(@PathVariable String id, HttpSession session, Model model)throws Exception{
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		model.addAttribute("profile", memberVO);
		
		return "chat/multiChat";
	}
	
	@RequestMapping(value="{id}/multiChatSend", method = {RequestMethod.POST, RequestMethod.GET})
	public String chatSend(ChatVO cvo, Model model, HttpServletRequest request)throws Exception{
		chatService.chatSend(cvo);
		ChatVO resultVO = chatService.sendRead(cvo);
		model.addAttribute("cvo", resultVO);
		
		return "redirect:/chat/multiChat";
	}

}
