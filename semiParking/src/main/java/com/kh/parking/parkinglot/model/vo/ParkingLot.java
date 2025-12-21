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
    private String parkingNo; // pNo -> parkingNo로 수정 
    private String parkingName; 
    private double location_X; 
    private double location_Y; 
    private int total; 
    private int current;
    private Date openTime; 
    private Date closeTime; 
    private int price; 
    private int priceTime; 
    private String phone; 
    private String status;
    
   
    
    
}
