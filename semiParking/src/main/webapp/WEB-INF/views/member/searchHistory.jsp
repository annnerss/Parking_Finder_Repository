<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
     <style>     
        #searchHistory{
            border: 1px solid black;
            background-color: bisque;
            height: 100px;
            margin-top : 5px;
            padding: 10px;

            /*검색 목록 처음엔 안보여주기 검색 창에 마우스를 갖다 대야 보이게끔.*/ 
            display: none; 
        }
    </style>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>

	<h2>검색</h2>
	
	<form action="${contextRoot}/search.parking" method="get">
  		<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요.">
  		<button class="btn" type="submit">검색</button>
	</form>
	
	<div id="searchHistory" class="search-form">
		<!-- 여기엔 for-each문 작성  -->
		<ul> <!-- 여기에 검색한 목록들 받아 오기-->
			<li>${history.searchContent}</li> <!-- 문자열 처리? 해야하나 말아야하나  -->
		</ul>
	</div>
	
	<script>
		$("#keyword").click(function(){ // 클릭을 했을땐 다 보이게끔 
			
			$("#searchHistory").css('display','block');
			
			
			
		});
		
		$("#keyword").blur(function(){ // 벗어나면 안보이게끔 
			
			$("#searchHistory").css('display','none'); 
			
		})
		
	</script>

	
</body>    