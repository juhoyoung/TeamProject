package com.team.member.Service;


import java.util.List;
import java.util.Map;

import com.team.member.VO.MemberVO;

public interface MemberService {
	
	public void InsertMember(MemberVO vo);
	
	public MemberVO getMember(String ID);
	
	public void updateMember(MemberVO vo);
	
	public List<MemberVO> GetSearchMember(Map<String, String> searchInfo);
	
	public int idcheck(String ID);
	
	public boolean checkPw(String ID, String PWD);	
	
	public void deleteMember(String ID);
}
