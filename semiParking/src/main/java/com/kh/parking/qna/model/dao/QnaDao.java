package com.kh.parking.qna.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.qna.model.vo.Qna;
import com.kh.parking.qna.model.vo.Reply;

@Repository
public class QnaDao {

	//문의사항 총 개수
	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("qnaMapper.listCount");
	}

	//문의사항 목록 조회
	public ArrayList<Qna> qnaList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		//offset/limit 추가해주기
		int limit = pi.getBoardLimit(); //몇개씩 보여줄것인지
		int offset = (pi.getCurrentPage()-1)*limit; //몇개를 건너뛰고 보여줄것인지
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		//selectList의 두번째 매개변수는 파라미터 위치이기 때문에 rowBounds는 세번째 위치에 넣어야한다
		//파라미터가 없다고해도 null을 채워서 자리를 맞춰 전달해야한다.
		return (ArrayList)sqlSession.selectList("qnaMapper.qnaList",null,rowBounds);
	}

	//문의사항 글 상세보기
	public Qna qnaDetail(SqlSessionTemplate sqlSession, int qno) {

		return sqlSession.selectOne("qnaMapper.qnaDetail", qno);
	}
	
	//문의사항 게시글 작성 - pName으로 pNo 리턴받기
	public String selectPNoByPName(SqlSessionTemplate sqlSession, String pNo) {
		return sqlSession.selectOne("qnaMapper.selectPNoByPName",pNo);
	}
	
	//문의사항 게시글 등록
	public int qnaInsert(SqlSessionTemplate sqlSession, Qna q) {
		return sqlSession.insert("qnaMapper.qnaInsert", q);
	}

	//문의사항 글 수정
	public int qnaUpdate(SqlSessionTemplate sqlSession, Qna q) {

		return sqlSession.update("qnaMapper.qnaUpdate", q);
	}

	//문의사항 글 삭제
	public int qnaDelete(SqlSessionTemplate sqlSession, int qno) {

		return sqlSession.delete("qnaMapper.qnaDelete", qno);
	}
	
	//문의사항 게시글 검색
	public ArrayList<Qna> searchList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int limit = pi.getBoardLimit();  //몇개씩 보여줄 것인지
		int offset = (pi.getCurrentPage()-1)*limit;  //몇개를 건너뛸 것인지
		
		//RowBounds 객체 생성하기
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		//매개변수 자리 맞춰서 전달하기 (매퍼구문, 파라미터, rowbounds)
		return (ArrayList)sqlSession.selectList("qnaMapper.searchList", map, rowBounds);
	}
	
	//검색 게시글 수
	public int searchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("qnaMapper.searchListCount", map);
	}

	public String checkMem(SqlSessionTemplate sqlSession, String memId) {
		return sqlSession.selectOne("qnaMapper.checkMem",memId);
	}

	public String adminPwd(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("qnaMapper.adminPwd");
	}
	
	public List<Reply> replyList(SqlSessionTemplate sqlSession, int qNo) {
		return sqlSession.selectList("qnaMapper.replyList",qNo);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("qnaMapper.insertReply",r);
	}




}