package com.kh.parking.member.model.service;

import com.kh.parking.member.model.vo.Member;

public interface MemberService {
	int insertMember(Member member); // 회원 가입 메소드 
	String selectMember2(String inputId); // 아이디 중복 체크 메소드 
	Member selectMember(Member member); // 회원 조회, 마지막 로그인 날짜 갱신 및 휴면 계정 처리 메소드 
	int updateMember(Member loginMember); // 정보 수정 
	int deleteMember(Member loginMember);
	int changeMemberPwd(Member loginMember);
}