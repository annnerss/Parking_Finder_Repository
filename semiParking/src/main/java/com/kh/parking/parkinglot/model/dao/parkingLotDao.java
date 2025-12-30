package com.kh.parking.parkinglot.model.dao;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.payment.model.vo.PaymentApprove;
import com.kh.parking.reservation.model.vo.Reservation;

@Repository
public class parkingLotDao {
    public int reserve(SqlSessionTemplate sqlSession, Reservation reservation) {
        return sqlSession.insert("reserveMapper.reserve",reservation);
    }

    public List<ParkingLot> ParkingList(SqlSessionTemplate sqlSession) {
        return sqlSession.selectList("parkingMapper.parkingList");
    }
    
	public List<ParkingLot> ParkingList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (List)sqlSession.selectList("parkingMapper.parkingListView",null,rowBounds);
	}
	
	public int listCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("parkingMapper.listCount");
	}
	
	public ParkingLot ParkingDetail(SqlSessionTemplate sqlSession, String parkingNo) {
		return sqlSession.selectOne("parkingMapper.parkingDetail",parkingNo);
	}
	
	public int updateParking(SqlSessionTemplate sqlSession, ParkingLot p) {
		return sqlSession.update("parkingMapper.updateParking",p);
	}
	
	public int deleteParking(SqlSessionTemplate sqlSession, String pNo) {
		return sqlSession.update("parkingMapper.deleteParking",pNo);
	}
	
	public int insertPayment(SqlSessionTemplate sqlSession,PaymentApprove approve) {
		return sqlSession.insert("reserveMapper.insertPayment",approve);
	}
	
	public List<ParkingLot> searchParking(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectList("parkingMapper.searchParking",keyword);
	}
	
	public Reservation reserveDetail(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.selectOne("reserveMapper.reserveDetail", rNo);
	}
	
	public ArrayList<Reservation> reserveList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reserveMapper.reserveList");
	}

	public int deleteReserve(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("reserveMapper.deleteReserve",rNo);
	}
	
	public int deletePayment(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("reserveMapper.deletePayment",rNo);
	}
	
	public ArrayList<Reservation> reservePage(SqlSessionTemplate sqlSession, String memId) {
        return (ArrayList)sqlSession.selectList("reserveMapper.reservationPage",memId);
    }

	public int getRno(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reserveMapper.getRno");
	}

	public void currentUpdate(SqlSessionTemplate sqlSession) {
		sqlSession.update("parkingMapper.currentUpdate");			
	}

	public int deletePost(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("reserveMapper.deletePost",rNo);
	}

    
}