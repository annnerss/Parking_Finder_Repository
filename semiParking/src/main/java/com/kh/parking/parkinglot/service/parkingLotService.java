package com.kh.parking.parkinglot.service;

import com.kh.parking.reservation.model.vo.Reservation;

public interface parkingLotService {
    int reserve(Reservation reservation);
}
