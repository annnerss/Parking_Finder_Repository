package com.kh.parking.coupon.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.parking.member.model.vo.Member;

@Service
public interface CouponService {

	//쿠폰 등록
	int couponInsert(String string, String couponCode);

	//쿠폰 리스트
	List<Map<String, Object>> couponList(String memId);

	//회원가입시 쿠폰 자동 쿠폰 발급
	void welcomeCoupon(String memId);



}