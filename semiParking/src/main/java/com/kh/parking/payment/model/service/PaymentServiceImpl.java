package com.kh.parking.payment.model.service;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.kh.parking.payment.model.dao.PaymentDao;
import com.kh.parking.payment.model.vo.PaymentApprove;
import com.kh.parking.payment.model.vo.PaymentRequest.OrderRequest;
import com.kh.parking.payment.model.vo.ReadyResponse.ReadyRes;
import com.kh.parking.payment.model.vo.SessionUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@PropertySource("classpath:application.properties")
@Service
public class PaymentServiceImpl implements PaymentService {
	@Value("${kakaopay.secretKey}")
    private String secretKey;

    @Value("${kakaopay.cid}")
    private String cid;
    
    @Autowired
	private PaymentDao dao;
    
    @Autowired
	private SqlSessionTemplate sqlSession;
        
	// 카카오페이 결제창 연결
    @Override
    public ReadyRes payReady(OrderRequest request) {
    	System.out.println(request.getPartner_order_id());
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("cid", cid);                                    // 가맹점 코드(테스트용)
        parameters.put("partner_order_id", request.getPartner_order_id());   //예약 번호                    // 주문번호
        parameters.put("partner_user_id", request.getPartner_user_id());           // 회원 아이디
        parameters.put("item_name", request.getParkingName());        // 주차장 이름
        parameters.put("item_code", request.getParkingNo());			//주차장 번호
        parameters.put("quantity", "1");                                 // 상품 수량
        parameters.put("total_amount", String.valueOf(request.getTotal_amount()));    // 상품 총액
        parameters.put("tax_free_amount", "0");                                 // 상품 비과세 금액
        parameters.put("approval_url", "http://localhost:8080/parking/payment/approve"); // 결제 성공 시 URL
        parameters.put("cancel_url", "http://localhost:8080/parking/payment/cancel");      // 결제 취소 시 URL
        parameters.put("fail_url", "http://localhost:8080/parking/payment/fail");          // 결제 실패 시 URL
        // HttpEntity : HTTP 요청 또는 응답에 해당하는 Http Header와 Http Body를 포함하는 클래스        
        // RestTemplate
        // : Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
        //   REST API 호출 이후 응답을 받을 때까지 기다리는 동기 방식 (json, xml 응답)
        // RestTemplate의 postForEntity : POST 요청을 보내고 ResponseEntity로 결과를 반환받는 메소드
        
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(parameters, getHeaders());

        RestTemplate restTemplate = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";
        ResponseEntity<ReadyRes> response = restTemplate.postForEntity(url, entity, ReadyRes.class);
        SessionUtil.addAttribute("tid",Objects.requireNonNull(response.getBody()).getTid());
        SessionUtil.addAttribute("partner_order_id", Objects.requireNonNull(request.getPartner_order_id()));
        SessionUtil.addAttribute("partner_user_id", Objects.requireNonNull(request.getPartner_user_id()));
        SessionUtil.addAttribute("item_name", Objects.requireNonNull(request.getParkingName()));
        SessionUtil.addAttribute("item_code", Objects.requireNonNull(request.getParkingNo()));
        SessionUtil.addAttribute("total_amount", Objects.requireNonNull(request.getTotal_amount()));
        return response.getBody();
       
    }

    // 카카오페이 결제 승인
    // 사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
    // 최종적으로 결제 완료 처리를 하는 단계
    @Override
    public PaymentApprove payApprove(String pgToken) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", cid);              // 가맹점 코드(테스트용)
        parameters.put("tid", SessionUtil.getStringAttribute("tid"));                       // 결제 고유번호
        parameters.put("partner_order_id", SessionUtil.getStringAttribute("partner_order_id")); // 주문번호
        parameters.put("partner_user_id", SessionUtil.getStringAttribute("partner_user_id"));    // 회원 아이디
        parameters.put("pg_token", pgToken);              // 결제승인 요청을 인증하는 토큰
        
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(parameters, this.getHeaders());
        
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
        ResponseEntity<PaymentApprove> response = restTemplate.postForEntity(url, entity, PaymentApprove.class);
        response.getBody().setPartner_order_id(SessionUtil.getStringAttribute("partner_order_id"));
        response.getBody().setPartner_user_id(SessionUtil.getStringAttribute("partner_user_id"));
        response.getBody().setItem_name(SessionUtil.getStringAttribute("item_name"));
        response.getBody().setItem_code(SessionUtil.getStringAttribute("item_code"));
        response.getBody().setTotal_amount(SessionUtil.getIntAttribute("total_amount"));
        
        log.info("결제승인 응답객체: " + response);

        return response.getBody();
    }
    
 // 카카오페이 측에 요청 시 헤더부에 필요한 값
    @Override
    public HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + secretKey);
        headers.add("Content-Type", "application/json");

        return headers;
    }
    
    @Override
	public int insertPayment(PaymentApprove approve) {
		return dao.insertPayment(sqlSession,approve);
	}

	@Override
	public int deletePayment(String tid) {
		return 0;
	}
	
}
