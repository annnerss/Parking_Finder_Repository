package com.kh.parking.common.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.parking.parkinglot.model.service.parkingLotService;

@Service
public class Scheduler {

    @Autowired
    private parkingLotService service;

    @Scheduled(cron = "*/5 * * * * *")
    public void currentUpdate(){
        service.currentUpdate();
        service.expireUpdate();
    }
}
