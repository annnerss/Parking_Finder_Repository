package com.kh.parking.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.parking.review.model.dao.ReviewDao;
import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//리뷰 총 개수
//	@Override
//	public int listCount() {
//		
//		return dao.listCount(sqlSession);
//	}

	//리뷰 목록 조회
	@Override
	public ArrayList<Review> reviewList(String parkingNo) {
		
		return dao.reviewList(sqlSession, parkingNo);
	}

	//리뷰 작성
//	@Override
//	public int reviewInsert(Review r) {
//
//		return dao.reviewInsert(sqlSession, r);
//	}
	
	//사진 리뷰 작성
	@Override
	public int photoInsert(Review r, ArrayList<Attachment> atList) {
		
		//게시글 정보 추가
		int result = dao.photoInsert(sqlSession, r);
		
		if(result > 0) {
			if(atList != null && !atList.isEmpty()) {
				for(Attachment a:atList) {
					a.setRefRno(r.getRNo());
				}	
				
				System.out.println(atList);
				
				System.out.println(r);
			
			
				int result2 = dao.insertAttachement(sqlSession, atList);
				
				return result*result2;
			}
			return result;
		}
		return 0;
	}
	

}
