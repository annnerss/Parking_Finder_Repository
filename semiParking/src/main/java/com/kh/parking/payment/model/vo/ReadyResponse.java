package com.kh.parking.payment.model.vo;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class ReadyResponse {
	@Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ReadyRes {
//	    String partner_order_id;    // 가맹점 주문번호
//	    String partner_user_id;     // 가맹점 회원 id
        String tid;
        String next_redirect_pc_url;
    }
}