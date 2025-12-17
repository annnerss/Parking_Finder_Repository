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
public class History {
	private String refMid;				//	REF_MID VARCHAR2(20) CONSTRAINT REF_MID_FK REFERENCES MEMBER(MEM_ID) NOT NULL,
	private String searchContent;				//    SEARCH_CONTENT VARCHAR2(100),
	private Date hDate;				//    H_DATE DATE DEFAULT SYSDATE
}
