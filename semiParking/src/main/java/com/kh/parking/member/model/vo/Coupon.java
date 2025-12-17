package com.kh.parking.member.model.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data 
@Builder
public class Coupon {
	private String cId;
	private double discount;
	private String status;
}