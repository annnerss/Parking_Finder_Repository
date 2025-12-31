<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 목록</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/menubar.jsp" %>
	<div class="content-wrapper">
		<h2>예약 리스트</h2>
			<table class="table table-hover" id="reserveList">
				<thead>
					<tr>
			            <th width="10%">예약 번호</th>
	                    <th width="25%">예약 시작시간</th>
	                    <th width="25%">예약 종료시간</th>
	                    <th width="20%">주차장</th>
	                    <th width="10%">멤버 아이디</th>
	                    <th width="10%">관리</th>
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
							<td>
								<c:if test="${r.status eq 'X' }">
									<button type="button" class="btn btn-delete deleteBtn" data-toggle="modal" data-target="#deleteReserve" data-reservationno="${r.reservationNo}">삭제</button>
								</c:if>
								<c:if test="${r.status eq 'Y' }">
									<button type="button" class="btn btn-delete deleteBtn" data-toggle="modal" data-target="#deleteReserve" data-reservationno="${r.reservationNo}" disabled>삭제</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<script>
				$(function(){
					$(".deleteBtn").click(function(){
						let rNo = $(this).data("reservationno"); 
						$("#deleterNo").val(rNo);
					});
					
					$("#deleteConfirm").click(function(){
						let rNo = parseInt($("#deleterNo").val(), 10); // 숫자로 변환
						$.ajax({
							url:"/parking/delete.re",
							data: {rNo : rNo},
							type: "POST",
							success:function(response){
								if(response.status == "success"){
									alert(response.message);
									location.reload();
								}else{
									alert(response.message);
								}
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
	
	 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>