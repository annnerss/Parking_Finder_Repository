package com.kh.parking.qna.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.common.template.Pagination;
import com.kh.parking.qna.model.vo.Qna;
import com.kh.parking.qna.service.QnaService;


@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	//문의사항 목록
	@RequestMapping("/qnaListView.qn")
	public String qnaList(@RequestParam(value="page", defaultValue="1")
						int currentPage
						,Model model) {
		
		int listCount = service.listCount();
		int qnaLimit = 5;  //게시글 보여줄 개수
		int pageLimit = 10;  //페이징바 개수
		
		//PageInfo 불러오기
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, qnaLimit, pageLimit);
		ArrayList<Qna> list = service.qnaList(pi);
		
		
		model.addAttribute("pi",pi);
		model.addAttribute("list", list);

		return "qna/qnaListView";
	}
	
	//문의사항 글 상세보기
	@RequestMapping("/detail.qn") 
	public String qnaDetain(int qno
						  , HttpSession session
						  , Model model) {
		
		Qna q = service.qnaDetail(qno);
			
		model.addAttribute("q", q);
			
		return "qna/qnaDetailView";

	}
	

	
	
	//문의사항 글작성 페이지 이동
	@GetMapping("/qnaInsert.qn")
	public String qnaEnroll() {
			
		return "qna/qnaEnrollForm";
	}
	
	//문의사항 글작성 요청
	@PostMapping("/qnaInsert.qn")
	public String qnaInsert(Qna q
						  , HttpSession session) {
		
		//게시글 등록 처리
		int result = service.qnaInsert(q);
		
		if (result > 0) {
			session.setAttribute("alertMsg", "게시글 등록 성공");
		}else {
			session.setAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/qnaListView.qn";
	}
	
}
