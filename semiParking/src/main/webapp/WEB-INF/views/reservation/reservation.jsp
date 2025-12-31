<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주차장 예약</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<style>
	    #reserve-container div{ 
		    text-align:left;
	    }
	    
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	
	<div class="content-wrapper">
	        <h2 class="text-center">주차장 예약</h2>
	        <br>
	        <input type="hidden" id="basePrice" value="${parkingLot.price*10}">
	        <input type="hidden" id="unitPrice" value="${parkingLot.priceTime}">
	
	        <form id="reserve-container" action="reserve.port" method="post">
	            <div class="form-group">
	                <label>주차장 이름:</label>
	                <input type="text" class="form-control" name="parkingName" value="${parkingLot.parkingName}" readonly>
	                <input type="hidden" class="form-control" name="parkingNo" value="${parkingLot.parkingNo}">
	            </div>
	
	            <div class="form-group">
	                <label>예약자ID:</label>
	                <input type="text" class="form-control" name="memberId" value="${loginMember.memId}" required>
	            </div>
	
	            <div class="form-group">
	                <label>입차 예정 시간:</label>
	                <input type="datetime-local" class="form-control" id="startTime" name="startTime" onchange="calcPrice()" required> 
	            </div>
	
	            <div class="form-group">
	                <label>출차 예정 시간:</label>
	                <input type="datetime-local" class="form-control" id="endTime" name="endTime" onchange="calcPrice()" required>
	            </div>
	            
	            <div class="form-group">
	            	<label>쿠폰 사용</label>
	            	<select id="couponList" class="form-control">
	            		<option value="1">보유 쿠폰 목록</option>
	            	</select>
	            </div>
	
	            <div class="form-group">
	                <label>예상 결제 요금 : </label>
	                <input type="text" class="form-control" id="totalPrice" name="price" readonly placeholder="시간을 선택하면 자동 계산됩니다.">
	            </div>
				<br>
	            <button type="submit" class="btn">결제하기</button>
	            <button type="button" class="btn btn-delete" onclick="history.back()">취소</button>
	        </form>
	    </div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>

	<script>
		let totalDiscount = 0; //글로벌 최종 할인율 변수
		
		$(document).ready(function(){
			const couponList = $("#couponList");
			
			couponList.one('focus',function(){
				$.ajax({
					url:'couponList.co',
					type: "GET",
			        dataType: "json",
			        success:function(list){
			        	$.each(list, function(index, coupon) {
		                    const dPrice = (coupon.DISCOUNT * 100); //할인율 퍼센트로 변환해서 저장
		                    const option = $('<option>')
		                        .val(`\${coupon.REF_CID}`)
		                        .text(`\${coupon.REF_CID} (\${dPrice}% 할인)`)
		                        .attr('data-discount', dPrice);
		                    couponList.append(option);
		                });
			        },
			        error:function(){
			        	console.log("쿠폰 목록 조회 실패");
			        }
				});
			});
			
			couponList.on('change', function() {
		        const selected = $(this).find('option:selected');
		        const discount = parseFloat(selected.data('discount')) || 0;
		        totalDiscount = (discount / 100);
		        calcPrice(); //쿠폰 선택이 달라질때마다 최종금액 계산
		    });
			
		});
	
	    $(function(){
	        $("#startTime").change(function(){
	            const startVal = $(this).val();
	
	            if(!startVal) return;
	
	            const startDate = new Date(startVal);
	            const now = new Date();
	
	            if(startDate < now){
	                alert("현재 시간보다 이전 시간은 예약할 수 없습니다.");
	                $(this).val("");
	                $("#couponList").val("1"); //option 리셋
	                return;
	            }
	
	            const endVal = $("#endTime").val();
	            if(endVal){
	                const endDate = new Date(endVal);
	                if(endDate <= startDate){
	                    alert("입차시간보다 빠른 시간은 예약할 수 없습니다.")
	                    $("#endTime").val("");
	                    $("#couponList").val("1"); //option 리셋
	                } 
	            }
	        });
	
	        $("#endTime").change(function(){
	            const startVal = $("#startTime").val();
	            const endVal = $(this).val();
	
	            if(!startVal){
	                alert("입차 시간을 먼저 설정해 주세요");
	                $(this).val("");
	                $("#couponList").val("1"); //option 리셋
	                return;
	            }
	
	            const endDate = new Date(endVal);
	            const startDate = new Date(startVal);
	
	            if(endDate < startDate){
	                alert("출차 시간은 입차시간보다 이후여야 합니다.");
	                $(this).val("");
	                $("#couponList").val("1"); //option 리셋
	                return;
	            }
	        })
	    })
	
	    function calcPrice() {
	        const startVal = document.getElementById("startTime").value;
	        const endVal = document.getElementById("endTime").value;
	        const basePrice = parseInt(document.getElementById("basePrice").value); 
	        let unitPrice = parseInt(document.getElementById("unitPrice").value);
	        
	        if(unitPrice == 0) {
	            unitPrice = 500;
	        }
	        if (startVal && endVal) {
	            const start = new Date(startVal);
	            const end = new Date(endVal);
	
	            const diffMS = end - start;
	            const diffHours = diffMS / (1000 * 60 * 60); //ms단위 *초 *분 *시간
	
	            if (diffHours <= 0) {
	                alert("출차 시간은 입차 시간보다 뒤여야 합니다.");
	                document.getElementById("totalPrice").value = "";
	                $("#couponList").val("1"); 
	                return;
	            }
	
	            let total = 0;
	
	            if(diffHours <= 1){
	                total = basePrice;
	            }else{ 
	            	let tempPrice = (basePrice + ((Math.ceil(diffHours)-1) * unitPrice));
	                totalDiscount = tempPrice * totalDiscount; //할인 금액 계산 후 최종 금액에서 빼기
		            total = tempPrice - totalDiscount;
	            }
	           
	            document.getElementById("totalPrice").value = total;
	        }
	    }
	</script>
</body>
</html>