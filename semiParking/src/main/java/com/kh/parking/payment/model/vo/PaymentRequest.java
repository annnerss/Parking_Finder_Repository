package com.kh.parking.payment.model.vo;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;


public class PaymentRequest {
	
	@Data
    @Builder
    @AllArgsConstructor(access = AccessLevel.PROTECTED)
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class OrderRequest {
		String partner_order_id;
		String partner_user_id;
        String parkingName;
        String parkingNo;
        int total_amount;
    }
}
