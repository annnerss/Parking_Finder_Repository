package com.kh.parking.parkinglot.model.dao;

import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class parkingLotDao {
    public int reserve(SqlSessionTemplate sqlSession, Reservation reservation) {

        return sqlSession.insert("reserveMapper.reserve",reservation);
    }

    public List<ParkingLot> ParkingList(SqlSessionTemplate sqlSession) {

        return sqlSession.selectList("parkingMapper.parkingList");
    }

    public ParkingLot ParkingDetail(SqlSessionTemplate sqlSession, String parkingNo) {

        return sqlSession.selectOne("parkingMapper.parkingDetail",parkingNo);
    }

    public int currentUpdate(SqlSessionTemplate sqlSession) {

        return sqlSession.update("parkingMapper.currentUpdate");
    }
}
