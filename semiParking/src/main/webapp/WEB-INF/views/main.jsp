<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parking Finder</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>    
    	.searchContainer{
    		padding-left:100px;
    	} 
        
        #searchHistory {
		    border: 1px solid black;
		    background-color: bisque;
		    margin-top: 5px;
		    padding: 10px;
		    display: none;
		    max-height: 200px; /* 최대 높이 제한 (스크롤 생김) */
		    overflow-y: auto;  /* 세로 스크롤 */
		}
		
		#searchHistory ul {
		    margin: 0;
		    padding: 0;
		}
		
		#searchHistory li {
		    list-style: disc;
		    margin: 2px 0;
		    font-size: 14px;
		    white-space: nowrap; /* 줄바꿈 방지 */
		    overflow: hidden;
		    text-overflow: ellipsis; /* 너무 길면 ... 처리 */
		}
    </style>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	<div class="searchContainer">
		<h3>검색</h3>
	
		<!-- 검색 내용은 감출 이유가 없으니 get으로 -->
		<form action="${contextRoot}/search.parking" method="get">
	  		<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요.">
	  		<button type="submit">검색</button>
		</form>
		
	    <div id="searchHistory" class="search-form">
				
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/parkingMap/parkingMap.jsp" %>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<script>
	  $(function(){
		  let memId = "${loginMember != null ? loginMember.memId : ''}"; // 세션에서 갖고온 로그인 멤버에 대한 조회
		  
		  $("#keyword").click(function(){ // 클릭을 했을땐 다 보이게끔 
			
			  $.ajax({
				  
				  url : "searchList.parking",
				  data : { // 서버로 보내는 요청 데이터 
					  //memId : "${loginMember.memId}"
					  memId : memId
				  },
				  
				  success : function(list) {
					  console.log("통신 성공!"); 
					  console.log(list); // 확인용 
					  
					  //if (!response || response.length === 0) { }
					  
					  $("#searchHistory").empty(); // 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
					  
					  // 따라서 비워주는 역할을 해두는게 좋다. 
					  
					  if(!list || list.length === 0) { // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
						  
						  $("#searchHistory").html("<span>검색 하신 기록이 없습니다.</span>"); 
					  
						  //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
						  
						  //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다. 
						  
						  $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기 
						  
				
					  } else {
						  
						  let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자. 
						  
						  //응답 데이터 요소에 추가하기 
						  for(let h of list) {
							  
							  console.log(h); 
							  
							  
							  
							  if(h.searchContent) { // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
								  
								  //동일한 내용이면 한번만 나오게 해야한다. 어떻게 해야할까?
										    		  
								  
								  ul.append($("<li>").text(h.searchContent + " | " + h.hdate));
								  
								  
								  //검색 내용 및 날짜를 띄우게 하기 
								  
								  $("#searchHistory").append(ul); 
								  
							  }
							  
							  
						  }
						  
						  
						  
						  //$("#searchHistory").css('display','block'); // DB에서 다 갖고왔으면 보이게하기 
						  
						  $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기 
					  }	  
					  
				  },
				  
				  error : function(){
					  console.log("통신 실패!");
				  }
				  
			  })

		  });
			
		  $("#keyword").blur(function(){ // 벗어나면 안보이게끔 
				
				//$("#searchHistory").css('display','none'); 
		  
			  	$("#searchHistory").slideUp();  
				
		  }); 
		  
		  
	  })
		
		
	</script>

	
</body>