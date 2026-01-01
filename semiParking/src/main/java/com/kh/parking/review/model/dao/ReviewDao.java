package com.kh.parking.review.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.review.model.vo.Attachment;
import com.kh.parking.review.model.vo.Review;

@Repository
public class ReviewDao {

	//리뷰 총 개수
//	public int listCount(SqlSessionTemplate sqlSession) {
//
//		return sqlSession.selectOne("reviewMapper.listCount");
//	}

	//리뷰 목록 조회
	public ArrayList<Review> reviewList(SqlSessionTemplate sqlSession, String pNo) {
		ArrayList<Review> rList = (ArrayList)sqlSession.selectList("reviewMapper.reviewList", pNo);
		return (ArrayList)rList;
	}

	//사진 리뷰 작성
	public int insertReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.insert("reviewMapper.insertReview", r);
	}

	//첨부파일 추가
	public int insertAttachement(SqlSessionTemplate sqlSession, ArrayList<Attachment> atList) {
		return sqlSession.insert("reviewMapper.insertAttachment", atList);
	}

	//별점 평점
	public Double reviewAvgPoint(SqlSessionTemplate sqlSession, String pNo) {
		return sqlSession.selectOne("reviewMapper.reviewAvgPoint", pNo);
	}




}