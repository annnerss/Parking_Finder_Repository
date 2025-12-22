package com.kh.parking.history.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.member.model.vo.History;

@Repository
public class HistoryDao {

	//검색 목록 조회해오기 (시간 순으로 조회하는거 RowBounds 써야 하는데 이따 작성하기) 
	public ArrayList<History> selectHistory(SqlSessionTemplate sqlSession, String memId) {
		
		int limit = 5; // 몇개를 보여줄것인지를 정의하는 변수
		
		int offset = 0; // 몇개를 건너뛸지를 정의하는 변수
		
		// 검색 목록은 5개만 보여줄것이기 때문에 offset은 0으로 지정하고 limit는 5로 지정했다. 
		
		RowBounds rowBounds = new RowBounds(0,5); 
		
		return (ArrayList) sqlSession.selectList("historyMapper.selectHistory", memId, rowBounds);
	}

	//검색 내용 집어넣기 
	public int insertContent(SqlSessionTemplate sqlSession, HashMap<String, String> paramMap) {
		return sqlSession.insert("historyMapper.insertContent", paramMap); 
	}
	
}
