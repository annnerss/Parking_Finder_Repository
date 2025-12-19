package com.kh.parking.history.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.parking.history.model.dao.HistoryDao;
import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

@Service
public class HistoryServiceImpl implements HistoryService {
	
	@Autowired
	private HistoryDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public ArrayList<History> selectHistory(Member loginMember) {
		ArrayList<History> selectHistory = dao.selectHistory(sqlSession, loginMember);
		
		return selectHistory; 
	}

}
