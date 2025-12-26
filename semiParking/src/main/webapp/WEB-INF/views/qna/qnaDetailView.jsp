<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
			<input type="hidden" id="qNo" value="${q.QNo }">
			
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
			
			
			<div align="center">
				<!-- 사용자 본인이 작성한 글일 경우에만 수정하기버튼이 제대로 작동하도록 설정 -->
				<button type="button" id="updateBtn" class="btn btn-primary">수정하기</button>
				
				<!-- 관리자이거나 사용자 본인이 작성한 글일 경우에만 삭제하기 버튼이 제대로 작동하도록 설정 -->
				<button type="button" id="deleteBtn" class="btn btn-danger">삭제하기</button>
			</div>		
		
			<script>
				$(function(){
				    // 댓글 목록
				    replyList();
					
				 // JSP에서 내려온 값
				    let loginMemId = "${empty loginMember ? '' : loginMember.memId}";
				    let writerId   = "${q.memId}";

				    $("#updateBtn").click(function(){

				        if(loginMemId !== writerId){
				            alert("작성자 본인만 수정할 수 있습니다.");
				            return;
				        }

				        let form = $("<form>")
				                    .attr("action","update.qn")
				                    .attr("method","post");

				        let input = $("<input>")
				                    .attr("type","hidden")
				                    .attr("name","qno")
				                    .attr("value","${q.QNo}");

				        form.append(input);
				        $("body").append(form);
				        form.submit();
				    });
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
				
				function replyList(){
					$.ajax({
						url: "replyList.re",
						data: {qNo : ${q.QNo}},
						success:function(list){
							$("#replyListArea tbody").html(""); //리셋
							for(let reply of list){
								let tr = $("<tr>");
								tr.append($("<td>").text(reply.replyWriter),
										  $("<td>").text(reply.replyContent),
										  $("<td>").text(reply.createDate));
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
				});
			</script>	
			
			<table id="replyListArea" class="table" align="center">
                <thead>
                    <tr>
                        <th colspan="2">
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
                        <td colspan="3">댓글(<span id="rcount"></span>)</td>
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