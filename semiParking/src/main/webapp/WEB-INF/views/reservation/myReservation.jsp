<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 내역</title>
<!-- jQuery & Bootstrap 4 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
    body {
        background-color: #F5F6F8;
        font-family: "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;
    }

    .content-wrapper {
        width: 80%;
        max-width: 1000px;
        margin: 50px auto;
        background-color: white;
        padding: 40px;
        border-radius: 12px; /* 둥근 모서리 */
        box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
    }

    h2 {
        font-weight: 700;
        color: #333;
        margin-bottom: 30px;
        text-align: center;
    }

    /* 테이블 스타일 */
    .table {
        margin-bottom: 0;
        text-align: center;
    }
    
    .table thead th {
        background-color: #1A237E; 
        color: white;
        border: none;
        padding: 15px 0;
        font-weight: 600;
    }

    .table tbody td {
        vertical-align: middle; 
        padding: 15px 0;
        color: #555;
        border-bottom: 1px solid #f0f0f0;
    }

    .table-hover tbody tr:hover {
        background-color: #eff6ff;
    }

    /* 삭제 버튼 스타일 */
    .btn-delete {
        background-color: white;
        border: 1px solid #dc3545;
        color: #dc3545;
        font-size: 13px;
        padding: 5px 12px;
        border-radius: 20px;
        transition: 0.2s;
    }

    .btn-delete:hover {
        background-color: #dc3545;
        color: white;
    }

    /* 데이터 없을 때 */
    .empty-area {
        padding: 60px 0;
        text-align: center;
        color: #999;
    }
</style>
</head>
<body>

    <%@ include file="/WEB-INF/views/common/menubar.jsp" %>

    <div class="content-wrapper">
        <h2>예약 정보 목록</h2>
        
        <table class="table table-hover">
            <thead>
                <tr>
                    <th width="10%">번호</th>
                    <th width="20%">주차장</th>
                    <th width="20%">시작 시간</th>
                    <th width="20%">종료 시간</th>
                    <th width="15%">아이디</th>
                    <th width="15%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" class="empty-area">
                                <h4>예약된 내역이 없습니다.</h4>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="r">
                            <tr>
                                <td>${r.reservationNo}</td>
                                <td style="font-weight:bold; color:#333;">${r.parkingName}</td>
                                <td>
									<fmt:formatDate value="${r.startTime}" pattern="yyyy-MM-dd HH:mm"/>
								</td>
								<td>
									<fmt:formatDate value="${r.endTime}" pattern="yyyy-MM-dd HH:mm"/>
								</td>
                                <td>${r.memberId}</td>
                                <td>
                                    <button type="button" 
                                            class="btn btn-delete deleteBtn" 
                                            data-toggle="modal" 
                                            data-target="#deleteModal" 
                                            data-reservationno="${r.reservationNo}">
                                        삭제하기
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="deleteModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold">예약 취소</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <div class="modal-body text-center p-4">
                    <p style="font-size: 1.1rem; margin-bottom: 5px;">정말로 예약을 삭제하시겠습니까?</p>
                    <p style="color: red; font-size: 0.9rem;">(삭제 후에는 복구가 불가능합니다.)</p>
                
                    <input type="hidden" id="modalReserveNo">
                </div>
                
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" id="realDeleteBtn">삭제하기</button>
                </div>
                
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        $(function(){
            
            $(document).on("click", ".deleteBtn", function(){
                let rNo = $(this).data("reservationno");
                
                $("#modalReserveNo").val(rNo);
            });
            
            $("#realDeleteBtn").click(function(){
                let rNo = $("#modalReserveNo").val();
                
                $.ajax({
                    url: "${pageContext.request.contextPath}/delete.re",
                    type: "POST",
                    data: { rNo : rNo },
                    success: function(result){
                        alert("예약이 정상적으로 취소되었습니다.");
                        location.reload();
                    },
                    error: function(){
                        alert("예약 취소에 실패했습니다. 관리자에게 문의하세요.");
                    }
                });
            });
            
        });
    </script>

</body>
</html>