package com.kh.parking.favorite.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.parking.favorite.model.service.FavoriteService;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Controller
public class FavoriteController {
	
	@Autowired
	private FavoriteService service;
	
	//찜 목록 페이지로 이동
    @GetMapping("/favorites.parking")
    public String favoriteParking(HttpSession session, Model model) { // 목록을 보여주는건 그 페이지에서만 유용하다. 그래서 모델에 담자. 
    	
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	String memId = loginMember.getMemId(); // 멤버 아이디 갖고오기 
    	
    	ArrayList<ParkingLot> parkingList = service.selectParking(memId); // 찜을 한 주차장 목록들 가져오기
    	
    	model.addAttribute("parkingList",parkingList); // 모델에 주차장 목록들 담아오기 
    
    	//그럼 만약에 찜 목록에서 사용자가 찜한걸 삭제하고 싶으면 비동기 처리? 혹은 동기 처리? 
    	
    	return "favorite/favoriteParking";
    	
    }
    
    //예를 들어서, 어떤 주차장에 찜하기 버튼이 있다고 가정 
    //버튼을 눌렀을 때 주차장 이름에 대한 데이터를 갖고오기(이때 갖고 올때 form태그를 작성 후, 갖고 오는 바인딩 변수를 주차장 고유번호(P_NO로)
    //주차장 고유 식별 번호는 hidden 태그로 처리 해서 갖고 오면 될듯하다. 
    @PostMapping("/favorites.parking")
    public String insertFavorite(HttpSession session,String parkingNo) {
    	
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	String memId = loginMember.getMemId(); // 세션에서 멤버 아이디 갖고 오기 
    	
    	// memId와 pno를 둘 다 전달 받아야한다. 
    	
    	HashMap<String, String> paramMap = new HashMap<>(); // dao에서 데이터를 넣을 때는 -> 파라미터 변수에 객체 하나만 넣을 수 있음.
    	
    	paramMap.put("memId", memId); // 아이디 맵에 넣기
    	paramMap.put("parkingNo", parkingNo); // 주차장 관리 번호 맵에 넣기 

    	int result = service.insertFavorite(paramMap);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg","찜 목록에 추가하였습니다."); 
    	} else {
    		session.setAttribute("alertMsg","이미 찜 목록에 있습니다."); 
    	}
    	
    	return "redirect:/"; // 일단은 주차장 목록에 키워드 검색에 대한 정보가 없어서 임시방편으로 처리 
    	
    	//return "redirect:/searchList?keyword="+keyword+"&searchBno="+bno; (현재 페이지로 이동) 
    	
    	//찜 목록을 넣는걸 성공하든 실패하든 현재 페이지 그대로 냅둬야한다.
    
    }
    
    
    /*
    //찜 목록 조회하기 (비동기 통신 이용하기) 
    @ResponseBody
    @RequestMapping(value="/select.parking", produces="produces=application/json;charset=UTF-8")
    public ArrayList<ParkingLot> selectParking(HttpSession session) { // 로그인 정보 갖고와서 조회 
    	
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	String memId = loginMember.getMemId(); // 멤버 아이디 갖고오기 
    	
    	ArrayList<ParkingLot> parkingList = service.selectParking(memId); // 찜을 한 주차장 목록들 가져오기
    	
    	return parkingList; // 찜 한 주차장 목록이 있을때랑 없을때는 Ajax에서 처리하자. 
    }
    */ 
    
    
    
    

}