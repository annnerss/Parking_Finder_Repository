package com.kh.parking.payment.controller;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
//        String name = orderRequest.getItemName();
//        int totalPrice = orderRequest.getTotalPrice();
//        
//        //사이트가 실제로 운영될때 관리와 보안을 위한 로그에 남기기
//        log.info("주문 상품 이름: " + name);
//        log.info("주문 금액: " + totalPrice);

//        // 카카오 결제 준비하기
//        ReadyResponse readyResponse = kakaoPayService.payReady(name, totalPrice);
//        System.out.println("controller's readyresponse : "+readyResponse);
//        // 세션에 결제 고유번호(tid) 저장
//        SessionUtil.addAttribute("tid", readyResponse.getTid());
		ReadyRes readyRes = kakaoPayService.payReady(request);
        return readyRes;
    }

    @GetMapping("/approve")
    public PaymentApprove payCompleted(@RequestParam("pg_token") String pgToken, HttpSession session) {
        String tid = SessionUtil.getStringAttribute("tid");
        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);
        
        PaymentApprove approve = kakaoPayService.payApprove(pgToken);
        
        System.out.println("approve 정보 : "+approve);
        
        //받아온 approve객체를 payment db에 데이터 추가
        int result = kakaoPayService.insertPayment(approve);
        
        if(result > 0) {
        	session.setAttribute("alertMsg", "결제 성공");
        }else {
        	session.setAttribute("alertMsg", "결제 실패");
        }
        
        return approve;
    }
    
    @PostMapping("/fail")
    public void payFail() {
    	System.out.println("fail");
    }
    
    @PostMapping("/cancel")
    public void payCancel() {
    	System.out.println("cancel");
    }

}
