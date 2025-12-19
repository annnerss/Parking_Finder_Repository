package com.kh.parking.member.model.vo;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data

//검색 히스토리 클래스 (3개 ~ 5개) 
public class History {
	private String refMid;	//회원 아이디 (외래키)			//	REF_MID VARCHAR2(20) CONSTRAINT REF_MID_FK REFERENCES MEMBER(MEM_ID) NOT NULL,
	private String searchContent; // 검색 내용			 	//    SEARCH_CONTENT VARCHAR2(100),
	private Date hDate;  //검색한 날짜				//    H_DATE DATE DEFAULT SYSDATE
}
