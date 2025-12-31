<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<style>
		#couponEnroll { width:500px; }
		.coupon-container {
		    display: flex;
		    gap: 10px;
		    align-items: center;
		}
		
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	<div class="content-wrapper">
			<div>
			<h5 class="text-center">쿠폰 등록하기</h5>
				<table class="table" id="couponEnroll" align="center">
					<tr>
						<th>쿠폰</th>
						<td style="padding:0 20px;">
							<div class="coupon-container" style="display: flex; gap: 8px;">
						        <input class="form-control" type="text" id="couponCode" name="couponCode" placeholder="쿠폰 코드를 입력해주세요" style="flex: 1;">
						        <button class="btn" id="couponBtn" style="white-space: nowrap;">쿠폰 등록</button>
						    </div>
						</td>
					</tr>
				</table>
			</div>
			<br><br>
			<div align="center">
				<h2 class="text-center">보유 쿠폰 목록</h2>
				<table class="table" id="couponList" align="center">
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
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>