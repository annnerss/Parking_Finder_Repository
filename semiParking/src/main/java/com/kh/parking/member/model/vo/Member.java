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
public class Member {
		private String memId; 			//	MEM_ID VARCHAR2(20) CONSTRAINT MEM_ID_PK PRIMARY KEY, 
		private String memName; 				//    MEM_NAME VARCHAR2(20) NOT NULL, 
		private String memPwd; 	 		//    MEM_PWD  VARCHAR2(100) NOT NULL,  
		private String vehicleId;				//    VEHICLE_ID VARCHAR2(20) NOT NULL,
		private String email;				//    EMAIL VARCHAR2(50), 
		private String phoneNum;				//    PHONENUM VARCHAR2(13), 
		private String status;				//    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL,
		private Date lastLogin;				//    LAST_LOGIN DATE 
}