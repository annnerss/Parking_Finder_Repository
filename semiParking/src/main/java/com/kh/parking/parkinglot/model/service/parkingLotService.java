package com.kh.parking.parkinglot.model.service;

import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;

import java.util.List;

public interface parkingLotService {
    int reserve(Reservation reservation);

    List<ParkingLot> ParkingList();

    ParkingLot parkingDetail(String parkingNo);
}