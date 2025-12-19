package com.kh.parking.history.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.member.model.vo.History;
import com.kh.parking.member.model.vo.Member;

@Repository
public class HistoryDao {

	public ArrayList<History> selectHistory(SqlSessionTemplate sqlSession, Member loginMember) {
		return (ArrayList) sqlSession.selectList("historyMapper.selectHistory",loginMember); 
	}

}
