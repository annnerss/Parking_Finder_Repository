
package com.kh.parking.history.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.parking.history.model.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.common.template.Pagination;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Controller
public class HistoryController {

    @Autowired
    private HistoryService service;

	//검색 내용을 조회, 날짜도 나오게 해야한다.(아이디를 기반으로)
	@ResponseBody
	@RequestMapping(value="/searchList.parking", produces="application/json;charset=UTF-8")
	public ArrayList<History> selectHistory(String memId) {
		
	   //Member loginMember = (Member) session.getAttribute("loginMember"); //getAttribute는 Object형을 반환하니 다운 캐스팅 
	   
	   ArrayList<History> selectHistory = service.selectHistory(memId); // 검색 내용 및 날짜를 담아둔 리스트

	   return selectHistory; 
	}
	
	// 검색 하기 전에 검색 내용란에 키워드를 넣으면 주차장 목록이 나오게끔 설계 
	@ResponseBody
	@RequestMapping(value="/searchKeywordParking.parking", produces = "application/json;charset=UTF-8")
	public ArrayList<ParkingLot> searchKeywordParking(String value) {
		
		//  받아온 value를 dao에다가 주기 그래서 LIKE를 써보기 
		ArrayList<ParkingLot> parkingList = service.searchKeywordParking(value); 
		
		return parkingList; 
		
	}
	
	
	//검색 내용 집어 넣기 및 게시판 형태(목록)로 보여주기
    @ResponseBody
    @RequestMapping("parkingSearch.get")
	public List<ParkingLot> insertContent(HttpSession session, String keyword) {

	    Member loginMember = (Member) session.getAttribute("loginMember"); // 로그인 회원 정보 갖고오기
        ArrayList<ParkingLot> list = service.searchKeywordParking(keyword);

	    // 비회원
	    if (loginMember == null) { // 검색 기록을 저장할 필요가 없으니 바로 이동
	        return list;
	    }
	    // 회원이면 검색 기록 저장
	    String memId = loginMember.getMemId();
	    
	    HashMap<String, String> paramMap = new HashMap<>();
	    
	    paramMap.put("memId", memId);
	    paramMap.put("keyword", keyword);

	    ///////////////////////////////////
	    //추가 한 부분 
	    int result = service.insertContent(paramMap); // 검색 기록 넣기 
	    
	    if(result > 0) {
	    	System.out.println("검색 목록을 추가 했습니다."); // 확인용 
	    } else {
	    	System.out.println("검색 목록을 추가 하지 못했습니다."); // 확인용 
	    }
	    ///////////////////////////////////

	    return list; // 검색 기록을 넣고 나서 페이징 바 처리한 곳으로 이동
	}
}
