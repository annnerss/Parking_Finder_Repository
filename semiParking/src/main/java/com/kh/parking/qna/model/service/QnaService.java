package com.kh.parking.qna.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.qna.model.vo.Qna;
import com.kh.parking.qna.model.vo.Reply;

@Service
public interface QnaService {

	//문의사항 총 개수
	int listCount();
	
	//문의사항 목록 조회
	ArrayList<Qna> qnaList(PageInfo pi);
	
	//문의사항 글 상세보기
	Qna qnaDetail(int qno);
	
	//문의사항 게시글 등록
	int qnaInsert(Qna q);

	//주차장 이름 관리번호로 변환
	String selectPNoByPName(String pNo);
	
	//게시글 조회 가능 확인
	String checkMem(String memId);

	//관리자 비밀번호 조회
	String adminPwd();

	//댓글 리스트 조회
	List<Reply> replyList(int qNo);
	
	//새로운 댓글 작성
	int insertReply(Reply r);
}
