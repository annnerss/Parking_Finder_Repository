<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성하기</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<style>
		#reviewEnroll{ width:80%;}
		#reviewEnroll td{text-align: left; padding-right:30px;}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp"%>
	<div class="content-wrapper">
		<h2 class="text-center">리뷰 작성하기</h2>
			<!-- rNo(리뷰번호), memId(작성자), point(별점), content(내용), pNo(주차장), createDate(작성일), file(첨부파일?) -->
		
		<form id="reviewEnrollForm" method="post" action="${contextRoot}/photoInsert.rv" enctype="multipart/form-data">
			<input type="hidden" name="pNo" value="${param.pNo}">
			<table class="table" align="center" id="reviewEnroll">
				<tr>
					<th><label for="memId">작성자</label></th>
					<td><input class="form-control" type="text" id="memId" name="memId" value="${loginMember.memId}" readonly></td>
				</tr>
				<tr>
					<th><label for="point">별점</label></th>
					<td><input class="form-control" type="number" id="point" name="point" min="1" max="5" step="1"></td>
				</tr>
				<tr>
					<th><label for="content">리뷰 내용 (최대 200자)</label></th>
					<td><textarea class="form-control" id="content" name="content" rows="5" maxlength="200" style="resize:none;"></textarea></td>
				</tr>
				<tr>
					<th><label for="uploadFiles">사진 첨부</label></th>
					<td><input class="form-control" type="file" id="uploadFiles" name="uploadFiles" multiple accept="image/*" required multiple></td>
				</tr>
			</table>
			<br>
			<div align="center">
				<button class="btn" id="submitBtn" type="submit">등록하기</button>
				<button class="btn" id="resetBtn" btn-delete" type="reset">취소하기</button>
			</div>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>