package com.kh.parking.parkinglot.controller;

import com.kh.parking.parkinglot.model.service.parkingLotService;
import com.kh.parking.parkinglot.model.vo.ParkingLot;
import com.kh.parking.reservation.model.vo.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@Controller
public class parkingLotController {

    @Autowired
    private parkingLotService service;

    private static final String CLIENT_ID = "sdqbu1mss0";
    private static final String CLIENT_SECRET = "gB3zDQBDw94fmjDFgrjuqIkU54nIumIqBnozlHPQ";

    @GetMapping("/parkingMap.get")
    public String parkingMap() {
        return "parkingMap/parkingMap";
    }

    @ResponseBody
    @RequestMapping("parkingList.get")
    public List<ParkingLot> ParkingList(){
        List<ParkingLot> list = service.ParkingList();

        for(ParkingLot lot : list){
            System.out.println(lot);
        }
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

        ParkingLot parkingLot = service.parkingDetail(reservation.getParkingNo());

        if(result > 0){
            model.addAttribute("price", price);
            model.addAttribute("parkingLot", parkingLot);
            return "payment/payment";
        }else{
            model.addAttribute("alertMsg","오류");
            return "common/errorPage";
        }
    }

    @ResponseBody
    @GetMapping(value= "/getRoute.get", produces = "application/json; charset=UTF-8")
    public String getRoute(@RequestParam String start, @RequestParam String goal){
        try {
            String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving";
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
}