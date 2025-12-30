package com.kh.parking.history.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.history.model.dao.HistoryDao;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.parkinglot.model.vo.ParkingLot;

@Service
public class HistoryServiceImpl implements HistoryService {
	
	@Autowired
	private HistoryDao dao; // 빈 주입
	
	@Autowired
	private SqlSessionTemplate sqlSession; // 빈 주입 
	
	//Id를 바탕으로 검색 목록 반환 
	@Override
	public ArrayList<History> selectHistory(String memId) {
		ArrayList<History> selectHistory = dao.selectHistory(sqlSession, memId); // DB에서 받아오기
		
		return selectHistory; // 검색 목록 반환  
	}
	
	//History 테이블에 검색 내용 집어넣기 
	@Transactional
	@Override
	public int insertContent(HashMap<String, String> paramMap) {
	      
	      int result = 0; 
	      // 일단 0으로 초기화 (여기서 result는 검색 입력란에 입력한 내용과 검색 히스토리에 있는 내용이 일치하면 삽입x, 안 일치하면 삽입 하게 하는 판별 변수 
	         
	      if(dao.checkContent(sqlSession, paramMap)) { // 검색 내용 중복 되는지를 체크하기. true면 중복
	            
	          int result1 = dao.updatehDate(sqlSession, paramMap); // 검색 내용이 중복 되더라도 날짜는 바뀌게끔 (목록에는 중복안되게 반영) 
	            
	          if(result1 > 0) {
	              System.out.println("검색 하신 내용은 중복된 내용이나 검색 날짜를 갱신합니다.");
	           } else {
	               System.out.println("검색 하신 내용은 중복된 내용이나 검색 날짜를 갱신하지 못했습니다.");
	           }
	            return result; 
	         }
	         
	         // 중복된 키워드가 아니면 날짜는 갱신된다. (insert 구문에서 검색날짜는 디폴트라 따로 안넣어도된다.) 
	         
	         // HashMap을 이용해서 아이디와 키워드를 담아보자. (왜냐하면 dao에서 dml구문을 처리할땐 객체를 하나만 가져 올 수 있으므로) 
	         
	         result = dao.insertContent(sqlSession, paramMap); // 검색을 했으면 검색 목록에 내용 넣는 작업 
	         return result;
	}
	
	
	//키워드에 맞는 해당 주차장 목록 총 개수
	@Override
	public int searchListCount(String keyword) {
		int result = dao.searchListCount(sqlSession,keyword);
		return result; 
		
	}
	
	//검색 내용 란에 있는 키워드를 바탕으로 주차장 목록 띄우기 
	@Override
	public ArrayList<ParkingLot> searchParking(String keyword, PageInfo pi) {
		ArrayList<ParkingLot> parkingList = dao.searchParking(sqlSession,keyword,pi);
		return parkingList;
	}
	
	//검색 내용 란에 키워드를 쳤을때 검색 버튼을 누르기 전에 목록 띄우기 
	@Override
	public ArrayList<ParkingLot> searchKeywordParking(String value) {
		
		ArrayList<ParkingLot> parkingList = dao.searchKeywordParking(sqlSession, value);
		
		return parkingList; 
		
	}

}
