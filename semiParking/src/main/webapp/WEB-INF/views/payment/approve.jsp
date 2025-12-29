<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약권 결제 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(26, 35, 126,0.2); 
            width: 90%;
            max-width: 400px;
            padding: 20px;
            text-align: center;
            position: relative;
        }
        .completion-icon {
            color: #007bff;
            font-size: 48px;
            width: 70px;
            margin-bottom: 15px;
            display: inline-block;
            border: 2px solid #007bff;
            border-radius: 50%;
            padding: 10px;
        }
        h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 10px;
        }
        p {
            color: #777;
            font-size: 14px;
            margin-bottom: 30px;
        }
        .details {
            text-align: left;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .detail-label {
            color: #aaa;
        }
        .detail-value {
            color: #333;
            font-weight: bold;
        }
        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
        .primary-btn { flex-grow: 1; }
    </style>
</head>
<body>
	<div class="container">
	    <div class="completion-icon">✓</div>
	    <h2>주차권 결제 완료</h2>
	    <p>이용 시작일을 확인해 주세요.</p>
	
	    <div class="details">
	        <div class="detail-row">
	            <span class="detail-label">주차장</span>
	            <span class="detail-value">${pay.item_name }</span>
	        </div>
	        <div class="detail-row">
	            <span class="detail-label">결제 금액</span>
	            <span class="detail-value"><fmt:formatNumber value="${pay.total_amount }" type="number" groupingUsed="true"/>원</span>
	        </div>
	        <div class="detail-row">
	            <span class="detail-label">예약 시작 날짜</span>
	            <span class="detail-value">${rStartDate }</span>
	        </div>
	    </div>
	
	    <div class="button-group">
	        <button class="btn primary-btn" onclick="location.href='${pageContext.request.contextPath}'">🏠홈으로 돌아가기</button>
	    </div>
</div>
</body>
</html>