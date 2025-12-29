<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>검색 결과</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/menubar.jsp" %>

<div id="searchResult">

    <!-- ================= 검색 결과 없음 ================= -->
    <c:if test="${empty parkingList}">
        <div align="center" style="margin-top:50px;">
            <h4>'${keyword}'에 대한 검색 결과가 없습니다.</h4>
        </div>
    </c:if>

    <!-- ================= 검색 결과 있음 ================= -->
    <c:if test="${not empty parkingList}">

        <!-- ====== 주차장 목록 ====== -->
        <c:forEach var="p" items="${parkingList}">
            <div class="result-item"
                 onclick="moveMap('${p.location_Y}', '${p.location_X}', '${p.parkingName}')">

                <div class="p-title">${p.parkingName}</div>
                
                <div class="p-info">
                    <span>기본 요금 : ${p.price}</span>
                    <span>시간당 추가요금 : ${p.priceTime}</span>
                    <span>여는 시간 : ${p.openTime}</span>
                    <span>닫는 시간 : ${p.closeTime}</span>
                    <span>총 좌석 수 : ${p.total}</span>
                    <span>잔여 좌석 수 : ${p.current}</span>
                </div>
            </div>
        </c:forEach>

        <!-- ====== 페이징 영역 ====== -->
        <div id="pagingArea" style="margin-top:30px;">
            <ul class="pagination">

                <!-- Previous -->
                <c:choose>
                    <c:when test="${pi.currentPage eq 1}">
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Previous</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/search.parking?keyword=${keyword}&page=${pi.currentPage-1}">
                               Previous
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <!-- Page Numbers -->
                <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="i">
                    <li class="page-item ${i eq pi.currentPage ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/search.parking?keyword=${keyword}&page=${i}">
                           ${i}
                        </a>
                    </li>
                </c:forEach>

                <!-- Next -->
                <c:choose>
                    <c:when test="${pi.currentPage eq pi.maxPage}">
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/search.parking?keyword=${keyword}&page=${pi.currentPage+1}">
                               Next
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>

    </c:if>

</div>

<script>
function moveMap(lat, lng, name){
    location.href = '${pageContext.request.contextPath}/parkingmap.do?lat='
        + lat + '&lng=' + lng + '&name=' + name;
}
</script>

</body>
</html>