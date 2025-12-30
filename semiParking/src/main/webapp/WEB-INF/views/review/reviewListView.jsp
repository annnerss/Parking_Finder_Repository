<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 조회</title>
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
    
	#reviewList>tbody>tr:hover {cursor:pointer;}
	.select, .text{display: inline-block;}
	#pagingArea{ width:fit-content; margin:auto; }
	#qnaList{width:100%;}
	
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	
	<div class="content">
		<br><br>
		<div class="innerOuter">
			<h2 class="text-center">리뷰</h2>
			<br>
			
			<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
			<c:if test="${not empty loginMember }">
				<a class="btn btn-secondary" style="float:right;", href="${contextRoot}/reviewInsert.rv">리뷰 작성</a>
			</c:if>
			<br><br>
			
			<ul class="reviewList">
				<c:choose>
					<c:when test="${empty list}">
						<li class="reivewEmpty">
							작성된 리뷰가 없습니다.
						</li>
					</c:when>
					
					<c:otherwise>
						<c:forEach items="${list}" var="r">
							<li class="reviewItem"
								damta-rno = "${r.RNo}"
								data-pno = "${r.PNo}">
								
								<div class="reviewHeader">
									<span class="reviewWriter">${r.memId}</span>
									<span class="reviewPoint">${r.point}</span>
									<span class="reviewDate">${r.createDate}</span>
								</div>
								
								<c:if test="${not empty r.changeName}">
									<div class="reviewImg">
										<c:if test="${not empty r.changeName}">
										    <img src="${contextRoot}/resources/uploadFiles/${r.changeName}"
         												style="width:120px; height:auto;">
										</c:if>
									</div>
								</c:if>
								
								<div class="reviewContent">${r.content}</div>
							</li>
						</c:forEach>
					</c:otherwise>
					
					
				</c:choose>
			</ul>
			
			
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>