package com.kh.parking.qna.service;

import java.util.ArrayList;
import org.springframework.stereotype.Service;

import com.kh.parking.common.model.vo.PageInfo;
import com.kh.parking.qna.model.vo.Qna;

@Service
public interface QnaService {

	//문의사항 총 개수
	int listCount();
	
	//문의사항 목록 조회
	ArrayList<Qna> qnaListView(PageInfo pi);

}
