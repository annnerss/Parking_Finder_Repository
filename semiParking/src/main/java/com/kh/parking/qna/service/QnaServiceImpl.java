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
	public ArrayList<Qna> qnaListView(PageInfo pi) {

		return dao.qnaListView(sqlSession, pi);
	}
	
	
}
