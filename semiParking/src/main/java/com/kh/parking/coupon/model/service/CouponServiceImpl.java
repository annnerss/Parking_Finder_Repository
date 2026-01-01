package com.kh.parking.coupon.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.parking.coupon.model.dao.CouponDao;
import com.kh.parking.member.model.vo.Coupon;
import com.kh.parking.member.model.vo.MemberCoupon;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//쿠폰 등록
	@Override
	public int couponInsert(String memId, String couponCode) {

		Coupon coupon = dao.selectCouponByCId(sqlSession, couponCode);

		if (coupon == null) {
			return -1; // 쿠폰 없음 
		}

		Map<String,String> map = new HashMap<>();
		map.put("memId", memId);
		map.put("couponCode", couponCode);

		int count = dao.countMemberCoupon(sqlSession, map);
		if (count > 0) {
			return -2; // 이미 등록됨
		}
		MemberCoupon mc = new MemberCoupon();
		
		mc.setMemId(memId);
		mc.setRefCid(couponCode);
		
		return dao.couponInsert(sqlSession, mc);
	}
	
	//회원가입시 쿠폰 자동 발급
	@Transactional
	@Override
	public void welcomeCoupon(String memId) {
		
		this.couponInsert(memId, "WELCOME10");
	}
	
	//쿠폰 리스트
	@Override
	public List<Map<String, Object>> couponList(String memId) {

		return dao.couponList(sqlSession, memId);
	}

	


}