package com.kh.parking.parkinglot.model.service;

import com.kh.parking.parkinglot.model.dao.parkingLotDao;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class parkingLotServiceImpl implements parkingLotService{
    @Autowired
    private parkingLotDao dao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int reserve(Reservation reservation) {

        return dao.reserve(sqlSession, reservation);
    }

    @Override
    public List<ParkingLot> ParkingList() {

        return dao.ParkingList(sqlSession);
    }

    @Override
    public ParkingLot parkingDetail(String parkingNo) {

        return dao.ParkingDetail(sqlSession, parkingNo);
    }

    @Override
    public int currentUpdate() {

        return dao.currentUpdate(sqlSession);
    }
}
