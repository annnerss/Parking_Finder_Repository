<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
	#replyListArea img { margin: auto;}
</style>
</head>
<body>

	<%@ include file = "/WEB-INF/views/common/menubar.jsp" %>
	<div class="content">
		<br><br>
		<div class="innerOuter">
			<h2>게시글 상세보기</h2>
			<br>
			
			<a class="btn btn-secondary" style="float:right;" href="${header.referer}">목록으로</a>
			<br><br>
			
			<table id="contentArea" align="center" class="table">
				<tr>
					<th width="100">제목</th>
					<td colspan="3">${q.QTitle}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${q.memId}</td>
					<th>작성일</th>
					<td>${q.createDate}</td>
				</tr>
				<tr>
					<th>주차장명</th>
					<td colspan="3">${q.PNo}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="4"><p style="height:150px;">${q.content}</p></td>
				</tr>
			</table>
			<br>
			
			
			<!-- 수정하기, 삭제하기 버튼은 사용자 본인이 작성한 글일 경우에만 보이도록 설정 -->
			<div align="center">
				<c:if test="${loginMember.memId eq q.memId }">
					<button type="button" id="updateBtn" class="btn btn-primary">수정하기</button>
					<button type="button" id="deleteBtn" class="btn btn-danger">삭제하기</button>
				</c:if>
			</div>		
		
			<script>
			
				$(function(){
					//댓글목록 조회 함수 호출
					replyList();
					//수정하기 또는 삭제하기 버튼 눌렀을 때 url로 데이터 접근 및 요청이 불가능하도록 post 방식으로 submit하기
					$("#updateBtn").click(function(){
						//form 태그 및 전달데이터 태그 작성하여 body에 추가하고 실행
						//form에는 action과 method 추가 (서버에 요청용 form)
						let form = $("<form>").attr("action","update.qn").attr("method", "post");
						
						//type, name, value 추가 (글번호 전달용 input)
						let input = $("<input>").attr("type", "hidden").attr("name","qno").attr("value", "${q.QNo}");
						
						//form 태그에 input 태그 넣기
						form.append(input);
						
						//form태그를 body 태그 영역에 추가하여 submit() 요청하기
						$("body").append(form);
						
						//서버에 submit 요청
						form.submit();
					});
					
					//삭제하기 버튼 이벤트 동작 처리
					$("#deleteBtn").click(function() {
						let flag = confirm("정말 삭제하시겠습니까?");
						
						if(flag) {
							let form = $("<form>").attr("action","delete.qn").attr("method","post");
		    				let qnoInput = $("<input>").attr("type","hidden")
													   .attr("name","qno")
													   .attr("value","${q.QNo}");
		
			    			//form에 input 요소 추가하고 body에 추가하여 submit() 요청하기
							form.append(qnoInput);
							$("body").append(form);
							form.submit();
						}
					});
				});
				

				function replyList(){
					$.ajax({
						url: "replyList.re",
						data: {qNo : ${q.QNo}},
						success:function(list){
							$("#replyListArea tbody").html(""); //리셋
							for(let reply of list){
								let tr = $("<tr>");
								tr.append($("<td>").attr("data-reply-no",reply.replyNo).text(reply.replyWriter),
										  $("<td>").text(reply.replyContent),
										  $("<td>").text(reply.createDate),
										  $("<td>").append(
										  $("<img>").attr("src","https://img.icons8.com/?size=100&id=bd7IoT6bIayo&format=png&color=000000")
										  			.attr("alt","쓰레기통 이미지")
										  			.attr("style","width:20px;")));
								//삭제하기 버튼
								$("#replyListArea tbody").append(tr);
							}
							$("#rcount").text(list.length);
						},
						error:function(){
							console.log("댓글 조회 실패");
						}
					});
				}
				
				$(function(){
					$("#replyBtn").click(function(){
						$.ajax({
							url:"insertReply.re",
							data:{
								refQno: ${q.QNo},
								replyContent: $("#content").val(),
								replyWriter: "${loginMember.memId}"
							},
							success:function(result){
								if(result > 0){
									replyList();
									alert("새로운 댓글이 등록되었습니다");
									$("#content").val("");
								}else{
									alert("댓글 등록 실패");
								}
							},
							error:function(){
								console.log("오류 발생");
							}
						});
					});
					
					$(document).on("click","#replyListArea tbody tr img",function(){
						var rNo = $(this).closest("tr").children().first().data("replyNo");
						
						$.ajax({
							url:"deleteReply.re",
							data:{
								replyNo:rNo,
								replyWriter:"${loginMember.memId}",
								refQno:${q.QNo},
							},
							type:"POST",
							success:function(res){
								if(res.status == "success"){
									alert(res.message);
									location.reload();
								}else{
									alert(res.message);
								}
							},
							error:function(){
								console.log("오류 발생");
							}
						});
					});
				})
			</script>	
			
			<table id="replyListArea" class="table" align="center">
                <thead>
                    <tr>
                        <th colspan="3">
                        	<c:choose>
                        		<c:when test="${empty loginMember }">
		                            <textarea class="form-control" placeholder="로그인 후 이용가능합니다." id="content" cols="55" rows="2" style="resize:none; width:100%;" readonly></textarea>
                        		</c:when>
                        		<c:otherwise>
                        			<textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
                        		</c:otherwise>
                        	</c:choose>
                        </th>
                        <th style="vertical-align:middle"><button id="replyBtn" class="btn btn-secondary">댓글등록</button></th>
                    </tr>
                    <tr>
                        <td colspan="4">댓글(<span id="rcount"></span>)</td>
                    </tr>
                </thead>
                <tbody>
                	<!-- 댓글 들어가는 자리 -->
                </tbody>
            </table>
		</div><br>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>