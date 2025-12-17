package com.kh.parking.member.model.vo;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data 
@Builder
public class MemberCoupon {
	private String memId;
	private String refCid;
	private Date issueDate;
	private Date expireDate;
	private String status;
}
