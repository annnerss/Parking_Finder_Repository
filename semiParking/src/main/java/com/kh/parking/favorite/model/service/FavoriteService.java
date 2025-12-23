package com.kh.parking.favorite.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.parking.parkinglot.model.vo.ParkingLot;

public interface FavoriteService {

	//찜 목록 추가 메서드 
	int insertFavorite(HashMap<String, String> paramMap);

	//찜 목록 조회 메서드 
	ArrayList<ParkingLot> selectParking(String memId);

	//찜 목록에서 삭제하기 메서드 
	int removeFavorite(HashMap<String,String> paramMap);
	
	

}
