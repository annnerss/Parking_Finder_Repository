package com.kh.parking.history.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.kh.parking.history.model.service.HistoryService;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

@Controller
public class HistoryController {
	
	@Autowired
	private HistoryService service;
	
	//검색 내용을 조회, 날짜도 나오게 해야한다.(아이디를 기반으로) 
	public String selectHistory(HttpSession session, Model model) {
		
	   Member loginMember = (Member) session.getAttribute("loginMember");
	   
	   ArrayList<History> selectHistory = service.selectHistory(loginMember); // 검색 내용 및 날짜를 담아둔 리스트
	   
	   //만약에 selectHistory가 아예 없으면 -> 검색한 내용이 없습니다를 jsp페이지에 띄우면 된다.
	   
	   return "history/searchHistory"; 
		
	}
	
	
	
	

}
