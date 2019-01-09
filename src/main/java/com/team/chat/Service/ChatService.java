package com.team.chat.Service;

import com.team.chat.VO.ChatVO;

public interface ChatService {
	//채팅 보내기
	public void chatSend(ChatVO cvo) throws Exception;

	//채팅 내용 불러오기
	public ChatVO sendRead(ChatVO cvo)throws Exception;
}
