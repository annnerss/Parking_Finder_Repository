package com.kh.parking.favorite.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.favorite.model.dao.FavoriteDao;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Service
public class FavoriteServiceImpl implements FavoriteService {
	
	@Autowired 
	private FavoriteDao dao; // 빈 주입 
	
	@Autowired 
	private SqlSessionTemplate sqlSession; // 빈 주입 
	
	//찜 목록에 추가하는 메서드 
	@Transactional
	@Override
	public int insertFavorite(HashMap<String, String> paramMap) { // 회원 아이디와 주차장 고유 번호가 담긴 맵을 전달
		
		int result = 0; 
		
		//찜 목록에 추가 할 때 만약에 중복되는 데이터가 있으면 INSERT 구문을 쓰지 말아야한다. 방지 하는 코드 작성 해보자.
		
		boolean check = dao.isFavorite(sqlSession,paramMap); // 찜 목록 중복 체크 메서드 
		
		if(check==true) { // 중복 데이터가 있으면 찜 목록에 추가하면 안된다. 
			return result; // 그래서 0으로 반환 
		} else {
			result = dao.insertFavorite(sqlSession,paramMap);
		}
		
		
		return result; 
	}
	
	//찜 목록을 조회하는 메서드 
	@Override
	public ArrayList<ParkingLot> selectParking(String memId) {
		ArrayList<ParkingLot> parkingList = dao.selectParking(sqlSession,memId);
		
		return parkingList; 
	}

}
