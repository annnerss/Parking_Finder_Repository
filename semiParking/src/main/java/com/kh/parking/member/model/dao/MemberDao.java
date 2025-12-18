package com.kh.parking.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.member.model.vo.Member;

@Repository
public class MemberDao {

	//회원 가입 
	public int insertMember(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.insertMember", member); 
	}
	
	//회원 조회
	public Member selectMember(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.selectMember", member); 
	}
	

	//아이디 중복체크 
	public String selectMember2(SqlSessionTemplate sqlSession, String inputId) {
		return sqlSession.selectOne("memberMapper.selectMember2", inputId); 
	}

	//사용자가 로그인을 시도하려고 할때 사용자 정보가 있으면 마지막 로그인 한 날짜를 업데이트 처리 
	public int updateDate(SqlSessionTemplate sqlSession, Member loginMember) {
		return sqlSession.update("memberMapper.updateDate",loginMember); 
	}

}
