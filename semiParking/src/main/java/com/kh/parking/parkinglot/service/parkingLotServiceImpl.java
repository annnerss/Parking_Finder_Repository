package com.kh.parking.parkinglot.service;

import com.kh.parking.parkinglot.dao.parkingLotDao;
import com.kh.parking.reservation.model.vo.Reservation;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
