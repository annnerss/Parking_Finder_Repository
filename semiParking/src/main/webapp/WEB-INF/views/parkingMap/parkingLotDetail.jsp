<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주차장 상세 페이지</title>
	<style>
		.form-group label{ display: block; text-align: left; }
		
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
   
    <div class="content-wrapper">
        <h2>주차장 상세 페이지</h2>
            <form action="${contextRoot}/parkingUpdate.pk" method="post">
                <div class="form-group">
                    <label for="parkingNo">* 주차장 번호 : </label>
                    <input type="text" class="form-control" id="parkingNo" name="parkingNo" value="${p.parkingNo}" readOnly> <br>
                    
                    <label for="parkingName">* 주차장 이름 : </label>
                    <input type="text" class="form-control" id="parkingName" name="parkingName" value="${p.parkingName}" required> <br>
                    
					<label for="openTime">* 주차장 여는 시간 : </label>
					<input type="text" class="form-control" id="openTime" name="openTime" value="${p.openTime}" required> <br>
					
					<label for="closeTime">* 주차장 닫는 시간 : </label>
					<input type="text" class="form-control" id="closeTime" name="closeTime" value="${p.closeTime}" required> <br>                     

					<label for="price">* 기본 요금 : </label>
					<input type="text" class="form-control" id="price" name="price" value="${p.price}" required> <br>
					
					<label for="priceTime">* 시간당 요금 : </label>
					<input type="text" class="form-control" id="priceTime" name="priceTime" value="${p.priceTime}" required> <br>
					
                    <label for="phone"> &nbsp;* 주인 연락처 : </label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${p.phone}"> <br>

                    <label for="status"> &nbsp;* 운영 상태 : </label>
                    <input type="tel" class="form-control" id="status" name="status" value="${p.status}"> <br>
                </div> 
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="button" class="btn btn-delete" data-toggle="modal" data-target="#deleteParking">삭제하기</button>
                </div>
            </form>
        </div>
        <div class="modal fade" id="deleteParking">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h4 class="modal-title">주차장 삭제</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="${contextRoot }/parkingDelete.pk" method="post">
	                    <div class="modal-body">
	                        <div align="center">
	                            삭제 후 복구가 불가능합니다. <br>
	                            정말로 삭제 하시겠습니까? <br>
	                        </div>
	                    </div>
	                    <input type="hidden" id="pNo" name="pNo" value="${p.parkingNo}">
	                    <div class="modal-footer" align="center">
	                        <button type="submit" class="btn btn-danger">삭제하기</button>
	                    </div>
	                </form>
	            </div>
	        </div>
    	</div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>