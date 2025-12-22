<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
        .primary-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            flex-grow: 1;
        }
        .secondary-btn {
            background-color: #f0f0f0;
            color: #007bff;
            border: 1px solid #007bff;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body>
	<div class="container">
	    <div class="completion-icon">✓</div>
	    <h2>주차권 결제 완료</h2>
	    <p>이용 시작일을 확인해 주세요.</p>
	
	    <div class="details">
	        <div class="detail-row">
	            <span class="detail-label">하이파킹 AIA타워 주차장</span>
	        </div>
	        <div class="detail-row">
	            <span class="detail-label">예약 날짜</span>
	            <span class="detail-value">2025-12-31</span>
	        </div>
	        <div class="detail-row">
	            <span class="detail-label">차량번호</span>
	            <span class="detail-value">123가4567</span>
	        </div>
	    </div>
	
	    <div class="button-group">
	        <button class="primary-btn" onclick="location.href='${pageContext.request.contextPath}'">🏠홈으로 돌아가기</button>
	    </div>
</div>
</body>
</html>