package com.kh.parking.history.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

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

	//키워드를 바탕으로 한 주차장 리스트들 모음 
	public ArrayList<ParkingLot> searchParking(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		
		int limit = pi.getBoardLimit(); //몇개씩 보여줄것인지
		int offset = (pi.getCurrentPage()-1)*limit;//몇개를 건너뛸것인지
		
		//RowBounds 객체 생성하기 
	    RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList) sqlSession.selectList("historyMapper.searchParking", keyword, rowBounds); 
	}

	//키워드를 바탕으로 한 주차장들의 총 개수 
	public int searchListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("historyMapper.searchListCount", keyword); 
	}

	public ArrayList<ParkingLot> searchKeywordParking(SqlSessionTemplate sqlSession, String value) {
		
		return (ArrayList) sqlSession.selectList("historyMapper.searchKeywordParking", value);
		
	}

	//검색 한 내용이 중복이면 히스토리에 중복된 검색 내용을 안나오게끔 하는 검증 메소드 
	public boolean checkContent(SqlSessionTemplate sqlSession, HashMap<String, String> paramMap) {
		int result = sqlSession.selectOne("historyMapper.checkContent", paramMap);
		
		if(result > 0) { // 중복 됐으니까 데이터를 추가하지 말기 
			return true;
		}   
		
		// 이건 중복이 안된것이다. false를 반환해서 데이터 추가하기
		return false; 
		
	}

	//검색 한 내용이 중복인데 검색 히스토리에는 날짜만 갱신하게끔 하는 메소드 
	public int updatehDate(SqlSessionTemplate sqlSession, HashMap<String, String> paramMap) {
		return sqlSession.update("historyMapper.updatehDate",paramMap); 
	}
	
}
