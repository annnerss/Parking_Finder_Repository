package com.kh.parking.payment.model.service;

import java.sql.Date;

import org.springframework.http.HttpHeaders;

import com.kh.parking.payment.model.vo.PaymentApprove;
import com.kh.parking.payment.model.vo.PaymentRequest.OrderRequest;
import com.kh.parking.payment.model.vo.ReadyResponse.ReadyRes;

public interface PaymentService {
	ReadyRes payReady(OrderRequest request); //결제 요청 메소드
	PaymentApprove payApprove(String pgToken); //결제 확인 메소드
	HttpHeaders getHeaders(); //헤더 추가 메소드
	int insertPayment(PaymentApprove approve); //결제 내역 추가 메소드
	public Date rStartDate(int rNo);
}