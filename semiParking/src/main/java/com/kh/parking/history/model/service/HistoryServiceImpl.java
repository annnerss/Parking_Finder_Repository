package com.kh.parking.history.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.history.model.dao.HistoryDao;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

@Service
public class HistoryServiceImpl implements HistoryService {
	
	@Autowired
	private HistoryDao dao; // 빈 주입
	
	@Autowired
	private SqlSessionTemplate sqlSession; // 빈 주입 
	
	@Override
	public ArrayList<History> selectHistory(String memId) {
		ArrayList<History> selectHistory = dao.selectHistory(sqlSession, memId); // DB에서 받아오기
		return selectHistory; // 검색 목록 반환  
	}
		
	@Override
	public int insertContent(HashMap<String, String> paramMap) {
		
		// HashMap을 이용해서 아이디와 키워드를 담아보자. (왜냐하면 dao에서 dml구문을 처리할땐 객체를 하나만 가져 올 수 있으므로) 
		
		int result = dao.insertContent(sqlSession, paramMap); // 검색을 했으면 검색 목록에 내용 넣는 작업 
		
		return result;
	}

}
