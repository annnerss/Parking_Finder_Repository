package com.kh.parking.history.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

public interface HistoryService {

	//로그인한 회원 정보를 바탕으로 검색한 기록들을 보여주게 하는 메소드 
	ArrayList<History> selectHistory(String memId);

	//검색 내용란에 검색 버튼을 눌렀을때 HISTORY DB에 삽입
	int insertContent(HashMap<String, String> paramMap);

	int searchListCount(String keyword); // 키워드를 기반으로 한 주차장 목록(개수)들 다 조회해오기 

	ArrayList<ParkingLot> searchParking(String keyword, PageInfo pi); // 키워드를 바탕으로 검색할때 페이징 처리까지 한번에

	ArrayList<ParkingLot> searchKeywordParking(String value); // 키워드를 입력만해도 검색하기 전에 어떤 주차장이 있는지 보이게끔만 
	
	
	
}
