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
	public ArrayList<Review> reviewList(SqlSessionTemplate sqlSession, String parkingNo) {

		return (ArrayList)sqlSession.selectList("reviewMapper.reviewList", parkingNo);
	}

	//리뷰 작성
//	public int reviewInsert(SqlSessionTemplate sqlSession, Review r) {
//
//		return sqlSession.insert("reviewMapper.reviewInsert", r);
//	}
	
	//사진 리뷰 작성
	public int photoInsert(SqlSessionTemplate sqlSession, Review r) {

		return sqlSession.insert("reviewMapper.photoInsert", r);
	}

	//첨부파일 추가
	public int insertAttachement(SqlSessionTemplate sqlSession, ArrayList<Attachment> atList) {

		return sqlSession.insert("reviewMapper.insertAttachment", atList);
	}




}
