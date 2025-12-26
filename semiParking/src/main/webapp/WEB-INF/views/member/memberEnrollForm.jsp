<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
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
    </style>
</head>
<body>
    
    <!-- 메뉴바 -->
    <%@ include file="/WEB-INF/views/common/menubar.jsp" %>

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>회원가입</h2>
            <br>

            <form action="${contextRoot }/insert.me" method="post">
                <div class="form-group">
                    <label for="inputId">* 아이디 : </label>
                    <input type="text" class="form-control" id="inputId" placeholder="아이디를 입력하세요." name="memId" required>
                    <div id="resultDiv" style="font-size:0.8em; display:none"></div>
                    <button type="button" class="form-control" id="duplicate" name="duplicate">중복체크</button><br>
					                   
                    <label for="userName">* 이름 : </label>
                    <input type="text" class="form-control" id="userName" placeholder="이름을 입력하세요." name="memName" required> <br>

                    <label for="inputPwd">* 비밀번호 : </label>
                    <input type="password" class="form-control" id="inputPwd" placeholder="비밀번호를 입력하세요.(영문,숫자,특수문자 포함 8~16자)" name="memPwd" required>
                    <div id="resultPwd" style="font-size:0.8em; display:none"></div><br>
                    
                    <label for="checkPwd">* Password Check : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="확인 비밀번호를 입력하세요." required> 
                    <div id="resultCheckPwd" style="font-size:0.8em; display:none"></div><br>

					<label for="vehicleId">* 주차차량 : </label>
					<input type="text" class="form-control" id="vehicleId" name="vehicleId" required> <br>                     

                    <label for="email"> &nbsp; 이메일 : </label>
                    <input type="text" class="form-control" id="email" placeholder="Please Enter Email" name="email"> <br>

                    <label for="phoneNum"> &nbsp; 연락처 : </label>
                    <input type="tel" class="form-control" id="phone" placeholder="Please Enter Phone" name="phoneNum"> <br>
                    
                    
                </div> 
                <br>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary disabled" onclick="return validate();">회원가입</button>
                    <!-- 중복 체크 하기전까진 비활성화 -->
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
        </div>
        <br><br>
    </div>
	
	<script>
	    
	    //중복 아이디 체크 (비동기적 통신)
	    $("#duplicate").click(function(){
	    	let inputId = $("#inputId").val(); // 중복확인 버튼 눌렀을때 아이디 입력란에서 값을 갖고오기 
	    	
	    	if(inputId.length < 5 ) {
	    		$("#resultDiv").html("아이디는 5글자 이상 입력해야합니다.");
	    		$("#resultDiv").css("display", "block"); // display:none이니까 풀어줘야한다. 
	    		return; 
	    	}
	    	
			
				$.ajax({
		    		url:"idcheck.me",
		    		data : {
		    			
		    			inputId : $("#inputId").val() 
		    		},
		    		
		    		success : function(result) { // 비교를 컨트롤러에서하기  
		    			console.log(result);
		    		
		    		    //일단 통신 성공이면 무조건 결과는 보이게 해야한다. 
		    		
		    			$("#resultDiv").css("display", "block");
		    			
		    		
		    			if(result=='NNNNY') {
		    				$(".btns button[type=submit]").prop("disabled",false);	
		    				$("#resultDiv").html("사용 가능한 아이디입니다.");
		    			} else {
		    				$("#resultDiv").html("사용 불가능한 아이디입니다.");
		    			}
		    			
		    		},
		    		
		    		error : function(){
		    			console.log("통신 실패"); 
		    		}
		    		
		    	});
	    })
	    
	   
	    
	    //입력 비밀번호 -> inputPwd
	    $("#inputPwd").blur(function(){ // 포커스를 잃는 순간 이벤트 발생 
	    	
	    	let regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[^\s]{8,16}$/;
	    	
	    	//영문자,숫자,특수문자 모두 포함 해야하고 시작과 끝의 제한은 없음. 빈 문자열은 제외 그리고 비밀번호는 8~16자 인 정규식
	    	
	    	if(regExp.test($("#inputPwd").val())) { // 입력한 비밀번호가 정규식을 만족할때 
	    		
	    		$("#resultPwd").html("사용 가능한 비밀번호입니다."); // 만족하면 메시지 추가 
	    		
	    		$("#resultPwd").css("display", "block"); // display:none이니까 풀어줘야한다.
	    		
	    	} else {
	    		$("#resultPwd").html("영문자,숫자,특수문자 포함 8~16자이여야 합니다. 다시 입력해주세요."); 
	    		
	    		$("#resultPwd").css("display", "block");
	    	}
	    
	    }); 
	    
	    //체크 비밀번호 -> checkPwd 
	    $("#checkPwd").blur(function(){ // 포커스를 잃는 순간 이벤트 발생 
	    	
	    	let inputPwd = $("#inputPwd").val(); // 비밀번호 입력란에 작성한 비밀번호 
	    
	    	let checkPwd = $("#checkPwd").val(); // 비밀번호 확인란에 작성한 비밀번호 
	    	
	    	if(inputPwd==checkPwd) { // 비밀번호가 일치하면 메시지 띄우기 
	    		if(inputPwd.length > 0){
		    		$("#resultCheckPwd").html("비밀번호와 확인 비밀번호가 일치합니다.");
	    		}else{
	    			$("#resultCheckPwd").html("비밀번호를 먼저 입력해주세요.");
	    		}
	    	
	    		$("#resultCheckPwd").css("display", "block");
	    	
	    	} else { // 비밀번호가 일치하지 않으면 메시지 띄우지 않기 
	    		
	    		$("#resultCheckPwd").html("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
	    	
	    		$("#resultCheckPwd").css("display", "block");
	    	
	    	}
	    	
	    })
	    
	    
	
		function validate(){ //회원가입 버튼을 누를때 발생 
	    	
	    	let regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[^\s]{8,16}$/;
	    	
	    	//영문자,숫자,특수문자 모두 포함 해야하고 시작과 끝의 제한은 없음. 빈 문자열은 제외 그리고 비밀번호는 8~16자 인 정규식
	    	
			let memPwd = document.querySelector("#inputPwd"); // 가입할때 비밀번호 란에 넣는 번호 
			let checkPwd = document.querySelector("#checkPwd"); // 가입할때 중복체크 비밀번호 
			
			if(regExp.test(memPwd.value) && regExp.test(checkPwd.value)) {
				
				if(memPwd.value!=checkPwd.value){
					alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
					
					//기본 요청 막아주기
					return false;
				}
			
			} else { // 정규식을 만족하지 않으면 return false; 
				alert("영문자,숫자,특수문자를 모두 포함해야하며 8~16자 범위여야 합니다.");
				
				return false; 
			}
		}
	    
	</script>



    <!-- 푸터바 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>