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
import org.springframework.web.multipart.MultipartFile;

import com.kh.parking.review.model.service.ReviewService;
import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

import oracle.jdbc.proxy.annotation.Post;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	//리뷰 목록 조회
	@RequestMapping("/reviewListView.rv")
	public String reviewList(Review r, Model model) {
		
		//임시 처리
		String pNo = "122-1-000001";
		r.setPNo(pNo);
		
		ArrayList<Review> list = service.reviewList(pNo);
		
		model.addAttribute("list", list);
		
		System.out.println(list);
		
		return "review/reviewListView";
	}
	
	//리뷰 작성 페이지 이동
	@GetMapping("/reviewInsert.rv")
	public String reviewEnroll() {
		
		return "review/reviewEnrollForm";
	}
	
	//사진 포함 리뷰 작성 요청
	@PostMapping("/photoInsert.rv")
	public String photoInsert(Review r
							  , ArrayList<MultipartFile> uploadFiles
							  , HttpSession session) {
		
		//임시 처리
		String pNo = "122-1-000001";
		r.setPNo(pNo);
		
		System.out.println(r);
		
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
		
		
		return "redirect:/reviewListView.rv";
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
//		//임시 처리
//		r.setPNo("122-1-000001");
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
