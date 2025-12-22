package com.kh.parking.qna.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.common.template.Pagination;
import com.kh.parking.qna.model.service.QnaService;
import com.kh.parking.qna.model.vo.Qna;
import com.kh.parking.qna.model.vo.Reply;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt; // 암호화하는 빈 주입. 
	
	//문의사항 목록
	@RequestMapping("/qnaListView.qn")
	public String qnaList(@RequestParam(value="page", defaultValue="1")
						int currentPage
						,Model model) {
		
		int listCount = service.listCount();
		int boardLimit = 5;  //게시글 보여줄 개수
		int pageLimit = 10;  //페이징바 개수
		
		//PageInfo 불러오기
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
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
		String pNo = service.selectPNoByPName(q.getPNo()); //검색한 주차장 이름에서 주차장 관리 번호로 변환
		q.setPNo(pNo);
		
		//게시글 등록 처리
		int result = service.qnaInsert(q);
		
		if (result > 0) {
			session.setAttribute("alertMsg", "게시글 등록 성공");
		}else {
			session.setAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/qnaListView.qn";
	}
	
	@ResponseBody
	@PostMapping("/viewQna.qn")
	public Map<String,Object> viewQna(String pwd, int qNo, String memId) {
		String adminPwd = service.adminPwd();
		
		HashMap<String,Object> resultMap = new HashMap<>();
		
		String checkPwd = service.checkMem(memId);
		if(checkPwd != null && (bcrypt.matches(pwd, checkPwd)) || (bcrypt.matches(pwd, adminPwd))) { 
	    	 resultMap.put("status", "success");
	    	 resultMap.put("qno",qNo);
	    }else {
	    	resultMap.put("status","error");
	    	resultMap.put("message","비밀번호가 일치하지 않습니다.");
	    }
	     
	     return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/replyList.re",produces="application/json;charset=UTF-8")
	public List<Reply> replyList(int qNo){
		System.out.println(qNo);
		List<Reply> rList = service.replyList(qNo);
		
		return rList;
	}
	
	@ResponseBody
	@RequestMapping("/insertReply.re")
	public int insertReply(Reply r){
		int result = service.insertReply(r);
		
		return result;
	}
}
