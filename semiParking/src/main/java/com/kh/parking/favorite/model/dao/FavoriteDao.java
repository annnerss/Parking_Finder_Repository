package com.kh.parking.favorite.model.dao;

import java.util.ArrayList;

import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Repository
public class FavoriteDao {

	//찜하기 버튼을 눌렀으면 찜 목록에 넣기 
	public int insertFavorite(SqlSessionTemplate sqlSession, HashMap<String, String> paramMap) {
		return sqlSession.insert("favoriteMapper.insertFavorite",paramMap); 
	}

	//찜 목록 조회 
	public ArrayList<ParkingLot> selectParking(SqlSessionTemplate sqlSession, String memId) {
		int limit = 5; // 찜 목록은 5개만 보여주기
		int offset = 0; // 건너 뛰는건 없게 하기 
		RowBounds rowBounds = new RowBounds(offset,limit); 
		return (ArrayList) sqlSession.selectList("favoriteMapper.selectFavorite", memId,rowBounds); 
	}

	public boolean isFavorite(SqlSessionTemplate sqlSession, HashMap<String, String> paramMap) {
		int count = sqlSession.selectOne("favoriteMapper.isFavorite",paramMap);
		
		if(count>=1) {
			return true; // 1개이상 있으면 이미 찜 목록에 같은 데이터가 있다는 것이다. 
		} else {
			return false; // 1개 미만이면 0개니까 찜 목록에 같은 데이터가 없다는 것이다. 
		}
	}

}