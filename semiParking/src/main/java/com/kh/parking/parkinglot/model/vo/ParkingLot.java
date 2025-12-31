package com.kh.parking.parkinglot.model.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ParkingLot {
    private String parkingNo; //주차장 관리 번호
    private String parkingName; //주차장이름
    private double location_X; //위도
    private double location_Y; //경도
    private int total; //총 구획수
    private int current;//주차가능한 구획 수
    private Date openTime; //여는시간
    private Date closeTime; //닫는시간
    private int price; //기본요금
    private int priceTime; //시간당 요금
    private String phone; //연락처
    private String status; //운영 여부
}