<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 목록</title>
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
    
    #ParkingList {
		width:100%;
	}
	
	#ParkingList tbody tr:hover {
		background-color:#d4d4d4;
	}
	
	#pagingArea{ width:fit-content; margin:auto;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/menubar.jsp" %>
	<h2 style="text-align:center;">주차장 리스트</h2>
	<br>
	<div class="content">
		<br><br>
		<div class="innerOuter">
			<input type="text" id="search" name="search">	
			<table id="ParkingList">
				<thead>
					<tr>
						<th>주차장 번호</th>
			            <th>주차장 이름</th>
			            <th style="text-align:right;">주차장 운영 상태</th>
		            </tr>
				</thead>
				<tbody>
					<c:forEach items="${pList }" var="p">
						<tr>
							<td>${p.parkingNo}</td>
							<td>${p.parkingName}</td>
							<td style="text-align:right;">${p.status }</td>
						</tr>
					</c:forEach>
					<c:if test="${not empty pList }">
						<script>
							$(function(){
								$("#ParkingList tbody tr").click(function(){
									let pNo = $(this).children().first().text();
									location.href="${contextRoot}/parkingDetail.get?pNo="+pNo;
								});
							});
						</script>
					</c:if>
				</tbody>
			</table>
			
			<c:url var="url" value="${empty map?'parkingListView.get':'search.bo'}">
            	<c:if test="${not empty map }">
            		<c:param name="condition">${map.condition }</c:param>
            		<c:param name="keyword" value="${map.keyword }"/>
            	</c:if>
            	<!-- currentPage 값은 페이징바 만드는 반복문에서 각 페이지숫자 넣어줄것 -->
            	<c:param name="page"></c:param>
            </c:url>
            
			<br><br>
			<div id="pagingArea">
                <ul class="pagination">
	                <c:choose>
	                	<c:when test="${pi.currentPage eq 1}">
	                		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
	                	</c:when>
	                	<c:otherwise>
	                		<li class="page-item "><a class="page-link" href="${url}${pi.currentPage-1}">Previous</a></li>
	                	</c:otherwise>
	                </c:choose>
	                
                    <c:forEach var="i" begin="${pi.startPage }" end="${pi.endPage }">
                    	<li class="page-item ${i eq pi.currentPage? 'disabled':'' }"><a class="page-link" href="${url}${i}">${i}</a></li>
                    </c:forEach>
                    
	                <c:choose>
	                	<c:when test="${pi.currentPage eq pi.maxPage}">
	                		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
	                	</c:when>
	                	<c:otherwise>
	                		<li class="page-item"><a class="page-link" href="${url}${pi.currentPage+1}">Next</a></li>
	                	</c:otherwise>
	                </c:choose>
                </ul>
            </div>
		</div>
	</div>
	
	 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>