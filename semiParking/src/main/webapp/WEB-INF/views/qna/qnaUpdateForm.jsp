<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
	
	<div class="content"> 
		<br>
		<div class="innerOuter">
			<h2>문의사항 글 수정하기</h2>
			<br>
			
			<form id="updateForm" method="post" action="qnaUpdate.qn" >
				<!-- 어떤 게시글을 수정할 것인지 식별자가 필요하기 때문에 게시글 번호 전달하기 -->
				<input type="hidden" name="qNo" value="${q.QNo }">
				<table align="center">
					<tr>
						<th id="qnaRange">공개 범위 설정</th>
						<td><input type="radio" id="all" class="form-control" name="qType" value="0" checked></td>
						<td><label for="all">전체 공개</label></td>
						<td><input type="radio" id="manager" class="form-control" name="qType" value="1"></td>
						<td><label for="manager">관리자에게만 공개</label></td>
					</tr>
					<tr>
						<th><label for="pname">주차장명</label></th>
						<td colspan="4"><input type="text" id="pname" name="pNo" class="form-control" value="${q.PNo }" required></td>
					</tr>
					<tr>
						<td><label for="qnaWriter">작성자</label></td>
						<td colspan="4"><input type="text" id="qnaWriter" name="memId" class="form-control" value="${loginMember.memId }" readonly></td>
					</tr>
					<tr>
						<th><label for="qnaTitle">제목</label></th>
						<td colspan="4"><input type="text" id="qnaTitle" name="qTitle" class="form-control" value="${q.QTitle }" required></td>
					</tr>
					<tr>
						<th><label for="qnaContent">내용</label></th>
						<td colspan="4"><textarea id="qnaContent" name="content" class="form-control" rows="10" style="resize:none" required>${q.content}</textarea></td>
					</tr>					
				</table>
				<br>
				
				<div align="center">
					<button type="submit" class="btn btn-primary">수정하기</button>
					<button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
				</div>
			</form>
		</div>
	</div>
	
	
	
	
	
	
	
	
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>