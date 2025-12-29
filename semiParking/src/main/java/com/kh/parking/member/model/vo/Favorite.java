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
public class Favorite {
	private String refMid;	//	REF_MID VARCHAR2(20) REFERENCES MEMBER(MEM_ID) NOT NULL,
	private int pno;	//    P_NO NUMBER CONSTRAINT P_NO_FK REFERENCES PARKING(P_NO) NOT NULL,  
	private Date faDate;	//    FA_DATE DATE DEFAULT SYSDATE
}