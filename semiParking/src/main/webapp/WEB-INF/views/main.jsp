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
	        background-color: #f5f6f8;
	    }
	
	    .search-wrap {
	        width: 500px;
	        margin: 80px auto;
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
	        background-color: #3b82f6;
	        color: white;
	        font-weight: 600;
	        cursor: pointer;
	    }
	
	    .search-box button:hover {
	        background-color: #2563eb;
	    }
	
	    /* 🔽 검색 기록 드롭다운 */
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
	        background-color: #f1f5f9;
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
	
	    .favorite-link {
	        display: block;
	        text-align: right;
	        margin-top: 20px;
	    }
	
	    .favorite-link a {
	        text-decoration: none;
	        color: #ef4444;
	        font-weight: 600;
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
	
	
	<c:if test="${not empty loginMember}">
	      <div class="favorite-link">
	          <a href="${contextRoot}/favorites.parking">찜 목록</a>
	      </div>
	</c:if>
	
	<!-- 주차장 목록 데이터가 지금 당장은 없으니까 더미 데이터를 이용해서 테스트 해보기 찜이 잘되는지, 찜 목록에 들어가는지 등 보기 위함 -->
	<div>
    	<span>강남대로150길</span> <!-- 이건 주차장 목록이라고 생각. -->

		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.) -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000001">
	        	<button type="submit">❤️찜하기</button>
	    	</form>
    	</c:if>
	</div>
	
	<div>
    	<span>논현로131길</span>

		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.) -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000002">
	        	<button type="submit">❤️찜하기</button>
	    	</form>
    	</c:if>
	</div>
	
	<div>
    	<span>테헤란로69길</span>

		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.)  -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000003">
	        	<button type="submit">❤️ 찜하기</button>
	    	</form>
    	</c:if>
	</div>
	

	<script>
	$(function(){
	
	    let memId = "${loginMember != null ? loginMember.memId : ''}"; // 세션에서 갖고온 로그인 멤버에 대한 조회
	
	    $("#keyword").click(function(){ // 클릭을 했을땐 다 보이게끔 
	
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
	    });
	
	    $("#keyword").blur(function(){
	        $("#searchHistory").slideUp();
	    });
	
	});
	</script>

</body>
</html>