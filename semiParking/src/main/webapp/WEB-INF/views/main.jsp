<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Parking Finder</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<style>
	    body {
	        font-family: "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;
	        background-color: #F5F6F8;
	    }
	
	    .search-wrap {
	        width: 500px;
	        margin: 20px auto;
	        position: relative;
	    }
	
	    .search-title {
	        font-size: 20px;
	        font-weight: 700;
	        margin-bottom: 15px;
	    }
	
	    .search-box {
	        display: flex;
	        gap: 10px;
	    }
	
	    #keyword {
	        flex: 1;
	        padding: 12px 14px;
	        font-size: 15px;
	        border-radius: 8px;
	        border: 1px solid #ccc;
	    }
	
	    .search-box button {
	        padding: 12px 18px;
	        border-radius: 8px;
	        border: none;
	        background-color: #3B82F6;
	        color: white;
	        font-weight: 600;
	        cursor: pointer;
	    }
	
	    .search-box button:hover {
	        background-color: #2563EB;
	    }
	
	    /* :작은_아래쪽_화살표: 검색 기록 드롭다운 */
	    #searchHistory {
	        position: absolute;
	        top: 110%;
	        width: 100%;
	        background-color: #fff;
	        border-radius: 10px;
	        box-shadow: 0 8px 20px rgba(0,0,0,0.12);
	        padding: 12px;
	        display: none;
	        max-height: 220px;
	        overflow-y: auto;
	        z-index: 100;
	    }
	
	    #searchHistory ul {
	        list-style: none;
	        padding: 0;
	        margin: 0;
	    }
	
	    #searchHistory li {
	        padding: 10px 12px;
	        font-size: 14px;
	        border-radius: 6px;
	        cursor: pointer;
	        display: flex;
	        justify-content: space-between;
	        color: #333;
	    }
	
	    #searchHistory li:hover {
	        background-color: #F1F5F9;
	    }
	
	    .history-date {
	        font-size: 12px;
	        color: #999;
	        margin-left: 10px;
	        white-space: nowrap;
	    }
	
	    .empty-history {
	        text-align: center;
	        font-size: 14px;
	        color: #888;
	        padding: 20px 0;
	    }
	
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	<div class="search-wrap">
	    <div class="search-title">주차장 검색</div>
	
		<!-- 검색 내용은 감출 이유가 없으니 get으로 -->
	    <form action="${contextRoot}/search.parking" method="get">
	        <div class="search-box">
	            <input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
	            <button type="submit">검색</button>
	        </div>
	    </form>
	    
	    <!-- 검색 기록 -->
	    <!-- 검색 했던 목록들을 보여주기 위한 태그 -->
	    <div id="searchHistory"></div>
	
	   
	</div>
	
	<!-- 지도 불러오기 -->
	<%@ include file="/WEB-INF/views/parkingMap/parkingMap.jsp" %>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<script>
	$(function(){
	
	    let memId = "${loginMember != null ? loginMember.memId : ''}"; // 세션에서 갖고온 로그인 멤버에 대한 조회
	
	    //동적인 요소에 이벤트 걸기 (11시 44분에 추가)
	    $("#searchHistory").on("mousedown", "span", function () {
	        $("#keyword").val($(this).text());
	        $("#searchHistory").slideUp();
	    });
	   
	    $("#keyword").click(function(){ // 클릭을 했을땐 다 보이게끔
	
	    	let value = $(this).val(); // ajax안에 넣으면 의도한 대로 값이 나오지 않음.
	    	
	        $.ajax({
	            url : "searchList.parking",
	            data : { memId : memId },
	            success : function(list){
	            	
	            	if(value.length!==0) { // 만약 검색 내용란에 입력한게 있으면 키워드에 맞게 나온 내용들 안지우기
	            		$("#searchHistory").slideDown(); // 슬라이드 다운 냅두기 만약 안걸어주면 목록 안보임
	                	return;
	                }
	
	                $("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
	                // 따라서 비워주는 역할을 해두는게 좋다.
	               
	                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
	                    $("#searchHistory").html(
	                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
	                    );
	               
	                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
	                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
	                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
	                    return;
	                }
	
	                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.
	
	                for(let h of list){
	                    if(h.searchContent){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
	                        ul.append(
	                            $("<li>")
	                                .append("<span>" + h.searchContent + "</span>")
	                                .append("<span class='history-date'>" + h.hDate + "</span>") //검색 내용 및 날짜를 띄우게 하기
	                        );
	                    }
	                }
	                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기
	            },
	           
	            error : function(){
	                 console.log("통신 실패!");
	            }
	        });
	    });
	
	    $("#keyword").blur(function(){
	        $("#searchHistory").slideUp();
	    });
	   
	    $("#keyword").on("input",function(){
	    	let value = $(this).val(); // 입력할때의 검색 내용 길이
	    	if(value.length===0) { // 입력한 내용이 아예 없을때
	    		$.ajax({
		            url : "searchList.parking",
		            data : { memId : memId },
		            success : function(list){
		                $("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
		                // 따라서 비워주는 역할을 해두는게 좋다.
		               
		                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
		                    $("#searchHistory").html(
		                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
		                    );
		                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
		                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
		                   
		                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
		                    return;
		                }
		
		                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.

		                for(let h of list){
		                    if(h.searchContent){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
		                        ul.append(
		                            $("<li>")
		                                .append("<span>" + h.searchContent + "</span>")
		                                .append("<span class='history-date'>" + h.hDate + "</span>") //검색 내용 및 날짜를 띄우게 하기
		                        );
		                    }
		                }
		
		                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기
		            },
		           
		            error : function(){
		                 console.log("통신 실패!");
		            }
		        });
	    	} else {
	    		 if (value.trim().length < 2) { // 이게 문제가 두글자를 입력할때 예를 들어, 대로를 입력하면 대로 라는 키워드만 포함되서 나와야하는데
	    			  //입력할때 대를 먼저 입력하니까 대에 대한것도 나온다..
	    			  //그래서 두글자 이상으로 걸어두었다. (물론 공백 제외)
	    		      $("#searchHistory")
	    		          .html("<div class='empty-history'>두 글자 이상 입력하세요</div>")
	    		          .slideDown();
	    		      return;
	    		 }
	    		
	    		$.ajax({
	    			url : "searchKeywordParking.parking",
	    			data : { value : value },
	    			success : function(list) {
	    				// 이제 목록을 어떻게 넣는가? 이게 문제.
	    				console.log("통신 성공!");		
	    			    console.log(list);
	    						
	    				$("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
	    				
		                // 따라서 비워주는 역할을 해두는게 좋다.
		               
		                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
		                    $("#searchHistory").html(
		                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
		                    );
		                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
		                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
		                   
		                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
		                    return;
		                }
		
		                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.
		
		                for(let h of list){
		                    if(h.parkingName){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
		                        ul.append(
		                            $("<li>")
		                                .append("<span>" + h.parkingName + "</span>")
		                                 //검색 내용 및 날짜를 띄우게 하기
		                        );
		                    }
		                }
		                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기 		
	    			},
	    			
	    			error : function(){
		                 console.log("통신 실패!");
		            }
	    		});
	    	}
	    	
	    });
	    
	    $("#searchHistory").on("mousedown", "li", function () {
	        let selectedText = $(this).find("span").first().text();
	        // 입력창 값 세팅
	        $("#keyword").val(selectedText);
	        // 현재 목록 중 선택한 값과 다른 li 제거
	        $("#searchHistory li").each(function () {
	            let text = $(this).find("span").first().text();
	            if (text !== selectedText) {
	                $(this).remove();
	            }
	        });
	    });
	});
	</script>
</body>
</html>

