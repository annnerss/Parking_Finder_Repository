package com.kh.parking.common.scheduler;

import com.kh.parking.parkinglot.model.service.parkingLotServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class Scheduler {

    @Autowired
    private parkingLotServiceImpl service;

    @Scheduled(cron = "*/5 * * * * *")
    public void currentUpdate(){
        service.currentUpdate();

        System.out.println(new java.util.Date()+"주차장 현황 갱신");
    }
}
