<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	<div class="content">
		<br><br>
		<div class="innerOuter">
<!-- 			<h2>쿠폰 관리</h2> -->
			
<%-- 			<%@ include file="couponRegister.jsp" %> --%>
<!-- 			<br><br> -->
<%-- 			<jsp:include page="couponListView.jsp" > --%>
<!-- 		</div> -->
<!-- 	</div> -->
			
			<h2 class="text-center">쿠폰 등록하기</h2>
			<br>
			<div>
				<table id="couponEnroll" align="center" border="1">
					<tr>
						<th>쿠폰 코드</th>
						<td><input type="text" id="couponCode" name="couponCode"></td>
						<th><button id="couponBtn">쿠폰 등록</button></th>
					</tr>
				</table>
			</div>
			<br><br>
			<div align="center">
				<h2 class="text-center">쿠폰 목록</h2>
				<table id="couponList" align="center" border="1">
					<thead>
						<tr>
							<th>쿠폰 종류</th>
							<th>할인 적용률</th>
							<th>쿠폰 발급일</th>
							<th>쿠폰 만료일</th>
							<th>쿠폰 상태</th>
						</tr>	
					</thead>	
					<tbody>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${empty list}"> --%>
<!-- 								<tr> -->
<!-- 									<td colspan="5">보유한 쿠폰이 없습니다.</td> -->
<!-- 								</tr> -->
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<c:forEach items="${list}" var="mc"> --%>
<!-- 									<tr> -->
<%-- 										<td>${mc.refCid}</td> --%>
<%-- 										<td>${mc.discount}%</td> --%>
<%-- 										<td>${mc.issueDate}</td> --%>
<%-- 										<td>${mc.expireDate}</td> --%>
<%-- 										<td>${mc.status}</td> --%>
<!-- 									</tr> -->
<%-- 								</c:forEach> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose>		 --%>
					</tbody>
				</table>
			</div>
		</div>

		<script>
			$("#couponBtn").click(function(){
				$.ajax({
					url: "couponInsert.co",
					type: "POST",
					data: { couponCode: $("#couponCode").val() },
					success: function(result){
						if(result === "success"){
							alert("쿠폰이 등록되었습니다.");
							location.href = "${contextRoot}/couponPage.get";
						}else if(result === "invalid"){
							alert("유효하지 않은 쿠폰입니다.");
							location.href = "${contextRoot}/couponPage.get";
						}else if(result === "duplicate"){
							alert("이미 등록한 쿠폰입니다.");
							location.href = "${contextRoot}/couponPage.get";
						}else{
							alert("쿠폰 등록 실패");
							location.href = "${contextRoot}/couponPage.get";
						}
					}
				});
			});
			
			$(function () {
			    couponList();
			});

			function couponList() {
			    $.ajax({
			        url: "couponList.co",
			        type: "GET",
			        dataType: "json",
			        success: function(list) {

			            const tbody = $("#couponList tbody");
			            tbody.empty();

			            if (!list || list.length === 0) {
			                tbody.append(`
			                    <tr>
			                        <td colspan="5">보유한 쿠폰이 없습니다.</td>
			                    </tr>
			                `);
			                return;
			            }

			            list.forEach(mc => {
// 			            	const discount = (mc.DISCOUNT * 100) + "%";
// 			                const issueDate = formatDate(mc.ISSUE_DATE);
// 			                const expireDate = formatDate(mc.EXPIRE_DATE);
// 			                const status = mc.STATUS === "Y" ? "사용 가능" : "사용 불가";
			            	
			                tbody.append(`
			                    <tr>
			                        <td>\${mc.REF_CID}</td>
			                        <td>\${mc.DISCOUNT}%</td>
			                        <td>\${mc.ISSUE_DATE}</td>
			                        <td>\${mc.EXPIRE_DATE}</td>
			                        <td>\${mc.STATUS}</td>
			                    </tr>
			                `);
			            });
			        },
			        error: function () {
			            alert("쿠폰 목록 조회 실패");
			        }
			    });
			}

		</script>
	</div>
	
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>