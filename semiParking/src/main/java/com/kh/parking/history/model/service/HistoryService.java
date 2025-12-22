package com.kh.parking.history.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.parking.member.model.vo.History;

public interface HistoryService {

	//로그인한 회원 정보를 바탕으로 검색한 기록들을 보여주게 하는 메소드 
	ArrayList<History> selectHistory(String memId);

	//검색 내용란에 검색 버튼을 눌렀을때 HISTORY DB에 삽입
	int insertContent(HashMap<String, String> paramMap);
}