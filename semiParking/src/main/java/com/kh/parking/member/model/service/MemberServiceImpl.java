package com.kh.parking.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.member.model.dao.MemberDao;
import com.kh.parking.member.model.vo.Member;


@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override // 회원 가입 
	public int insertMember(Member member) {
		
		int result = dao.insertMember(sqlSession, member);
		
		return result; 
		
	}
	
	@Transactional
	@Override // 로그인 메서드, 동시에 마지막 로그인 날짜 SYSDATE를 넣어보기  (트랜잭션 처리를 이용해보자.) 
	public Member selectMember(Member member) {
		
		int result = 0; // 트랜잭션 처리를 한 후, 결과값 받는 변수 
		
		Member loginMember = dao.selectMember(sqlSession, member); // 사용자가 입력한 아이디 및 비밀번호를 데이터 베이스에서 있는지 조회.
		
		
		
		//위에 로그인 멤버는 데이터베이스에서 조회만 해온거지 휴면 처리 이런건 전혀 안되어있다. 
		
		if(loginMember!=null) { // DB에서 회원 조회가 됐다면 
			
			if(loginMember.getStatus().equals("N")) { // 탈퇴한 회원은 아래 updateDate를 거칠 필요가 없다. 
				return loginMember;
			}
			
			// 조회가 끝나면 -> 휴면 계정인지 아닌지를 체크 하고 마지막 로그인 날짜까지 갱신  
			
			result = dao.updateDate(sqlSession,loginMember); // 로그인 한 시점을 마지막 로그인 날짜로 바꾸기
			
			//이때 DB는 수정 됐지만 로그인 멤버 객체는 수정이 안됐다. (휴면 판단 여부 및 마지막 로그인 날짜 처리) 
			
			loginMember = dao.selectMember(sqlSession, member); // 갱신 하고나서 로그인 멤버 한번 더 초기화. 
			
			//업데이트 할때 SYSDATE - LAST_LOGIN >= 30 조건 걸어두기
			
			if(result > 0) { // 아이디및 비밀번호랑 일치한 회원 정보가 있고 마지막 로그인 날짜까지 수정 됐다면 로그인 승인. 
				return loginMember; 
			} 
		}
		
		return null; // 이 경우는 loginMember가 null이든 아니든 마지막 로그인 날짜 시점을 처리하지 못하면 실패로 처리. 
		 
	}
	
	
	@Override // 아이디 중복체크 
	public String selectMember2(String inputId) {
		String memberId = dao.selectMember2(sqlSession, inputId);
		
		return memberId; 
	}
	
	
	@Override // 회원 정보 업데이트 
	public int updateMember(Member loginMember) {
		int result = dao.updateMember(sqlSession,loginMember);
		
		return result; 
	}
	
	@Override
	public int deleteMember(Member loginMember) {
		int result = dao.deleteMember(sqlSession,loginMember); 
		
		return result; 
	}
	
	
	
	
	

}