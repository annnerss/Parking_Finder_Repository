package com.kh.parking.qna.model.vo;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data 
@Builder
public class Reply {
	private int replyNo;
	private String replyContent;
	private Date createDate;
	private String status;
	private int refQno;
}