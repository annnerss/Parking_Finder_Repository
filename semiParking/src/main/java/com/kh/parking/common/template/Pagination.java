package com.kh.parking.common.template;

import com.kh.parking.common.model.vo.PageInfo;

public class Pagination {
	
	//페이징 처리용 PageInfo 객체에 필드를 담아주는 메소드 (계산처리까지)
	
	public static PageInfo getPageInfo(int listCount,int currentPage
									  ,int qnaLimit,int pageLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount/qnaLimit);
		int startPage = (currentPage-1)/pageLimit*pageLimit+1;
		int endPage = startPage+pageLimit-1;
		
		//endPage가 maxPage보다 클때
		if(maxPage<endPage) {
			endPage = maxPage;
		}
		
		PageInfo pi2 =	PageInfo.builder()
								.listCount(listCount)
							    .currentPage(currentPage)
							    .qnaLimit(qnaLimit)
							    .pageLimit(pageLimit)
							    .maxPage(maxPage)
							    .startPage(startPage)
							    .endPage(endPage)
							    .build(); 
		return pi2;
	}
	
}
