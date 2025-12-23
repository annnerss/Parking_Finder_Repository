package com.kh.parking.qna.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.qna.model.dao.QnaDao;
import com.kh.parking.qna.model.vo.Qna;
import com.kh.parking.qna.model.vo.Reply;

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
	@Override
	public String selectPNoByPName(String pNo) {
		return dao.selectPNoByPName(sqlSession, pNo);
	}

  
	//문의사항 게시글 등록
	@Override
	public int qnaInsert(Qna q) {
		return dao.qnaInsert(sqlSession, q);
	}

	@Override
	public String checkMem(String memId) {
		return dao.checkMem(sqlSession,memId);
	}

	@Override
	public String adminPwd() {
		return dao.adminPwd(sqlSession);
	}

	@Override
	public List<Reply> replyList(int qNo) {
		return dao.replyList(sqlSession,qNo);
	}

	@Override
	public int insertReply(Reply r) {
		return dao.insertReply(sqlSession,r);
	}

	@Override
	public int deleteReply(Reply r) {
		return dao.deleteReply(sqlSession,r);
	}


}
