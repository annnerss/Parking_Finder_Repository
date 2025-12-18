package com.kh.parking.parkinglot.dao;

import com.kh.parking.reservation.model.vo.Reservation;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class parkingLotDao {
    public int reserve(SqlSessionTemplate sqlSession, Reservation reservation) {

        return sqlSession.insert("reserveMapper.reserve",reservation);
    }
}
