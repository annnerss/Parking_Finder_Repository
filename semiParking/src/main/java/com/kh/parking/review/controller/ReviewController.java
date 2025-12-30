package com.kh.parking.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.parking.review.model.service.ReviewService;
import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	//리뷰 목록 조회
	@ResponseBody
	@RequestMapping("/reviewListView.rv")
	public ArrayList<Review> reviewList(@RequestParam("pNo") String pNo) {
		ArrayList<Review> list = service.reviewList(pNo);
		if(list != null) {
			System.out.println(list);
		}else {
			System.out.println("리스트 비어있음");
		}
		
		return list;
	}
	
	//리뷰 작성 페이지 이동
	@GetMapping("/reviewInsert.rv")
	public String reviewEnroll() {
		
		return "review/reviewEnrollForm";
	}
	
	//사진 포함 리뷰 작성 요청
	@PostMapping("/photoInsert.rv")
	public String photoInsert(Review r
							  , @RequestParam("pNo") String pNo
	                          , ArrayList<MultipartFile> uploadFiles
							  , HttpSession session) {
		
		r.setPNo(pNo);
		
		ArrayList<Attachment> atList = new ArrayList<>();
		
		for(MultipartFile file : uploadFiles) {
			String changeName = saveFile(session, file);
			String originName = file.getOriginalFilename();
			
			Attachment at = new Attachment();
			if (at != null) {
				at.setChangeName(changeName);
				at.setOriginName(originName);
				at.setFilePath("/resources/uploadFiles/"+changeName);
				
				atList.add(at);
			}
		}
		
 		//리뷰 등록 처리
		int result = service.photoInsert(r, atList);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "리뷰 등록 성공");
		}else {
			session.setAttribute("alertMsg", "리뷰 등록 실패");
		}
		
		
		return "redirect:/";
	}
	

	
//	//리뷰 작성 요청
//	@PostMapping("/reviewInsert.rv")
//	public String reviewInsert(Review r
//							  ,MultipartFile uploadFile 
//							  ,HttpSession session) {
//		
//		if(!uploadFile.getOriginalFilename().equals("")) {
//			
//			String changeName = saveFile(session,uploadFile);
//			
//			r.setOriginName(uploadFile.getOriginalFilename());
//			r.setChangeName("/resources/uploadFiles/"+changeName);
//			
//		}
//		
//		
//		//리뷰 등록 처리
//		int result = service.reviewInsert(r);
//		
//		if(result > 0) {
//			session.setAttribute("alertMsg", "리뷰 등록 성공");
//		}else {
//			session.setAttribute("alertMsg", "리뷰 등록 실패");
//		}
//		
//		return "redirect:/reviewListView.rv";
//	}
	
	//파일 업로드시 처리할 메소드
	private String saveFile(HttpSession session, MultipartFile uploadFile) {

		//원본 파일명 추출
		String originName = uploadFile.getOriginalFilename();
		
		//시간형식 문자열로 뽑아주기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		//랜덤값 5자리 추출
		int ranNum = (int)(Math.random()*90000+10000);
		
		//원본파일에서 확장자 추출 (마지막 . 기준으로 잘라내기)
		String ext = originName.substring(originName.lastIndexOf("."));
		
		//합쳐주기
		String changeName = currentTime + ranNum + ext;
		
		//서버에 업로드 처리 경로
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		try {
			uploadFile.transferTo(new File(savePath+changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	
	
	
	
}