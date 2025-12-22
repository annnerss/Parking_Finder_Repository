package com.kh.parking.history.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.history.model.service.HistoryService;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

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
	@GetMapping("/search.parking") // form 태그에서 get 방식을 이용했으니 GetMapping 
	public String insertContent(HttpSession session, String keyword) { // form 태그에서 갖고온 keyword 바인딩
	
		Member loginMember =(Member) session.getAttribute("loginMember");
		
		if(loginMember == null) { // 비회원으로 검색을 했을때 
			
			return "redirect:/"; 
			
			//return "redirect:/searchList?keyword="+keyword; (검색 내용에 맞는 곳으로 이동)
			
			//따로 둔 이유가 만약에 이 조건을 안 걸어두면 에러가 발생한다. 
			
			//에러가 발생할뿐만 아니라 비회원은 검색할 기회 조차 없다. 
			
		}
		
		String memId = loginMember.getMemId(); // 회원 아이디를 토대로 DB에 검색 내용을 넣어야 한다. (WHERE 절에 memId 넣을거기 때문)
		
		HashMap<String, String> paramMap = new HashMap<>(); 
		
		//HashMap을 사용한 이유 dao에서 DML 구문을 작성할때 객체를 한개만 넣을 수 있기 때문. (SqlTemplateSession제외)
		
		paramMap.put("memId", memId);
		paramMap.put("keyword", keyword);
		
		int result = service.insertContent(paramMap); // 검색을 하면 검색 목록에 담기 
		
		if(result > 0) {
			System.out.println("검색 내용 DB에 넣기 완료."); // 확인용 	
		} else {		
			System.out.println("검색 내용 DB에 넣기 실패."); // 확인용 
		}
		
		return "redirect:/"; // 일던 시험용으로 메인 페이지로 이동. (왜냐면 지금 주차장 목록 페이지가 없기 때문) 
		
		//이제 검색 내용에 맞게 이동을 해야 하니까
		
		//return "redirect:/searchList?keyword="+keyword+"&searchBno="+bno; (검색 내용에 맞는 곳으로 이동) 		
	}
	
}
