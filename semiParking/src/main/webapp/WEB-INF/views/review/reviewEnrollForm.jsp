<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성하기</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<style>
		#reviewEnroll{ width:100%;}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menubar.jsp"%>
	<div class="content">
		<br><br>
		<div class="innerOuter">
		<h2 class="text-center">리뷰 작성하기</h2>
		<br>
			<!-- rNo(리뷰번호), memId(작성자), point(별점), content(내용), pNo(주차장), createDate(작성일), file(첨부파일?) -->
		
		<form id="enrollForm" method="post" action="${contextRoot}/photoInsert.rv" enctype="multipart/form-data">
			<div>
				<label>작성자</label> <br>
				<input type="text" name="memId" value="${loginMember.memId}" readonly>
			</div>
			<br>
			
			<div>
				<label>별점</label> <br>
				<input type="number" name="point" min="1" max="5" step="1">
			</div>
			<br>
			
			<div>
				<label>리뷰 내용 (최대 200자)</label> <br>
				<textarea name="content" rows="5" maxlength="200" style="resize:none;"></textarea>
			</div>
			<br>
			
			<div>
				<label>사진 첨부</label> <br>
				<input type="file" name="uploadFiles" multiple accept="image/*">
			</div>
			<br><br>
			
			<div align="center">
				<button type="submit">등록하기</button>
				<button type="reset">취소하기</button>
			</div>
		</form>

		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>