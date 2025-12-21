package com.kh.parking.qna.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.qna.model.dao.QnaDao;
import com.kh.parking.qna.model.vo.Qna;

@Service
public class QnaServiceImpl implements QnaService{

	@Autowired
	private QnaDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//문의사항 총 개수
	@Override
	public int listCount() {

		return dao.listCount(sqlSession);
	}

	//문의사항 목록 조회
	@Override
	public ArrayList<Qna> qnaList(PageInfo pi) {

		return dao.qnaList(sqlSession, pi);
	}
	
	//문의사항 글 상세보기
	@Override
	public Qna qnaDetail(int qno) {
		
		return dao.qnaDetail(sqlSession, qno);
	}
	

	//문의사항 게시글 작성 - pName으로 pNo 리턴받기

  
	//문의사항 게시글 등록
	@Override
	public int qnaInsert(Qna q) {
		
		return dao.qnaInsert(sqlSession, q);
	}


	
}
