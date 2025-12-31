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
	
	
	//사용자가 로그인을 시도하려고 할때 사용자 정보가 있으면 마지막 로그인 한 날짜를 업데이트 처리 및 휴면 계정까지 처리하기 
	public int updateDate(SqlSessionTemplate sqlSession, Member loginMember) {
		return sqlSession.update("memberMapper.updateDate",loginMember); 
	}

	//정보 수정 (휴면 계정이면 status도 바꿔주자. 근데 사실 휴면계정이든 아니든 status Y로 고정 시켜도 문제없다. N은 탈퇴 한사람으로 가정) 
	public int updateMember(SqlSessionTemplate sqlSession, Member loginMember) {
		return sqlSession.update("memberMapper.updateMember",loginMember); 
	}
	
	//회원 삭제(DB에서 아예 삭제가 아닌 STATUS='N'으로)
	public int deleteMember(SqlSessionTemplate sqlSession, Member loginMember) {
		return sqlSession.delete("memberMapper.deleteMember", loginMember); 
	}
	
	//회원 비밀번호 변경 
	public int changeMemberPwd(SqlSessionTemplate sqlSession, Member loginMember) {
		return sqlSession.update("memberMapper.changeMemberPwd", loginMember); 
	}


}
