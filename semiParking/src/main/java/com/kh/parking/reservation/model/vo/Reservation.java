package com.kh.parking.reservation.model.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Reservation {
    private int reservationNo; //예약번호
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date startTime; //입차예약시간
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date endTime; //출차예약시간
    private String status; //상태여부(예약중/예약취소/주차완료?)
    private String parkingName; //주차장 이름
    private String parkingNo; //주차장 관리번호(외래키)
    private String memberId; //이용자 아이디(외래키)
}