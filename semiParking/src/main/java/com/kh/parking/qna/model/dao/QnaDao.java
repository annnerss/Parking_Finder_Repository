package com.kh.parking.qna.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.qna.model.vo.Qna;

@Repository
public class QnaDao {

	//문의사항 총 개수
	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("qnaMapper.listCount");
	}

	//문의사항 목록 조회
	public ArrayList<Qna> qnaListView(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		//offset/limit 추가해주기
		int limit = pi.getQnaLimit(); //몇개씩 보여줄것인지
		int offset = (pi.getCurrentPage()-1)*limit; //몇개를 건너뛰고 보여줄것인지
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		//selectList의 두번째 매개변수는 파라미터 위치이기 때문에 rowBounds는 세번째 위치에 넣어야한다
		//파라미터가 없다고해도 null을 채워서 자리를 맞춰 전달해야한다.
		return (ArrayList)sqlSession.selectList("qnaMapper.qnaListView",null,rowBounds);
	}

}
