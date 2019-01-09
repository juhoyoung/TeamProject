package com.team.message.DAO;

import java.util.List;

import com.team.message.VO.MessageSearchVO;
import com.team.message.VO.MessageVO;
import com.team.message.VO.SendMessageVO;

public interface MessageDAO {
	
	//쪽지 전체 목록
	public List<MessageVO>listAll(String message_id)throws Exception;
	
	//검색한 쪽지 리스트
	public List<MessageVO>listAll(String message_id, MessageSearchVO msvo)throws Exception;
	
	//페이징을 위한 카운트
	public Integer listCount(String message_id, MessageSearchVO msvo)throws Exception;
	
	//내가 보낸 쪽지
	public List<SendMessageVO>sendListAll(String message_id)throws Exception;
	
	//쪽지 개수
	public int countList(String message_id)throws Exception;
	
	//쪽지 작성
	public void create(MessageVO mvo)throws Exception;
	
	//쪽지 상세 내용
	public MessageVO read(MessageVO mvo)throws Exception;
	
	//내가 보낸 쪽지 상세 내용 
	public MessageVO sendRead(MessageVO mvo)throws Exception;
	
	//쪽지를 읽을 시, 읽지않음이 읽은 날짜로 변경된다.
	public void updateRead(int MESSAGE_NO)throws Exception;
	
	//쪽지 삭제
	public void delete(int MESSAGE_NO)throws Exception;
}
