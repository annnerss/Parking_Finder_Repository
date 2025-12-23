<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜 목록</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;
    }

    body {
        background-color: #f5f6f8;
    }

    .container {
        width: 900px;
        margin: 60px auto;
        background: #fff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .page-title {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 30px;
        border-bottom: 2px solid #eee;
        padding-bottom: 15px;
    }

    .favorite-list {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .favorite-card {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        transition: box-shadow 0.2s;
        background-color: #fff;
    }

    .favorite-card:hover {
        box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    }

    .favorite-info {
        line-height: 1.8;
    }

    .favorite-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 5px;
    }

    .favorite-address {
        color: #666;
        font-size: 14px;
    }
    
    .favorite-basicPrice {
        margin-top: 8px;
        font-weight: 600;
        color: #333;
    }

    .favorite-price {
        margin-top: 8px;
        font-weight: 600;
        color: #333;
    }

    .favorite-actions {
        text-align: right;
    }

    .heart {
        font-size: 22px;
        color: #ff5a5a;
        cursor: pointer;
        margin-bottom: 10px;
        display: block;
    }

    .detail-btn {
        padding: 8px 14px;
        border-radius: 6px;
        border: 1px solid #ddd;
        background-color: #fff;
        cursor: pointer;
        font-size: 14px;
    }

    .detail-btn:hover {
        background-color: #f1f1f1;
    }

    .empty-box {
        padding: 80px 0;
        text-align: center;
        color: #999;
        font-size: 16px;
    }
</style>
</head>

<body>

<%@ include file="/WEB-INF/views/common/menubar.jsp" %>

<div class="container">
    <div class="page-title">찜 목록</div>
    
    <c:if test="${empty parkingList}">
    
	    <div class="empty-box">
	        찜한 주차장이 없습니다.
	    </div>
    
    </c:if>
    
    <c:if test="${not empty parkingList}">

	    <!-- 찜 목록 있을 때 -->
	    <div class="favorite-list">
			<!--  
		        <div class="favorite-card">
		            <div class="favorite-info"> 
		                <div class="favorite-title">서울 강남구 테헤란로 123</div>
		                <div class="favorite-price">1시간 / 2,000원</div>
		            </div>
		
		            <div class="favorite-actions">
		                <button class="detail-btn">상세보기</button>
		            </div>
		        </div>
	        -->
			
			<c:forEach var="item" items="${parkingList}">
		        <div class="favorite-card">
		            <div class="favorite-info">
		                <div class="favorite-title">주차장 이름 : ${item.parkingName}</div>
		                <div class="favorite-basicPrice">기본 요금 : ${item.price}</div>
		                <div class="favorite-price">1시간 / ${item.priceTime}원</div>
		            </div>
		
		            <div class="favorite-actions">
		                <button class="detail-btn">상세보기</button>
		                
		                <!-- 상세보기는 해당 찜 한 주차장으로 가는 버튼 이건 location.href 추가해보기 -->
		                <!-- DB에서 관리번호까지 갖고왔으니 $관리번호 이용. -->
		            </div>
		        </div>
	        </c:forEach>
	
	    </div>
    
    </c:if>

    <!-- 찜 목록 없을 때 (나중에 조건 분기용 UI) -->
    <!--
    <div class="empty-box">
        찜한 주차장이 없습니다.
    </div>
    -->

</div>

</body>
</html>