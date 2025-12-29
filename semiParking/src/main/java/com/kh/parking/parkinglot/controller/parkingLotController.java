package com.kh.parking.parkinglot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.common.template.Pagination;
import com.kh.parking.member.model.vo.Member;
import com.kh.parking.parkinglot.model.service.parkingLotService;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;

@Controller
public class parkingLotController {

    @Autowired
    private parkingLotService service;

    private static final String CLIENT_ID = "sdqbu1mss0";
    private static final String CLIENT_SECRET = "gB3zDQBDw94fmjDFgrjuqIkU54nIumIqBnozlHPQ";

    @RequestMapping("/service.pk")
    public String servicePage() {
    	return "/parkingMap/service";
    }
    
    //관리자용 주차장 디테일
    @GetMapping("/parkingDetail.get")
    public String parkingLotDetail(@RequestParam("pNo") String pNo,
    								Model model,
    								HttpServletRequest request,
    								HttpSession session) {
    	ParkingLot parkingLot = service.parkingDetail(pNo);
    	
    	if(parkingLot != null) {
    		model.addAttribute("p",parkingLot);
    		return "parkingMap/parkingLotDetail";
    	}else {
    		session.setAttribute("alertMsg","주차장 상세 내역 조회 실패");
    		return "redirect:/" + request.getHeader("referer");
    	}
    }
    
  //관리자용 주차장 리스트
    @RequestMapping("/parkingListView.get")
    public String ParkingListView(@RequestParam(value="page",defaultValue="1") int currentPage, Model model, HttpSession session){
    	int listCount = service.listCount();
    	int boardLimit = 10;
    	int pageLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
    	
    	List<ParkingLot> pList = service.ParkingList(pi);
    	
    	
    	if(pList != null) {
    		model.addAttribute("pList",pList);
    		model.addAttribute("pi",pi);
    	}else {
    		session.setAttribute("alertMsg", "주차장 목록 조회 실패");
    	}
    	
        return "parkingMap/parkingLotList";
    }
    
    //메인페이지용 주차장 리스트
    @ResponseBody
    @RequestMapping("parkingList.get")
    public List<ParkingLot> ParkingList(){
        List<ParkingLot> list = service.ParkingList();

        return list;
    }
    
    //관리자용 주차장 수정
    @PostMapping("/parkingUpdate.pk")
    public String parkingUpdate(ParkingLot p,HttpSession session) {
    	int result = service.updateParking(p);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg","주차장이 성공적으로 수정되었습니다");
    	}else {
    		session.setAttribute("alertMsg","주차장 수정을 실패했습니다");
    	}
    	
    	return "redirect:/parkingDetail.get?pNo="+p.getParkingNo();
    }
    
  //관리자용 주차장 삭제
    @PostMapping("/parkingDelete.pk")
    public String parkingDelete(String pNo,HttpSession session) {
    	int result = service.deleteParking(pNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg","주차장이 성공적으로 삭제되었습니다");
    		return "redirect:/parkingListView.get";
    	}else {
    		session.setAttribute("alertMsg","주차장 삭제를 실패했습니다");
    		return "redirect:/parkingDetail.get?pNo="+pNo;
    	}
    }
    
    //회원 예약 내역
    @GetMapping("/reservation.get")
    public String reservationForm(@RequestParam("parkingNo") String parkingNo, HttpSession session) {
        ParkingLot parkingLot = service.parkingDetail(parkingNo);
        Member loginMember = (Member) session.getAttribute("loginMember");

        session.setAttribute("parkingLot", parkingLot);
        session.setAttribute("loginMember",loginMember);

        return "reservation/reservation";
    }

    //회원 예약 결제 페이지
    @PostMapping("/reserve.port")
    public String reserve(Reservation reservation, @RequestParam(value = "price") int price, Model model) {
        //예약 정보를 넘겨서 예약이 성공한다면 예약 번호를 발급하고 결제정보를 리턴한다.
        int result = service.reserve(reservation);

        if(result > 0){
        	reservation.setReservationNo(service.getRno());
        	model.addAttribute("price", price);
            model.addAttribute("reservation",reservation);
            return "payment/paymentForm";
        }else{
            model.addAttribute("alertMsg","오류");
            return "common/errorPage";
        }
    }
    
    @RequestMapping("/reservePage.get")
    public String reservePage(HttpSession session) {
        Member m = (Member) session.getAttribute("loginMember");

        ArrayList<Reservation> list = service.reservePage(m.getMemId());

        if(list != null) {
            session.setAttribute("list",list);
        }else {
            session.setAttribute("alertMsg", "예약 정보 불러오기 실패");
        }

        return "reservation/myReservation";
    }
    
    //관리자용 예약 목록 조회
    @RequestMapping("/reserveList.get")
    public String paymentListPage(Model model,HttpSession session) {
    	ArrayList<Reservation> rList = service.reserveList();
    	
    	if(rList != null) {
    		model.addAttribute("rList",rList);
    	}else {
    		session.setAttribute("alertMsg", "예약 정보 불러오기 실패");
    	}
    	
    	return "reservation/reservationList";
    }
    
  //관리자용 예약 목록 삭제
    @PostMapping("/delete.re")
    @ResponseBody
    public Map<String,String> deleteReserve(int rNo,HttpSession session) {
    	Map<String,String> res = new HashMap<>();
    	int result = service.deleteReserve(rNo);
    	int result2 = service.deletePayment(rNo);
    	
    	if((result + result2) > 1) {
    		res.put("status", "success");
    		res.put("message", "예약이 삭제 되었습니다");
    	}else {
    		res.put("status", "fail");
    		res.put("message", "예약 삭제를 실패했습니다");
    	}
    	
    	return res;
    }
    
    //메인 페이지 경로 조회
    @ResponseBody
    @GetMapping(value= "/getRoute.get", produces = "application/json; charset=UTF-8")
    public String getRoute(@RequestParam String start, @RequestParam String goal){
        try {
        	String apiUrl = "https://maps.apigw.ntruss.com/map-direction/v1/driving";
            String query = "?goal=" + goal + "&start=" + start + "&option=trafast"; // trafast: 실시간 빠른길

            URL url = new URL(apiUrl + query);

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", CLIENT_ID);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", CLIENT_SECRET);

            int responseCode = con.getResponseCode();
            BufferedReader br;

            if(responseCode == 200){
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            }else{
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null){
                response.append(inputLine);
            }
            br.close();

            return response.toString();

        } catch (Exception e){
            e.printStackTrace();
            return "{\"message\":\"error\"}";
        }
    }
    
    //관리자용 주차장 검색
    @ResponseBody
    @RequestMapping(value="/searchParking.pk", produces="application/json;charset=UTF-8")
    public List<ParkingLot> searchParking(String keyword){
    	List<ParkingLot> pList = service.searchParking(keyword);
    	return pList;
    }
}