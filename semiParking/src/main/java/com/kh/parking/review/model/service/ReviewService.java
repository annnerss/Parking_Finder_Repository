package com.kh.parking.review.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

@Service
public interface ReviewService {
	
	//리뷰 목록 조회
	ArrayList<Review> reviewList(String pNo);

	//리뷰 작성 
//	int reviewInsert(Review r);
	
	//사진 리뷰 추가
	int photoInsert(Review r, ArrayList<Attachment> atList);

	//별점 평점
	Double reviewAvgPoint(String pNo);


}