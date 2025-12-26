<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록 조회</title>
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
    
	#qnaList>tbody>tr:hover {cursor:pointer;}
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
			<h2 class="text-center">문의사항 게시판</h2>
			<br>
			
			<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
			<c:if test="${not empty loginMember }">
	            <a class="btn btn-secondary" style="float:right;" href="${contextRoot}/qnaInsert.qn">글쓰기</a>
            </c:if>
			
			<table id="qnaList" align="center" border="1">
				<thead>
					<tr>
						<th>글 번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>주차장</th>
						<th>작성일</th>
						<th>공개 범위</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td colspan="6">조회된 게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list }" var="q">
								<tr>
									<td>${q.QNo }</td>
									<td>${q.QTitle }</td>
									<td>${q.memId }</td>
									<td>${q.PNo }</td>
									<td>${q.createDate }</td>
									<td>
										${q.QType eq 0?'':'★'}
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>		
			<!-- 게시글 클릭하여 해당 게시글 상세보기 처리 -->
			<c:if test="${not empty list }">
				<script>
					$(function(){
						let qno;
						let memId;
						$("#qnaList tbody tr").click(function() {
							qno = $(this).children().first().text();
							memId = $(this).children().eq(2).text();
							
							if($(this).children().last().text().includes("★")){
								$(this).attr("data-toggle","modal");
								$(this).attr("data-target","#viewQna");
							}else{
								location.href = "detail.qn?qno="+qno;
							}
						});
						
						$("#viewQnaBtn").click(function(){
							$.ajax({
								url:"/parking/viewQna.qn",
								type:"POST",
								data:{pwd : $("#qnaPwd").val(),
									  qNo : qno,
									  memId : memId
								},
								success:function(response){
									if (response.status === "success") {
						                location.href = "detail.qn?qno=" + response.qno;
						            } else {
						                alert(response.message);
						            }
									$("#qnaPwd").val('');
								},
								error:function(){
									alert("처리에 이상이 생겼습니다.");
									$("#qnaPwd").val('');
								}
							});
						});
					});
				</script>
			</c:if>
			
			<div class="modal fade" id="viewQna" aria-hidden="false">
		        <div class="modal-dialog modal-sm">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h4 class="modal-title">비공개 게시글 조회</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		                <div class="modal-body">
		                    <div align="center">
		                        글을 작성한 회원과 관리자만 조회 가능한 게시글입니다<br>
		                        비밀번호를 입력해주세요
		                    </div>
		                </div>
		                <div class="modal-footer" align="center">
		                	<input type="password" id="qnaPwd" name="qnaPwd">	
		                    <button type="submit" class="btn btn-danger" id="viewQnaBtn">조회</button>
		                </div>
		            </div>
		        </div>
	    	</div>
		
			<!-- 요청 경로 시작 : list.qn 또는 search.qn -->
			<c:url var="url" value="${empty map?'list.qn':'search.qn' }">
				
				<c:if test="${not empty map }">
					<c:param name="condition">${map.condition }</c:param>
					<c:param name="keyword" value="${map.keyword}" />
				</c:if>
				
				<!-- currentPage 값은 페이징바 만드는 반복문에서 각 페이지 숫자 넣어줄 것 -->
				<c:param name="page"></c:param>
			</c:url>
	
			<div id="pagingArea">
				<ul class="pagination">
					<c:choose>
						<c:when test="${pi.currentPage eq  1}"> <!-- 현재페이지 1이면 이전버튼 비활성화 -->
		                	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
						</c:when>                
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${url}${pi.currentPage-1}">Previous</a></li>
						</c:otherwise>
					</c:choose>
					
					<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="i">
						<!-- el표기법으로 3항연산자를 이용하여 조건이 부합할땐 disabled 속성 넣기 아닐땐 빈값처리 -->
		            	<li class="page-item ${i eq pi.currentPage? 'disabled':'' }"><a class="page-link" href="${url }${i}">${i}</a></li>
					</c:forEach>					                    
		                    
					<c:choose>
						<c:when test="${pi.currentPage eq pi.maxPage }">
		               		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${url}${pi.currentPage+1}">Next</a></li>
						</c:otherwise>                    
					</c:choose>
					
				</ul>
			</div>
		
			<br clear="both"><br>
		
			<!-- 검색 후 선택상자 선택시키기 -->
			<c:if test="${not empty map }">
				<script>
					$(function(){
						//검색 condition 유지
						$("option[value=${map.condition}]").attr("selected", true);
					});
				</script>
			</c:if>
		
			<form id="searchForm" action="${contextRoot }/search.qn" method="get" align="center">
				<div class="select">
					<select class="custom-select" name="condition">
						<option value="writer">작성자</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>
				</div>
			
				<div class="text">
					<input type="text" class="form-control" name="keyword" value="${map.keyword }">
				</div>
				<button type="submit" class="searchBtn btn btn-secondary">검색</button>	
			</form>
			<br><br>
		</div>
	</div>
		
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>