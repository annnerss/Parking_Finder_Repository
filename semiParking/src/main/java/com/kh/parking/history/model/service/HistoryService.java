package com.kh.parking.history.model.service;

import java.util.ArrayList;

import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

public interface HistoryService {

	//로그인한 회원 정보를 바탕으로 검색한 기록들을 보여주게 하는 메소드 
	ArrayList<History> selectHistory(Member loginMember);

}
