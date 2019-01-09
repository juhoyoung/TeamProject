package com.team.member.DAO;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team.member.VO.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void InsertMember(MemberVO member) {
		
		sqlSession.insert("insertMember", member);
		
	}
	
	@Override
	public MemberVO getMember(String ID) {
		
		return sqlSession.selectOne("getMember",ID);
		
	}
	
	@Override
	public void updateMember(MemberVO member) {
		sqlSession.update("updateMember",member);
	}

	@Override
	public List<MemberVO> GetSearchMember(Map<String, String> searchInfo) {
		return sqlSession.selectList("GetSearchMemberList", searchInfo);
	}
	
	@Override
	public int idcheck(String ID) {
		return sqlSession.selectOne("idcheck",ID);
	}
	
	@Override
	public boolean checkPw(String ID, String PWD) {
		boolean result =false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("ID", ID);
		map.put("PWD",PWD);
		int count = sqlSession.selectOne("checkPw",map);
		if(count == 1) result = true;
		return result;
	}
	@Override
	public void deleteMember(String ID) {
		sqlSession.delete("deleteMember",ID);
	}
	
	
}
