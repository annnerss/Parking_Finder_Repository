package com.kh.parking.parkinglot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

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
import com.kh.parking.parkinglot.model.service.parkingLotService;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;

@Controller
public class parkingLotController {

    @Autowired
    private parkingLotService service;

    private static final String CLIENT_ID = "sdqbu1mss0";
    private static final String CLIENT_SECRET = "gB3zDQBDw94fmjDFgrjuqIkU54nIumIqBnozlHPQ";

    
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
    
    @ResponseBody
    @RequestMapping("parkingList.get")
    public List<ParkingLot> ParkingList(){
        List<ParkingLot> list = service.ParkingList();

        return list;
    }
    
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

    @ResponseBody
    @RequestMapping("parkingSearch.get")
    public List<ParkingLot> searchParkingList(String keyword){
        ArrayList<ParkingLot> list = service.searchParkingList(keyword);

        return list;
    }

    @GetMapping("/reservation.get")
    public String reservationForm(@RequestParam("parkingNo") String parkingNo, Model model) {
        ParkingLot parkingLot = service.parkingDetail(parkingNo);
        
        model.addAttribute("parkingLot", parkingLot);
        
        return "reservation/reservation";
    }

    @PostMapping("/reserve.port")
    public String reserve(Reservation reservation, @RequestParam(value = "price") int price, Model model) {
        //예약 정보를 넘겨서 예약이 성공한다면 예약 번호를 발급하고 결제정보를 리턴한다.

        int result = service.reserve(reservation);

        if(result > 0){
            model.addAttribute("price", price);
            model.addAttribute("reservation",reservation);
            return "payment/paymentForm";
        }else{
            model.addAttribute("alertMsg","오류");
            return "common/errorPage";
        }
    }
    
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
    
    @PostMapping("/delete.re")
    public String deleteReserve(int rNo,HttpSession session) {
    	int result = service.deleteReserve(rNo);
    	//int result2 = service.deletePayment(rNo);
    	
    	//if((result + result2) > 1) {
    	if(result > 0) {
    		session.setAttribute("alertMsg","예약이 성공적으로 삭제되었습니다");
    	}else {
    		session.setAttribute("alertMsg","예약 삭제를 실패했습니다");
    	}
    	
    	return "redirect:/reserveList.get";
    }
    
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

            System.out.println(response);
            return response.toString();

        } catch (Exception e){
            e.printStackTrace();
            return "{\"message\":\"error\"}";
        }
    }
}