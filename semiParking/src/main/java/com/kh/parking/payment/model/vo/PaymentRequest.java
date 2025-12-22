package com.kh.parking.payment.model.vo;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;


public class PaymentRequest {
	
	@Getter
    @Builder
    @AllArgsConstructor(access = AccessLevel.PROTECTED)
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class OrderRequest {
		int reservationNo;
		String memberId;
        String parkingName;
        String parkingNo;
        int totalPrice;
    }
}
