<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>문의사항 작성</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<style>
		#qnaEnroll{ width:100%;}
		.table th{ width:30%; }
		.table input,textarea{ max-width:90%; }
	</style>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp"%>
	<div class="content-wrapper">
		<h2 class="text-center">문의사항 글 작성</h2>
			<br>
			<form id="enrollForm" method="post" action="${contextRoot }/qnaInsert.qn">
				<table class="table" align="center" id="qnaEnroll">
				<!-- 공개 범위, 주차장명, 작성자, 내용 -->
					<tr>
						<th id="qnaRange">공개 범위 설정</th>
						<td><input type="radio" id="all" class="form-control" name="qType" value="0" checked></td>
						<td><label for="all">전체 공개</label></td>
						<td><input type="radio" id="manager" class="form-control" name="qType" value="1"></td>
						<td><label for="manager">관리자에게만 공개</label></td>
					</tr>
					<tr>
						<th><label for="pname">주차장명</label></th>
						<td colspan="4"><input type="text" id="pname" name="pNo" class="form-control"></td>
					</tr>
					<tr>
						<th><label for="qnaWriter">작성자</label></th>
                        <td colspan="4"><input type="text" id="qnaWriter" name="memId" class="form-control" value="${loginMember.memId }" readonly></td>
					</tr>
					<tr>
						<th><label for="qnaTitle">제목</label></th>
						<td colspan="4"><input type="text" id="qnaTitle" name="qTitle" class="form-control"></td>					
					</tr>
					<tr>
						<th><label for="qnaContent">내용</label></th>
						<td colspan="4"><textarea id="qnaContent" name="content" class="form-control" rows="15" style="resize:none;"></textarea></td>					
					</tr>
				</table>
				<br><br>
				<div align="center">
					<button class="btn" type="submit">등록하기</button>
					<button class="btn btn-delete" type="reset">취소하기</button>
				</div>
			</form>
		</div>
		
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>