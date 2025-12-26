<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 예약</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
    .reserve-container { width: 500px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 10px; }
</style>
</head>
<body>

<div class="container">
    <div class="reserve-container">
        <h2 class="text-center">주차장 예약</h2>
        <br>
        <input type="hidden" id="basePrice" value="${parkingLot.price*10}">
        <input type="hidden" id="unitPrice" value="${parkingLot.priceTime}">

        <form action="reserve.port" method="post">
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
                <input type="datetime-local" class="form-control" id="endTime" name="endTime" onchange="calcPrice()"required>
            </div>

            <div class="form-group">
                <label>예상 결제 요금 : </label>
                <input type="text" class="form-control" id="totalPrice" name="price" readonly placeholder="시간을 선택하면 자동 계산됩니다.">
            </div>

            <button type="submit" class="btn btn-primary btn-block">결제하기</button>
            <button type="button" class="btn btn-secondary btn-block" onclick="history.back()">취소</button>
        </form>
    </div>
</div>


<script>
    $(function(){
        $("#startTime").change(function(){
            const startVal = $(this).val();

            if(!startVal) return;

            const startDate = new Date(startVal);
            const now = new Date();

            if(startDate < now){
                alert("현재 시간보다 이전 시간은 예약할 수 없습니다.");
                $(this).val("");
                return;
            }

            const endVal = $("#endTime").val();
            if(endVal){
                const endDate = new Date(endVal);
                if(endDate <= startDate){
                    alert("입차시간보다 빠른 시간은 예약할 수 없습니다.")
                    $("#endTime").val("");
                } 
            }
        });

        $("#endTime").change(function(){
            const startVal = $("#startTime").val();
            const endVal = $(this).val();

            if(!startVal){
                alert("입차 시간을 먼저 설정해 주세요");
                $(this).val("");
                return;
            }

            const endDate = new Date(endVal);
            const startDate = new Date(startVal);

            if(endDate < startDate){
                alert("출차 시간은 입차시간보다 이후여야 합니다.");
                $(this).val("");
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

            console.log(diffHours);

            if (diffHours <= 0) {
                alert("출차 시간은 입차 시간보다 뒤여야 합니다.");
                document.getElementById("totalPrice").value = "";
                return;
            }

            let total = 0;

            if(diffHours <= 1){
                total = basePrice;
            }else{
                console.log(Math.ceil(diffHours))
                total = basePrice + ((Math.ceil(diffHours)-1) * unitPrice);
            }
           
            document.getElementById("totalPrice").value = total;
        }
    }
</script>


</body>
</html>