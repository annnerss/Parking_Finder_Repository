package com.kh.parking.review.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data 
@Builder
public class Attachment {
	private int fileNo;
	private int refRno;
	private String originName;
	private String changeName;
	private String filePath;
	private Date uploadDate;
	private String status;
	
}