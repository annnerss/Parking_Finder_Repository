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
	#deleteModal .modal-content {
	    background-color: #fdf1f2;   /* 연한 경고 핑크 */
	    border: 2px solid #1A237E;
	    border-radius: 15px;
	}
	
	#deleteModal .modal-header,
	#deleteModal .modal-footer { border: none; }
</style>
</head>
<body>

    <%@ include file="/WEB-INF/views/common/menubar.jsp" %>

    <div class="content-wrapper">
        <h2>예약 정보 목록</h2>
        <table class="table">
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
                            <td colspan="6">
                                <p>예약된 내역이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="r">
                            <tr>
                                <td>${r.reservationNo}</td>
                                <td>${r.parkingName}</td>
                                <td>
									<fmt:formatDate value="${r.startTime}" pattern="yyyy-MM-dd HH:mm"/>
								</td>
								<td>
									<fmt:formatDate value="${r.endTime}" pattern="yyyy-MM-dd HH:mm"/>
								</td>
                                <td>${r.memberId}</td>
                                <td>
                                    <c:if test="${r.status eq 'X' }">
										<button type="button" 
                                            class="btn btn-delete deleteBtn" 
                                            data-toggle="modal" 
                                            data-target="#deleteModal" 
                                            style="white-space: nowrap;"
                                            data-reservationno="${r.reservationNo}" disabled>
                                        승인 대기중...
                                    	</button>
									</c:if>
									<c:if test="${r.status eq 'Y' }">
										<button type="button" 
                                            class="btn btn-delete deleteBtn" 
                                            data-toggle="modal" 
                                            data-target="#deleteModal" 
                                            data-reservationno="${r.reservationNo}">
                                        예약 취소
                                    	</button>	
									</c:if>
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
                    <button type="button" class="btn" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-delete" id="realDeleteBtn">삭제하기</button>
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