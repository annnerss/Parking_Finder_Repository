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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String qnaDetail(int qno
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
		System.out.println(q.getPNo());
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
	
	//문의사항 글 정보 모델에 담기
		@PostMapping("/update.qn")  
		public String updateModel(int qno, Model model) {
			Qna q = service.qnaDetail(qno);  //문의사항 글 상세조회
			
			//문의사항 글 수정하기 위해서 글 정보 조회하여 모델에 담기
			model.addAttribute("q", q);
			return "qna/qnaUpdateForm";
		}
		
		//문의사항 글 수정
		@PostMapping("/qnaUpdate.qn")   
		public String qnaUpdate(Qna q, HttpSession session) {
			int result = service.qnaUpdate(q);
			
			if(result > 0 ) { //정보수정 성공
				session.setAttribute("alertMsg", "정보 수정 성공");
				
			}else { //정보수정 실패
				session.setAttribute("alertMsg", "정보 수정 실패");
			}
			
			return "redirect:/detail.qn?qno="+q.getQNo();  //기존 상세페이지로 이동
		}
		
		//문의사항 글 삭제
		@PostMapping("/delete.qn")  
		public String qnaDelete(int qno, HttpSession session) {
			//게시글 삭제 요청
			
			
			int result = service.qnaDelete(qno);
			
			if(result > 0) {  //데이터베이스에서 삭제처리 성공
				session.setAttribute("alertMsg", "게시글이 삭제되었습니다.");
				return "redirect:/qnaListView.qn";  //게시글이 삭제되었으니 목록으로 보내기
			
			}else {  //실패
				session.setAttribute("alertMsg", "게시글 삭제 실패");
				
				return "redirect:/detail.qn?qno="+qno;  //원래 페이지
			}
		}
		
		//검색 메소드
		@RequestMapping("/search.qn")
		public String searchList(@RequestParam(value="page", defaultValue="1")
								int currentPage
							   ,String condition
							   ,String keyword
							   ,Model model) {
			
			//전달받은 키워드와 카테고리 map에 담아가기
			//페이징처리에 필요한 데이터 준비해서 PageInfo에 담아주고 페이징 처리하기
			//searchListCount() - 게시글 개수 조회
			//rowbounds 객체 이용해서 페이징 처리후 jsp페이지에도 pi 전달해서 페이징바 만들기
			//검색창에 선택했던 condition과 keyword가 유지되도록 처리
			HashMap<String, String> map = new HashMap<>();
			map.put("condition", condition);
			map.put("keyword", keyword);
			
			//페이징 처리를 위한 데이터들 준비
			//조건에 맞는 검색 결과 개수를 찾아와야하기 때문에 map 전달
			int listCount = service.searchListCount(map);
			int boardLimit = 5;
			int pageLimit = 10;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
			
			ArrayList<Qna> searchList = service.searchList(map, pi);
			
			model.addAttribute("list", searchList);
			model.addAttribute("pi", pi); //pageinfo 정보 전달 (페이징바 처리용)
			model.addAttribute("map", map); //검색 정보 전달 (기존 검색 내용 유지용)
			
			return "qna/qnaListView";
		}
	
	//비공개 게시글 조회
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
	
	//댓글 리스트 조회
	@ResponseBody
	@RequestMapping(value="/replyList.re",produces="application/json;charset=UTF-8")
	public List<Reply> replyList(int qNo){
		List<Reply> rList = service.replyList(qNo);
		return rList;
	}
	
	//댓글 추가
	@ResponseBody
	@RequestMapping("/insertReply.re")
	public int insertReply(Reply r){
		return service.insertReply(r);
	}
	
	//댓글 삭제
	@PostMapping("/deleteReply.re")
	@ResponseBody
	public Map<String, String> deleteReply(Reply r,RedirectAttributes redirectAttributes) {
		Map<String, String> res = new HashMap<>();
		if(r.getReplyWriter().isEmpty()) {
			res.put("status", "fail");
	        res.put("message", "로그인 후 이용 가능합니다");
		}else {
			int result = service.deleteReply(r);
			if(result > 0) {
				res.put("status", result > 0 ? "success" : "fail");
		        res.put("message", result > 0 ? "댓글 삭제 완료" : "댓글 삭제 실패");
		    } else {
		    	res.put("status", "fail");
		        res.put("message", "해당 댓글 작성자만 삭제 가능합니다");
			}
		}
		
		return res;
	}
}
