package com.kh.parking.member.model.service;

import com.kh.parking.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	String selectMember2(String inputId);

	Member selectMember(Member member);

}
