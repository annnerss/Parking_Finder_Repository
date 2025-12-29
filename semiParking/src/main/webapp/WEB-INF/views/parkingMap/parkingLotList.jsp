<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 목록</title>
<style>
    .search-box{
    	max-width:400px;
    	margin: 16px auto;
    	position:relative;
    }
    
    #search{
    	width:80%;
    	padding: 5px;
    	border: 1px solid #d0d7de;
	    border-radius: 8px;
	    background: #fff;
    }
    
    #search:focus {
	   border-color: #0969da;
	   box-shadow: 0 0 0 3px rgba(9, 105, 218, 0.15);
	}
	
	#searchBtn{
		position:absolute;
		width:20%;
		padding: 5px;
	}
	
	#searchListDiv{
		position:absolute;
		width:80%;
		max-length: 220px;
		border-radius: 8px;
		border: 2px solid black;
		background: white;
		display: none;
		padding-top:10px;
	}
	
	#searchList{ list-style: none; padding-left:15px;}
    
    #searchList li{
    	cursor: pointer;
    	width:90%;
    	justify-content: space-between;
    	padding:0px;
    	margin:0px;
	    display: flex;
    }
    
	#pagingArea{ width:fit-content; margin:auto;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/menubar.jsp" %>
	<br>
	<div class="content-wrapper">
		<h2>주차장 리스트</h2>
			<div class="search-box">
				<input type="text" id="search" placeholder="주차장명으로 검색" onkeyup="searchFunc(this);">&nbsp
				<button class="btn" id="searchBtn">검색</button>
				<div id="searchListDiv">
					<ul id="searchList"></ul> <!-- 검색 제시어 들어갈 위치 -->
					<input type="hidden" name="parkingNo" value="122-1-000001">
				</div>
			</div>
			<br>
			
			<!-- 비동기 검색 제시어 기능 script -->
			<script>
				function searchFunc(keyword){
					var word = keyword.value;
					
					$.ajax({
						url:"searchParking.pk",
						data:{
							keyword:word
						},
						success:function(list){
							$("#searchList").empty();
							var keyword = $("#search").val();
							
							if(keyword.length > 1 && list.length > 0){
								for(let p of list){
									$("#searchList").append("<li data-parkingNo='"+
															p.parkingNo+"'>"+
															p.parkingName +
															"</li>");
								}
								$("#searchListDiv").slideDown();
							}
						},
						error:function(){
							console.log("검색중 오류 발생");
						}
					});
				}
			</script>
			
			<table class="table table-hover" id="ParkingList">
				<thead>
					<tr>
						<th>주차장 번호</th>
			            <th>주차장 이름</th>
			            <th>주차장 운영 상태</th>
		            </tr>
				</thead>
				<tbody>
					<c:forEach items="${pList }" var="p">
						<tr>
							<td>${p.parkingNo}</td>
							<td>${p.parkingName}</td>
							<td style="text-align:center;">${p.status }</td>
						</tr>
					</c:forEach>
					<c:if test="${not empty pList }">
						<script>
							$(function(){
								$("#ParkingList tbody tr").click(function(){
									let pNo = $(this).children().first().text();
									location.href="${contextRoot}/parkingDetail.get?pNo="+pNo;
								});
								
								$(document).on("click","#searchList li",function(){
									let pNo = $(this).data("parkingno");
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
            
			<br>
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
	
	 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>