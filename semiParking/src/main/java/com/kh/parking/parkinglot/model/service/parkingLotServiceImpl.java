package com.kh.parking.parkinglot.model.service;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.parkinglot.model.dao.parkingLotDao;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;

@Service
public class parkingLotServiceImpl implements parkingLotService{
    @Autowired
    private parkingLotDao dao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public List<ParkingLot> ParkingList() {
        return dao.ParkingList(sqlSession);
    }
    
    @Override
    public List<ParkingLot> ParkingList(PageInfo pi) {
    	return dao.ParkingList(sqlSession,pi);
    }
    
    @Override
    public int listCount() {
    	return dao.listCount(sqlSession);
    }

    @Override
    public ArrayList<Reservation> reservePage(String memId) {
        return dao.reservePage(sqlSession, memId);
    }

    @Override
    public ParkingLot parkingDetail(String parkingNo) {
        return dao.ParkingDetail(sqlSession, parkingNo);
    }
    
	@Override
	public int updateParking(ParkingLot p) {
		return dao.updateParking(sqlSession,p);
	}

	@Override
	public int deleteParking(String pNo) {
		return dao.deleteParking(sqlSession,pNo);
	}
    
    @Override
    public int reserve(Reservation reservation) {
    	return dao.reserve(sqlSession, reservation);
    }

//	@Override
//	public Reservation reserveDetail(int rNo) {
//		return dao.reserveDetail(sqlSession,rNo);
//	}

	@Override
	public ArrayList<Reservation> reserveList() {
		return dao.reserveList(sqlSession);
	}

	@Override
	public int deleteReserve(int rNo) {
		return dao.deleteReserve(sqlSession,rNo);
	}
	
	@Override
	public int deletePayment(int rNo) {
		return dao.deletePayment(sqlSession,rNo);
	}

	@Override
	public List<ParkingLot> searchParking(String keyword) {
		return dao.searchParking(sqlSession,keyword);
	}

	@Override
	public int getRno() {
		return dao.getRno(sqlSession);
	}

	@Override
	public void currentUpdate() {
		dao.currentUpdate(sqlSession);
	}

	@Override
	public int deletePost(int rNo) {
		return dao.deletePost(sqlSession,rNo);
	}

}