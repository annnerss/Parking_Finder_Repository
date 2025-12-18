package com.kh.parking.qna.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		ArrayList<Qna> list = service.qnaListView(pi);
		
		return "qna/qnaListView";
	}
	
	//문의사항 글 등록
	@RequestMapping("/qnaInsert.qn")
	public String qnaInsert() {
		
		return "qna/qnaEnrollment";
	}
	
	
	
}
