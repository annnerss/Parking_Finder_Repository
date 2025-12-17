package com.kh.parking.reservation.model.vo;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data 
@Builder
public class Payment {
	private String pyId;
	private String pyType;
	private int price;
	private Date pyDate;
	private int reservationNo;
	private String status;
}