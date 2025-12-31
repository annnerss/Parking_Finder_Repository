package com.kh.parking.payment.controller;
import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.payment.model.service.PaymentServiceImpl;
import com.kh.parking.payment.model.vo.PaymentApprove;
import com.kh.parking.payment.model.vo.PaymentRequest.OrderRequest;
import com.kh.parking.payment.model.vo.ReadyResponse.ReadyRes;
import com.kh.parking.payment.model.vo.SessionUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentController {
	//payment 객체 준비
	@Autowired
	private PaymentServiceImpl kakaoPayService;
	
	@ResponseBody
	@PostMapping("/ready")
    public ReadyRes payReady(@RequestBody OrderRequest request) {
        //결제 요청 객체 변수 값 받기
		ReadyRes readyRes = kakaoPayService.payReady(request);
        return readyRes;
    }

    @GetMapping("/approve")
    public PaymentApprove payCompleted(@RequestParam("pg_token") String pgToken, HttpSession session,Model model) {
        String tid = SessionUtil.getStringAttribute("tid");
        log.info("결제 고유번호: " + tid);
        
        PaymentApprove approve = kakaoPayService.payApprove(pgToken);
        
        //받아온 approve객체를 payment db에 데이터 추가
        int result = kakaoPayService.insertPayment(approve);
        
        if(result > 0) {
        	Date rStartDate = kakaoPayService.rStartDate(Integer.parseInt(approve.getPartner_order_id()));
        	System.out.println(rStartDate);
        	model.addAttribute("pay",approve);
        	model.addAttribute("rStartDate",rStartDate);
        	session.setAttribute("alertMsg", "결제 성공");
        }else {
        	session.setAttribute("alertMsg", "결제 실패");
        }
        
        return approve;
    }
}
