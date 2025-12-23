<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    
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
        
        .activate {
		    padding: 10px 18px;
		    border-radius: 12px;           
		    border: none;
		    background-color: #2ecc71;      /* 초록색 */
		    color: #fff;
		    font-size: 14px;
		    font-weight: 600;
		    cursor: pointer;
		    transition: background-color 0.2s ease, box-shadow 0.2s ease;
		}

		/* hover */
		.activate:hover {
		    background-color: #27ae60;
		    box-shadow: 0 4px 10px rgba(46, 204, 113, 0.35);
		}
		
		/* 클릭 시 */
		.activate:active {
		    background-color: #1e8449;
		    box-shadow: 0 2px 6px rgba(46, 204, 113, 0.3);
		}
		
		/* 포커스 (접근성) */
		.activate:focus {
		    outline: none;
		    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.35);
		}
    </style>
</head>
<body>
	
    <%@ include file="/WEB-INF/views/common/menubar.jsp" %>
   
    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>마이페이지</h2>
            <br>
			<!-- 
				수정하기 : updateMember()  / update.me
				성공시 로그인정보 갱신,정보수정 성공 메시지 / 마이페이지로 이동
				실패시 정보수정 실패 메시지 alert / 마이페이지로 이동  
				 		
			
			 -->
            <form action="${contextRoot}/update.me" method="post">
                <div class="form-group">
                    <label for="inputId">* 아이디 : </label>
                    <input type="text" class="form-control" id="myPageId" placeholder="아이디를 입력하세요." name="memId" value="${loginMember.memId}" readOnly> <br>
                    
                    <label for="userName">* 이름 : </label>
                    <input type="text" class="form-control" id="myPageName" placeholder="이름을 입력하세요." name="memName" value="${loginMember.memName}" required> <br>
                    
					<!--  
                    <label for="inputPwd">* 비밀번호 : </label>
                    <input type="password" class="form-control" id="myPagePwd" placeholder="비밀번호를 입력하세요.(영문,숫자,특수문자 포함 8~16자)" name="memPwd" required> <br>
                    <div id="resultPwd" style="font-size:0.8em; display:none"></div>
                    
                    <label for="checkPwd">* Password Check : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="확인 비밀번호를 입력하세요." required> <br>
                    <div id="resultCheckPwd" style="font-size:0.8em; display:none"></div>
                    -->
                    

					<label for="vehicleId">* 주차차량 : </label>
					<input type="text" class="form-control" id="vehicleId" name="vehicleId" value="${loginMember.vehicleId}" required> <br>                     

                    <label for="email"> &nbsp; 이메일 : </label>
                    <input type="text" class="form-control" id="email" placeholder="이메일을 입력해주세요." name="email" value="${loginMember.email}"> <br>

                    <label for="phoneNum"> &nbsp; 연락처 : </label>
                    <input type="tel" class="form-control" id="phone" placeholder="연락처를 입력해주세요." name="phoneNum" value="${loginMember.phoneNum}"> <br>
                    
                    <input type="hidden" name="status" value="${loginMember.status}"> <!-- 휴면 계정인지 파악하기 위해 status까지 value에 두기 -->
                </div> 
                <br>
                <div class="btns" align="center">
                	
                	<!-- 추가 (12/23) 만약에 휴면 계정일때 휴면 해제 버튼 보이게끔 설정 -->
                	<c:if test="${loginMember.status eq 'H'}">
                		<button type="submit" class="activate">휴면 해제</button>
                	</c:if>
                
                	<c:if test="${loginMember.status eq 'Y'}">
	                    <button type="submit" class="btn btn-primary">수정하기</button>
	                    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#changePwdModal">
						        비밀번호 변경
						</button>
	                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteForm">회원탈퇴</button>
	                    
                    </c:if>
                </div>
            </form>
        </div>
        <br><br>
    </div>
    
    <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
    <div class="modal fade" id="deleteForm">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
				
                <form action="${contextRoot }/delete.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div align="center">
                            탈퇴 후 복구가 불가능합니다. <br>
                            정말로 탈퇴 하시겠습니까? <br>
                        </div>
                        <br>	
                        	<!-- 식별용 데이터 전달 방법 1) hidden으로 전달 -->
                        	<input type="hidden" name="userId" value="${loginMember.memId}">
                            <label for="userPwd" class="mr-sm-2">Password : </label>
                            <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="inputPwd" name="memPwd"> <br>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- 비밀번호 변경 Modal (추가) -->
		<div class="modal fade" id="changePwdModal">
		    <div class="modal-dialog">
		        <div class="modal-content">
		
		            <!-- Modal Header -->
		            <div class="modal-header">
		                <h4 class="modal-title">비밀번호 변경</h4>
		                <button type="button" class="close" data-dismiss="modal">&times;</button>
		            </div>
		
		            <form action="${contextRoot}/changePwd.me" method="post"> <!-- 비밀번호 로그인 할때 컨트롤러 주소 바꾸기 -->
		            
		            	<input type="hidden" name="userId" value="${loginMember.memId}">
		                <!-- Modal body -->
		                <div class="modal-body">
		
		                    <label>현재 비밀번호</label>
		                    <input type="password" class="form-control"
		                           name="currentPwd" required>
		                    <br>
		
		                    <label>새 비밀번호</label>
		                    <input type="password" class="form-control"
		                           name="newPwd" required>
		                    <br>
		
		                    <label>새 비밀번호 확인</label>
		                    <input type="password" class="form-control"
		                           name="checkPwd" required>
		
		                </div>
		
		                <!-- Modal footer -->
		                <div class="modal-footer" align="center">
		                    <button type="submit" class="btn btn-primary">변경하기</button>
		                    <button type="button" class="btn btn-secondary"
		                            data-dismiss="modal">취소</button>
		                </div>
		            </form>
		
		        </div>
		    </div>
		</div>
    
    
    

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>