package com.kh.parking.coupon.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.member.model.vo.Coupon;
import com.kh.parking.member.model.vo.MemberCoupon;

@Repository
public class CouponDao {

	//존재하지 않는 쿠폰
	public Coupon selectCouponByCId(SqlSessionTemplate sqlSession, String cId) {

		return sqlSession.selectOne("couponMapper.selectCouponByCId", cId);
	}

	//중복 입력한 쿠폰
	public int countMemberCoupon(SqlSessionTemplate sqlSession, Map<String, String> map) {

		return sqlSession.selectOne("couponMapper.countMemberCoupon", map);
	}

	//쿠폰 등록
	public int couponInsert(SqlSessionTemplate sqlSession, MemberCoupon mc) {
		
		return sqlSession.insert("couponMapper.couponInsert", mc);
	}

	//쿠폰 리스트
	public List<Map<String, Object>> couponList(SqlSessionTemplate sqlSession, String memId) {

		return sqlSession.selectList("couponMapper.couponList", memId);
	}




}
