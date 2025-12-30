package com.kh.parking.review.model.vo;
import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data 
@Builder
public class Review {
	private int rNo;
	private String memId;
	private int point;
	private String pNo;
	private String content;
	private String originName;
	private String changeName;
	private Date createDate;
	private String status;
	
	private List<Attachment> attachmentList; 
}