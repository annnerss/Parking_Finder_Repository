package com.kh.parking.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.review.model.dao.ReviewDao;
import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//리뷰 목록 조회
	@Override
	public ArrayList<Review> reviewList(String pNo) {
		return dao.reviewList(sqlSession, pNo);
	}

	//사진 리뷰 작성
	@Override
	@Transactional
	public int photoInsert(Review r, ArrayList<Attachment> atList) {
		
		//게시글 정보 추가
		int result = dao.insertReview(sqlSession, r);
		int result2 = 1;
		
		if(result > 0 && !atList.isEmpty()) {
			for(Attachment a:atList) {
				a.setRefRno(r.getRNo());
				System.out.println(a);
			}	
			
			result2 = dao.insertAttachement(sqlSession, atList);
		}
		return (result > 0 && result2 > 0)?1:0;
	}

}
