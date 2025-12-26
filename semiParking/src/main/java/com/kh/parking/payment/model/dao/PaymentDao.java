package com.kh.parking.payment.model.dao;
import java.sql.Date;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.parking.payment.model.vo.PaymentApprove;

@Repository
public class PaymentDao {

	public int insertPayment(SqlSessionTemplate sqlSession, PaymentApprove approve) {
		return sqlSession.insert("reserveMapper.insertPayment",approve);
	}

	public Date rStartDate(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.selectOne("reserveMapper.rStartDate",rNo);
	}

	
	

}
