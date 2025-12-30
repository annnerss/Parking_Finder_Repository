package com.kh.parking.favorite.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    	
    	return "member/favoriteParking"; 
    }
    
  // 12/27 추가
    @ResponseBody
    @PostMapping("/favorites.parking")
      public int insertFavorite(HttpSession session,@RequestParam("parkingNo") String parkingNo) {
      	
      	Member loginMember = (Member) session.getAttribute("loginMember");
      	
      	String memId = loginMember.getMemId(); // 세션에서 멤버 아이디 갖고 오기
      	
      	HashMap<String, String> paramMap = new HashMap<>(); // dao에서 데이터를 넣을 때는 -> 파라미터 변수에 객체 하나만 넣을 수 있음.
      	
      	paramMap.put("memId", memId); // 아이디 맵에 넣기
      	paramMap.put("parkingNo", parkingNo); // 주차장 관리 번호 맵에 넣기
      	int result = service.insertFavorite(paramMap); // 중복됐으면 result -> 0 안됐으면 result는 1이상.
      		
      	return result; //1이상이면 찜 목록에 추가 아니면 추가 X
      	
    }
    
    //찜 목록에서 삭제하기 버튼을 눌렀으면 비동기 통신을 이용하여 DB에서 삭제 및 jsp파일에서도 삭제 
    @ResponseBody
    @RequestMapping(value="/removefavorite.parking")
    public String removeFavorite(String parkingNo,String memId,Model model) {
    	
    	HashMap<String,String> paramMap = new HashMap<>();
    	
    	paramMap.put("parkingNo", parkingNo);
    	paramMap.put("memId", memId);
    	
    	int result = service.removeFavorite(paramMap);
    	
    	if(result > 0) {
    		 
    		return "삭제"; // 데이터베이스에서 삭제 했으면 삭제라는 문자열 반환 
    	} 
    	
    	return "삭제X"; // 데이터베이스에서 삭제 하지 못했으면 삭제X 문자열 반환 
      	
    }
    
    
    
    

}