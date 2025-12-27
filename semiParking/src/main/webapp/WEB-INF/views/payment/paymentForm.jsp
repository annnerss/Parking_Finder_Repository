<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주차권 결제 정보</title>
    <style>
		body {
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		    background-color: #f4f4f4; /* Light gray background for contrast */
		    color: #333;
		}
		
		.container {
		    width: 100%;
		    max-width: 450px; /* Max width typical for mobile view */
		    margin: 0 auto;
		    background-color: #fff; /* White background for main content */
		    box-shadow: 0 0 10px rgba(0,0,0,0.1);
		    padding-bottom: 80px; /* Space for the fixed bottom button */
		}
		
		/* --- Main Info Section (Blue Header) --- */
		.main-info-section {
		    background-color: #007bff; /* Bright blue color */
		    color: #fff;
		    padding: 20px 15px;
		    text-align: center;
		}
		
		.ticket-type {
		    font-size: 18px;
		    font-weight: bold;
		    margin: 0 0 5px 0;
		}
		
		.price {
		    font-size: 36px;
		    font-weight: bold;
		    margin: 0 0 10px 0;
		}
		
		.duration {
		    font-size: 14px;
		    margin: 0;
		}
		
		.note-box {
		    background-color: #eaf4ff; /* Lighter blue for the note box */
		    border: 1px solid #b3d7ff;
		    padding: 10px;
		    border-radius: 5px;
		    flex: 1;
		    margin: 15px;
		    text-align:center;
		}
		
		.note-box p {
		    margin: 0 0 5px 0;
		    font-size: 13px;
		}
		
		.note-box p:last-child {
		    margin-bottom: 0;
		}
		
		.note-box .warning {
		    color: #dc3545;
		    font-weight: bold;
		}
		
		.guidelines-section {
		    padding: 15px;
		}
		
		.guidelines-section h2 {
		    color: #007bff;
		    font-size: 18px;
		    border-bottom: 1px solid #eee;
		    padding-bottom: 5px;
		}
		
		.guidelines-section ul {
		    list-style-type: disc;
		    padding-left: 20px;
		    margin-bottom: 20px;
		}
		
		.guidelines-section li {
		    margin-bottom: 8px;
		    font-size: 14px;
		}
		
		/* --- Fixed Bottom Button --- */
		.bottom-bar {
		    background-color: #fff;
		    padding: 10px 15px;
		    box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
		    text-align: center;
		}
		
		#btn-pay-ready {
		    width: 100%;
		    padding: 15px;
		    background-color: #ffc107; /* Yellow color for the button */
		    border: none;
		    border-radius: 5px;
		    font-size: 16px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		#btn-pay-ready:hover {
		    background-color: #e0a800;
		}
		
		.guidelines-section #terms {
			color:gray;
			font-size:1%;
		}
    	
    </style>

</head>
<body>
    <div class="container">
        <div class="main-info-section">
            <p class="ticket-type">당일 예약권</p>
            <p class="price">
            	<fmt:formatNumber value="${price }" type="number" groupingUsed="true"/>원
            </p>
            <p class="duration">구매당일 영업시간 사이 주차가능</p>
        </div>
		<input type="hidden" value="${reservation }">
        <div class="note-box">
            <p>출차 시 인터폰에 <strong>Parking Finder</strong>에서</p>
            <p>결제한 차량임을 알려주세요.</p>
            <p class="warning">사전 무인정산기 이용 금지</p>
        </div>

        <div class="guidelines-section">
            <h2>안내사항</h2>
            <ul>
                <li>만차 혹은 현장 사정에 따라 주차가 어려울 수 있음</li>
                <li>선불주차권으로 입차한 상태에서 구매 시 사용 불가</li>
                <li>입출차는 1회만 가능하며, 주차권으로 출차 후 재입차 시 현장요금 적용</li>
                <li>유효시간 외 주차 시 주차권 적용 취소 및 총 이용시간에 대해 전액 현장요금 적용</li>
				<li>주차권 구매 후 입차 시 주차권 환불 불가</li>
				<li>구매 당일 동일 주차권 동일 차량번호로 재구매 불가</li>
				<li>주차장에서의 도난, 분실, 사고는 일체 책임지지 않음</li>
            </ul>
            
            <h2>아래 경우 <b>주차권 사용이 불가</b>합니다</h2>
            <ul>
            	<li>입차 후에 주차권 구매</li>
            	<li>출차 없이 주차권 2개 이상 연속 사용</li>
            	<li>주차권 유효시간 외 주차</li>
            	<li>한법 출차 후 재입차</li>
            </ul>
            <br>
            <ul id="terms">
            	<li>유의사항 미숙지로 인한 불이익은 책임지지 않습니다.</li>
				<li>만차 및 현장 사정으로 주차가 어려울 수 있습니다.</li>
            </ul>
        </div>
	    <div class="bottom-bar">
	    	<label><input type="checkbox" id="agree">위 내용을 확인했습니다</label><br><br>
	        <button id="btn-pay-ready" disabled>결제하기</button>
	    </div>
    </div>
	
	<script type="text/javascript">
	    // 카카오페이 결제 팝업창 연결
	    $(function() {
	    	$("#agree").change(function(){
	    		if ($(this).is(":checked")) {
	    	        $("#btn-pay-ready").prop("disabled", false); // enable
	    	    } else {
	    	        $("#btn-pay-ready").prop("disabled", true);  // disable
	    	    }

	    	});
	        $("#btn-pay-ready").click(function() {
	            // 아래 데이터 외에도 필요한 데이터를 원하는 대로 담고, Controller에서 @RequestBody로 받으면 됨
	            let data = {
	            	partner_order_id : ${reservation.reservationNo},
	            	partner_user_id : "${reservation.memberId}",
	            	parkingName: "${reservation.parkingName}",
	            	parkingNo : "${reservation.parkingNo}",
	            	total_amount: ${price}
	            };
	            
	            console.log(data);

	            $.ajax({
	                type: 'POST',
	                url: '${pageContext.request.contextPath}/payment/ready',
	                data: JSON.stringify(data),
	                contentType: 'application/json',
	                success: function(response) {
	                	location.href = response.next_redirect_pc_url;
	                },
	                error:function(e){
	                	alert("결제 준비 중 오류 발생: ");
	                	console.log(e);
	                }
	            });
	        });
	    });
	</script>
</body>
</html>