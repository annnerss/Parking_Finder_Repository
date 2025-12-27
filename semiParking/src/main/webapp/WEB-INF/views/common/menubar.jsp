<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Nanum+Gothic&display=swap" rel="stylesheet">
    <title>메뉴바</title>
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- 부트스트랩에서 제공하고 있는 스타일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 부트스트랩에서 제공하고 있는 스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    	
		#loginModal .modal-header,
		#loginModal .modal-footer {
		    border: none;
		}
		
		#loginModal .modal-content {
		    background-color: #eef5ff;
		    border: 2px solid #000;
		    border-radius: 12px;
		}
		
		#loginModal .modal-footer {
		    display: flex;
		    justify-content: center;
		    gap: 12px;
		}
		
		#loginModal .btn-primary {
		    background-color: rgba(13, 110, 253, 0.75);
		    border-color: rgba(13, 110, 253, 0.75);
		}
		
		#loginModal .btn-danger {
		    background-color: rgba(220, 53, 69, 0.75);
		    border-color: rgba(220, 53, 69, 0.75);
		}
		
		#loginModal .btn-primary:hover {
		    background-color: rgba(13, 110, 253, 0.9);
		}
		
		#loginModal .btn-danger:hover {
		    background-color: rgba(220, 53, 69, 0.9);
		}
		
		#loginModal input.form-control {
		    border-radius: 8px;
		    border: 1px solid #b6c8f0;
		}
    	
    	
    
        div {
        	box-sizing:border-box;
        	font-family:'Nanum Gothic';
        }
        
        #header {
            width:80%;
            height:80px;
            padding-top:20px;
            margin:auto;
        }
        
        #header>div {width:100%; margin-bottom:10px;position:relative;}
        #header_1>ul {width:100%; height:100%; list-style-type:none; margin:auto; padding:0;}
        #header_1>ul>li {float:left; width:25%; height:100%; line-height:55px; text-align:center;}
        #header_1>ul>li a {text-decoration:none; color:black; font-size:18px; font-weight:900;}
        #header_1 {height:60%; border-top:1px solid lightgray;}

        #header a {text-decoration:none; color:black;}
        
        #menubar:hover{cursor:pointer;}
        
        #menu {
        	margin-top:20px;
        	display:none; 
        	background-color: rgba(190, 191, 204, 0.5); 
        	right:1px; 
        	width:250px; 
        	position:absolute;
        	z-index: 2;
        }
        
        #menu>ul{
        	list-style-type:none;
        	padding-top:10px;
        }
        
        #menu>ul>li {cursor:pointer;}

        /* 세부페이지마다 공통적으로 유지할 style */
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
	<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
	
	<!-- alertMsg 있으면 알림처리 -->
	<c:if test="${not empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
		
		<c:remove var="alertMsg"/>
	</c:if>
	
	<script>
		function toggleMenu(){
			$("#menu").slideToggle("fast"); 
		}
	</script>
	
    <div id="header">
        <div id="header_1">
            <ul>
            	<li><a href="${contextRoot }"><img src="https://img.icons8.com/?size=100&id=MpRGXrNqKV9E&format=png&color=000000" alt="로고" style="width:40px"></a></li>
                <li><a href="${contextRoot}/service.pk">서비스 소개</a></li>
                <li><a href="${contextRoot }/qnaListView.qn">문의사항</a></li>
                <li><img src="https://img.icons8.com/?size=100&id=aflTW0mA9OBv&format=png&color=000000" id="menubar" alt="메뉴바" style="width:30px" onclick="toggleMenu()"></li>
            </ul>
            <div id="menu">
                	<ul>
		               	<c:choose>
			            	<c:when test="${empty loginMember }">
			            		<li><a data-toggle="modal" data-target="#loginModal">로그인</a></li>
               					<li><a href="${contextRoot }/enrollForm.me">회원가입</a></li>
			            	</c:when>
			            	<c:otherwise>
				                <!-- 로그인 후 -->
				                <li>${loginMember.memName}님 환영합니다</li>&nbsp;
				                <c:choose>
				                	<c:when test="${loginMember.memId eq 'admin'}">
				                		<!-- 관리자용 메뉴 -->
				                		<li><a href="${contextRoot }/reserveList.get">전체 예약 정보 목록</a></li>
				                		<li><a href="${contextRoot }/parkingListView.get">주차장 정보 수정</a></li>
				                		<li><a href="${contextRoot }/logout.me">로그아웃</a></li>
					            	</c:when>
					            	<c:otherwise>
						            	<!-- 일반 멤버용 메뉴 -->
						                <li><a href="${contextRoot }/mypage.me">마이페이지</a></li>
				               			<li><a href="${contextRoot}/favorites.parking">찜목록</a></li>
				               			<li><a href="${contextRoot }/reservePage.get">예약내역</a></li>
				               			<li><a href="${contextRoot}">쿠폰등록</a></li>
				               			<li><a href="${contextRoot }/logout.me">로그아웃</a></li>
					            	</c:otherwise>
				                </c:choose>
			            	</c:otherwise>
		            	</c:choose>
                	</ul>
            </div>
        </div>
    </div>

    <!-- 로그인 클릭 시 뜨는 모달 (기존에는 안보이다가 위의 a 클릭 시 보임) -->
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
        
                <form action="${contextRoot }/login.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <label for="userId" class="mr-sm-2">ID : </label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="Enter ID" id="memId" name="memId" required> <br>
                        <label for="userPwd" class="mr-sm-2">Password : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="memPwd" name="memPwd" required>
                    </div>
                           
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
    
    <br clear="both">
</body>
</html>