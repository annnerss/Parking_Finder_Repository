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
public class Qna {
	private int qNo;
	private int qType;
	private String qTitle;
	private String content;
	private Date createDate;
	private String status;
	private String memId;
	private int pNo;
}