<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 목록</title>
<style>
	.content {
        background-color:rgb(247, 245, 245);
        width:80%;
        margin:auto;
    }
    .innerOuter {
        border:1px solid lightgray;
        width:80%;
        margin:auto;
        padding:5% 10%;
        background-color:white;
    }
	#reserveList { background-color: #f4f4f4;}
	#reserveList tbody t:hover {
		background-color:#d4d4d4;
		display: flex;
        justify-content: center;
        align-items: center;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/menubar.jsp" %>
	<h2 style="text-align:center;">예약 리스트</h2>
	<div class="content">
		<br><br>
		<div class="innerOuter">
			<table id="reserveList">
				<thead>
					<tr>
						<th>예약 번호</th>
			            <th>예약 시작시간</th>
			            <th>예약 종료시간</th>
			            <th>주차장</th>
			            <th>멤버 아이디</th>
			            <th></th>
		            </tr>
				</thead>
				<tbody>
					<c:forEach items="${rList }" var="r">
						<tr>
							<td>${r.reservationNo }</td>
							<td>${r.startTime }</td>
							<td>${r.endTime }</td>
							<td>${r.parkingName }</td>
							<td>${r.memberId }</td>
							<td><button type="button" class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteReserve" data-reservationno="${r.reservationNo}">삭제하기</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<script>
				$(function(){
					$("#deleteBtn").click(function(){
						let rNo = $(this).data("reservationno");
						$("#deleterNo").val(rNo);
					});
					
					$("#deleteConfirm").click(function(){
						let rNo = $("#deleterNo").val();
						$.ajax({
							url:"/parking/delete.re",
							type: "POST",
							data: {rNo : rNo},
							success:function(){
								location.reload();
							},
							error:function(){
								alert("예약 내역 삭제를 실패했습니다");
							}
						});
					});
				});
			</script>
			
			<div class="modal fade" id="deleteReserve">
		        <div class="modal-dialog modal-sm">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h4 class="modal-title">예약 삭제</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		                <div class="modal-body">
		                    <div align="center">
		                        삭제 후 복구가 불가능합니다. <br>
		                        정말로 삭제 하시겠습니까? <br>
		                    </div>
		                </div>
		                <input type="hidden" id="deleterNo" name="deleterNo">
		                <div class="modal-footer" align="center">
		                   <button type="submit" class="btn btn-danger" id="deleteConfirm">삭제하기</button>
		                </div>
		            </div>
		        </div>
	    	</div>
		</div>
	</div>
	
	 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>