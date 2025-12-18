<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>

<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	
	<div class="content">
		<br><br>
		<button onclick="location.href='${contextRoot}/qnaInsert.qn'">문의사항 글 작성</button>
		<div class="innerOuter">
			<h2 class="text-center">문의사항 게시판</h2>
			<br>
			
			<table align="center" border="1">
			<!-- Q_NO, Q_TYPE, Q_TITLE, CONTENT, CREATE_DATE, MEM_ID, P_NO -->
				<thead>
					<tr>
						<th>문의글 번호</th>
						<th>공개 범위</th>
						<th>사용자 아이디</th>
						<th>주차장 번호</th>
						<th>문의글 제목</th>
						<th>문의글 내용</th>
						<th>문의글 작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty list }">
							<c:forEach items="${list }" var="q">
								<tr>
									<td>${q.qNo}</td>
									<td>${q.qType}</td>
									<td>${q.memId}</td>
									<td>${q.pNo}</td>
									<td>${q.qTitle}</td>
									<td>${q.content}</td>
									<td>${q.createDate}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td>조회된 글이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
				
			</table>		
		</div>
	
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>