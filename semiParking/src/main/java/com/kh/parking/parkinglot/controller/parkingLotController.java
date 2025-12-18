package com.kh.parking.parkinglot.controller;

import com.kh.parking.parkinglot.service.parkingLotService;
import com.kh.parking.reservation.model.vo.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class parkingLotController {

    @Autowired
    private parkingLotService service;

    @GetMapping("/parkingMap.get")
    public String parkingMap() {
        return "parking/parkingMap";
    }

    @GetMapping("/reservation.get")
    public String reservationForm(@RequestParam("parkingName") String parkingName, Model model) {
        model.addAttribute("parkingName", parkingName);
        return "reservation/reservation";
    }

    @PostMapping("/reserve.port")
    public String reserve(Reservation reservation, int price, Model model) {
        //예약 정보를 넘겨서 예약이 성공한다면 예약 번호를 발급하고 결제정보를 리턴한다.

        int result = service.reserve(reservation);

        if(result > 0){
            model.addAttribute("price", price);
            return "payment/payment";
        }else{
            model.addAttribute("alertMsg","오류");
            return "common/errorPage";
        }
    }
}