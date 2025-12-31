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
        /* 세부페이지마다 공통적으로 유지할 style */
        body {
        	box-sizing:border-box;
        	font-family:'Nanum Gothic';
        }
        
        h2 {
	        font-weight: 700;
	        margin-bottom: 30px;
	        text-align: center;
    	}
        
        .content-wrapper {
	        width: 80%;
	        max-width: 1000px;
	        margin: 80px auto;
	        background-color: white;
	        padding: 40px;
	        border-radius: 15px;
	        box-shadow: 0 4px 20px rgba(26, 35, 126,0.2); 
	        text-align:center;
	    }
	    
        #header {
            background-color: white;
            width:100%;
            height:80px;
            padding:20px;
            padding-right:80px;
            padding-top:10px;
            margin:auto;
            position: fixed;
			z-index: 1000;
        }
        
        #header_1>ul>.logo{width:50px;float:right;}
        
        #header>div {width:100%; margin-bottom:10px;position:relative;}
        #header_1>ul {width:100%; height:100%; list-style-type:none; margin:auto; padding:0;}
        #header_1>ul>li {float:left; width:25%; height:100%; line-height:55px; text-align:center;}
        #header_1>ul>li a {text-decoration:none; color:black; font-size:18px; font-weight:900;}
        #header_1 {height:60%;}

        #header a {text-decoration:none;color:black;}
        
        #menubar:hover{cursor:pointer;}
        
        #menu1, #menu2 {
        	margin-top:20px;
        	display:none; 
        	background-color: white; 
        	right:1px; 
        	width:220px; 
        	border-radius:15px;
        	position:absolute;
        	border: 2px solid black;
        }
        
        #menu1>ul, #menu2>ul{
        	list-style-type:none;
        	padding-top:10px;
        }
        
        #menu1>ul>li, #menu2>ul>li {cursor:pointer;}

		/* 테이블 스타일 */
	    .table {
	        margin-bottom: 0;
	        text-align: center;
	        border : 2px solid #1A237E;
	        border-radius:15px;
	        border-collapse: separate;
			border-spacing: 0;
			overflow: hidden;
	    }
	    
	    .table thead th {
	        background-color: #1A237E; 
	        color: white;
	        border: none;
	        padding: 15px 0;
	        font-weight: 600;
	    }
	
	    .table tbody td {
	        vertical-align: middle; 
	        padding: 15px 0;
	        color: black;
	        border-bottom: 1px solid #f0f0f0;
	    }
	
	    .table-hover tbody tr:hover {
	        background-color: #eff6ff;
	    }
	    
	    /*버튼 CSS*/
	    .btn{
	    	background-color: white;
	    	border: 2px solid #1A237E;
	    	border-radius:15px;
	    	color:#1A237E;
	    	cursor:pointer;
	    	font-weight: 600;
	    	transition: 0.2s;
	    }
	    
	    .btn:hover{
	    	background-color: #1A237E;
	    	border: 2px solid white;
	    	color: white;
	    }
	    
	    .btn-delete {
	        background-color: white;
	        border: 2px solid #dc3545;
	        color: #dc3545;
	        font-weight: 600;
	        border-radius:15px;
	        transition: 0.2s;
	    }
	
	    .btn-delete:hover {
	        background-color: #dc3545;
	        border: 2px solid white;
	        color: white;
	    }
	    
	    .pagination{
	        border: 2px solid #1A237E;
	        color: #1A237E;
	    	font-weight: 600;
	        border-radius:15px;
	        border-spacing: 0;
	        border-collapse: separate;
	        overflow: hidden;
	    }
	    
	    textarea { border-radius:15px important!; }
	    
	    .page-link { color: #1A237E; }
	    .page-link:hover { color: white; background-color:#1A237E; }
	    
	    /*로그인 CSS*/
	    #loginModal .modal-header,
		#loginModal .modal-footer {
		    border: none;
		    justify-content: center;
		}
		
		.modal-content{ color: black; border-radius: 15px; border: 2px solid #1A237E; }
		
	    
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
		function toggleMenu1(){
			$("#menu1").slideToggle("fast"); 
		}
		
		function toggleMenu2(){
			$("#menu2").slideToggle("fast"); 
		}
	</script>
	
    <div id="header">
        <div id="header_1">
            <ul>
            	<li><a href="${contextRoot }"><img src="${contextRoot }/resources/Logo.jpg" alt="로고" style="width:100px"></a></li>
                <li><a href="${contextRoot}/service.pk">서비스 소개</a></li>
                <li><a href="${contextRoot }/qnaListView.qn">문의사항</a></li>
                <li class="logo"><img src="https://img.icons8.com/?size=100&id=aflTW0mA9OBv&format=png&color=000000" style="width:30px" onclick="toggleMenu2()"></li>
            	<li class="logo"><a href="${contextRoot}/favorites.parking"><img src="https://img.icons8.com/?size=100&id=85033&format=png&color=000000" alt="하트 이모티콘" style="width:30px"></a></li>
            	<li class="logo"><img src="https://img.icons8.com/?size=100&id=15263&format=png&color=000000" style="width:30px" onclick="toggleMenu1()"></li>
            </ul>
            <div id="menu1">
            	<ul>
		               	<c:choose>
			            	<c:when test="${empty loginMember }">
			            		<li><a data-toggle="modal" data-target="#loginModal">로그인</a></li>
               					<li><a href="${contextRoot }/enrollForm.me">회원가입</a></li>
			            	</c:when>
			            	<c:otherwise>
				                <!-- 로그인 후 -->
				                <li>${loginMember.memName}님 환영합니다</li>
				                <br>
				                <c:choose>
				                	<c:when test="${loginMember.memId eq 'admin'}">
				                		<!-- 관리자용 메뉴 -->
				                		<li><a href="${contextRoot }/logout.me">로그아웃</a></li>
					            	</c:when>
					            	<c:otherwise>
						            	<!-- 일반 멤버용 메뉴 -->
						                <li><a href="${contextRoot }/mypage.me">마이페이지</a></li>
				               			<li><a href="${contextRoot }/logout.me">로그아웃</a></li>
					            	</c:otherwise>
				                </c:choose>
			            	</c:otherwise>
		            	</c:choose>
                	</ul>
            </div>
            
            <div id="menu2">
                	<ul>
		               	<c:choose>
			            	<c:when test="${empty loginMember }">
               					<li><a data-toggle="modal" data-target="#loginModal">로그인 메뉴</a></li>
			            	</c:when>
			            	<c:otherwise>
				                <c:choose>
				                	<c:when test="${loginMember.memId eq 'admin'}">
				                		<!-- 관리자용 메뉴 -->
				                		<li><a href="${contextRoot }/reserveList.get">전체 예약 정보 목록</a></li>
				                		<li><a href="${contextRoot }/parkingListView.get">주차장 정보 수정</a></li>
					            	</c:when>
					            	<c:otherwise>
						            	<!-- 일반 멤버용 메뉴 -->
				               			<li><a href="${contextRoot }/reservePage.get">예약내역</a></li>
				               			<li><a href="${contextRoot}">쿠폰등록</a></li>
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
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="Enter ID" id="memId" name="memId"> <br>
                        <label for="userPwd" class="mr-sm-2">Password : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="memPwd" name="memPwd">
                    </div>
                           
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" class="btn btn-delete" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
    
    <br clear="both">
</body>
</html>