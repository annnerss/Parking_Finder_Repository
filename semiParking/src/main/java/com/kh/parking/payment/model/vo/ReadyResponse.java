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
	    String reservationNo;    // 가맹점 주문번호
	    String memId;     // 가맹점 회원 id
        String tid;
        String next_redirect_pc_url;
    }
}