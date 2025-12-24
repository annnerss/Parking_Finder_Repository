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
		            
		            	<input type="hidden" name="memId" value="${loginMember.memId}">
		            	
		                <!-- Modal body -->
		                <div class="modal-body">
		
		                    <label>현재 비밀번호</label>
		                    <input type="password" class="form-control" name="currentPwd" id="currentPwd" required>
		                    <br>
		
		                    <label>새 비밀번호</label>
		                    <input type="password" class="form-control" id="newPwd" name="newPwd" required>
		                    <div id="resultnewPwd" style="font-size:0.8em; display:none"></div>
		                    
		                    <br>
		
		                    <label>새 비밀번호 확인</label>
		                    <input type="password" class="form-control" id="checknewPwd" name="checknewPwd" required>
		                    <div id="resultchecknewPwd" style="font-size:0.8em; display:none"></div>
		
		                </div>
		
		                <!-- Modal footer -->
		                <div class="modal-footer" align="center">
		                    <button type="submit" id="changeBtn" class="btn btn-primary" disabled>변경하기</button>
		                    <button type="button" class="btn btn-secondary"
		                            data-dismiss="modal">취소</button>
		                </div>
		            </form>
		
		        </div>
		    </div>
		</div>
	
	<script>
	
		$(function(){
			
			$("#newPwd").blur(function(){ // 포커스를 잃는 순간 이벤트 발생 
				
				let currentPwd = $("#currentPwd").val(); // 현재 비밀번호에 작성한 비밀번호
				
				let regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[^\s]{8,16}$/;
				
				//영문자,숫자,특수문자 모두 포함 해야하고 시작과 끝의 제한은 없음. 빈 문자열은 제외 그리고 비밀번호는 8~16자 인 정규식
				
				let newPwd = $("#newPwd").val();
				
				if(regExp.test($("#newPwd").val())) { // 입력한 새 비밀번호가 정규식을 만족할때
					
					if(currentPwd === newPwd) { // 현재 비밀번호와 새 비밀번호가 일치한 경우 
						$("#resultnewPwd").html("현재 비밀번호와 새 비밀번호가 일치합니다. 다시 입력해주세요.");
						
						$("#resultnewPwd").css("display","block");
						
					} else { // 현재 비밀번호와 새 비밀번호가 다른 경우 
						
						$("#resultnewPwd").html("사용 가능한 비밀번호입니다."); // 만족하면 메시지 추가
						
						$("#resultnewPwd").css("display","block"); // display:none이니까 풀어줘야 한다. 
						
					}
					
				} else { // 입력한 새 비밀번호가 정규식을 만족하지 않을때 
					$("#resultnewPwd").html("영문자,숫자,특수문자 포함 8~16자이여야 합니다. 다시 입력해주세요.");
					
					$("#resultnewPwd").css("display","block"); 
					
					$("#changeBtn").prop("disabled",true);
					
				}
				
			});
			
			$("#checknewPwd").blur(function(){ // 포커스를 잃는 순간 이벤트 발생
				
				let currentPwd = $("#currentPwd").val(); // 현재 비밀번호에 작성한 비밀번호 
				
				let newPwd = $("#newPwd").val(); // 새 비밀번호 입력란에 작성한 비밀번호 
			
				let checknewPwd = $("#checknewPwd").val(); // 새 비밀번호 확인란에 작성한 비밀번호
				
				if(newPwd===checknewPwd && newPwd!==currentPwd) { // 비밀번호가 일치하면 메시지 띄우기
					
					// 새 비밀번호와 현재 비밀번호가 다른 조건까지 충족해야 변경하기 버튼 활성화 
					
					$("#resultchecknewPwd").html("새 비밀번호와 확인 비밀번호가 일치합니다.");
				
					$("#resultchecknewPwd").css("display","block"); 
					
					$("#changeBtn").prop("disabled",false);
					
				} else { // 일치하지 않으면 메시지 띄우기 일치하지 않는다고 메시지 띄우기
					
					$("#resultchecknewPwd").html("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
				
					$("#resultchecknewPwd").css("display","block"); 
					
					$("#changeBtn").prop("disabled",true);
					
				}
				
			});
			
			
			
			
			
		});
	
	</script>	
    
    
    

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>