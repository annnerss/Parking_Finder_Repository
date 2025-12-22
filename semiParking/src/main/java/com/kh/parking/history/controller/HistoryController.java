package com.kh.parking.history.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.common.template.Pagination;
import com.kh.parking.history.model.service.HistoryService;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Controller
public class HistoryController {
	
	@Autowired
	private HistoryService service; // 빈 주입 
	
	//검색 내용을 조회, 날짜도 나오게 해야한다.(아이디를 기반으로)
	@ResponseBody
	@RequestMapping(value="/searchList.parking", produces="application/json;charset=UTF-8")
	public ArrayList<History> selectHistory(String memId) {
		
	   //Member loginMember = (Member) session.getAttribute("loginMember"); //getAttribute는 Object형을 반환하니 다운 캐스팅 
	   
	   ArrayList<History> selectHistory = service.selectHistory(memId); // 검색 내용 및 날짜를 담아둔 리스트
	   
	   //만약에 selectHistory가 아예 없으면 -> 검색한 내용이 없습니다를 jsp페이지에 띄우면 된다.
	   
	   //근데 매번 검색 목록을 조회해오면 계속 목록이 늘어난다.
	   
	   return selectHistory; 
	}
	
	
	//검색 내용 집어 넣기 
	@RequestMapping(value="/search.parking", method=RequestMethod.GET)
	public String insertContent(
	        @RequestParam(value="page", required=false) Integer page,
	        HttpSession session,
	        String keyword,
	        Model model) {

	    Member loginMember = (Member) session.getAttribute("loginMember");

	    int listCount = service.searchListCount(keyword);

	    // ✅ 검색 결과 있으면 page=1을 강제로 URL에 노출
	    if (listCount > 0 && page == null) {
	    	
	    	String encodedKeyword =
	    	        URLEncoder.encode(keyword, StandardCharsets.UTF_8);
	    	
	        return "redirect:/search.parking?keyword=" + encodedKeyword + "&page=1";
	    }

	    int boardLimit = 10;
	    int pageLimit = 10;
	    int currentPage = (page == null) ? 1 : page;

	    PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
	    model.addAttribute("pi", pi);

	    ArrayList<ParkingLot> parkingList = service.searchParking(keyword, pi);
	    System.out.println(parkingList.get(0));
	    model.addAttribute("parkingList", parkingList);
	    model.addAttribute("keyword", keyword);

	    // 비회원
	    if (loginMember == null) {
	        return "parkingMap/searchResult";
	    }

	    // 회원이면 검색 기록 저장
	    String memId = loginMember.getMemId();
	    HashMap<String, String> paramMap = new HashMap<>();
	    paramMap.put("memId", memId);
	    paramMap.put("keyword", keyword);

	    service.insertContent(paramMap);

	    return "parkingMap/searchResult";
	}
	
}
