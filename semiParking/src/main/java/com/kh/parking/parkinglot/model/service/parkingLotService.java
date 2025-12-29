package com.kh.parking.parkinglot.model.service;
import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;

import java.util.ArrayList;
import java.util.List;

public interface parkingLotService {
    List<ParkingLot> ParkingList(PageInfo pi);
    List<ParkingLot> ParkingList();
    ParkingLot parkingDetail(String parkingNo);
    int updateParking(ParkingLot p);
    int deleteParking(String pNo);
    int reserve(Reservation reservation);
	//Reservation reserveDetail(int rNo);
	ArrayList<Reservation> reserveList();
	int deleteReserve(int rNo);
	int deletePayment(int rNo);
	int listCount();
	int getRno();
	List<ParkingLot> searchParking(String keyword);
	void currentUpdate();
    ArrayList<Reservation> reservePage(String memId);
	int deletePost(int rNo);
}
