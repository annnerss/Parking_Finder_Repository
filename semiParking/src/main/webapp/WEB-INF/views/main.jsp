<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Parking Finder</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<style>
	    body {
	        font-family: "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;
	        background-color: #F5F6F8;
			overflow-x: hidden;
	    }
	
	    .search-wrap {
	        width: 500px;
	        margin: 20px auto;
	        /* position: absolute; */
			/* top : 20%;
			left : 10%; */
			z-index: 10;
	    }
	
	    .search-title {
	        font-size: 20px;
	        font-weight: 700;
	        margin-bottom: 15px;
	    }
	
	    .search-box {
        	border-radius: 8px;
			z-index: 100;
			background: white;
	        display: flex;
	        gap: 10px;
	    }
	
	    #keyword {
	        flex: 1;
	        padding: 12px 14px;
	        font-size: 15px;
	        border-radius: 8px;
	        border: 1px solid #ccc;
	    }
	
	    .search-box button {
	        padding: 12px 18px;
	        border-radius: 8px;
	        border: none;
	        background-color: #3B82F6;
	        color: white;
	        font-weight: 600;
	        cursor: pointer;
	    }
	
	    .search-box button:hover {
	        background-color: #2563EB;
	    }

		/*사이드 바 테스트 용*/
		#sidebar {
            position: fixed;
            top: 0; left: -350px; /* 처음에 숨김 */
            bottom: 0;
            width: 350px;
            background: white;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            transition: left 0.3s ease; /* 부드러운 애니메이션 */
            display: flex;
            flex-direction: column;
        }

		.sidebar-top{
			flex: 0 0 auto;
			border-bottom: 1px solid #ddd;
			background: #fff;
			z-index: 102;
		}

		#sidebar-content{
			flex: 1;
			overflow-y: auto;
			position: relative;
		}

		#view-list, #view-detail{
			width: 100%;
			height: 100%;
		}

		.detail-sub-header{
			padding: 10px 15px;
			background-color: #2563EB;
			border-bottom: 1px solid #fff;
			position: sticky;
			top: 0;
		}

        #sidebar.active {
            left: 0; /* 활성화 시 보임 */
        }

        .sidebar-header {
            padding: 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-header h3 { margin: 0; font-size: 18px; }
        .close-btn { font-size: 24px; cursor: pointer; color: #666; }

        #result-list {
            flex: 1;
            overflow-y: auto;
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .result-item {
            padding: 15px;
            border-bottom: 1px solid #f1f1f1;
            cursor: pointer;
        }
        .result-item:hover { background-color: #f0f7ff; }
        .result-item h4 { margin: 0 0 5px 0; font-size: 16px; font-weight: bold; }
        .result-item p { margin: 0; color: #666; font-size: 13px; }

	
	    /* :작은_아래쪽_화살표: 검색 기록 드롭다운 */
	    #searchHistory {
	        position: absolute;
	        top: 110%;
	        width: 100%;
	        background-color: #fff;
	        border-radius: 10px;
	        box-shadow: 0 8px 20px rgba(0,0,0,0.12);
	        padding: 12px;
	        display: none;
	        max-height: 220px;
	        overflow-y: auto;
	        z-index: 100;
	    }
	
	    #searchHistory ul {
	        list-style: none;
	        padding: 0;
	        margin: 0;
	    }
	
	    #searchHistory li {
	        padding: 10px 12px;
	        font-size: 14px;
	        border-radius: 6px;
	        cursor: pointer;
	        display: flex;
	        justify-content: space-between;
	        color: #333;
	    }
	
	    #searchHistory li:hover {
	        background-color: #F1F5F9;
	    }
	
	    .history-date {
	        font-size: 12px;
	        color: #999;
	        margin-left: 10px;
	        white-space: nowrap;
	    }
	
	    .empty-history {
	        text-align: center;
	        font-size: 14px;
	        color: #888;
	        padding: 20px 0;
	    }
	
	    .favorite-link {
	        display: block;
	        text-align: right;
	        margin-top: 20px;
	    }
	
	    .favorite-link a {
	        text-decoration: none;
	        color: #EF4444;
	        font-weight: 600;
	    }
	</style>
</head>
<body>
	
	<%@ include file="/WEB-INF/views/common/menubar.jsp" %>

	<div id="sidebar">
		<div class="sidebar-top">
			<div class="sidebar-header">
				<span class="close-btn" onclick="$('#sidebar').removeClass('active')"><<</span>
			</div>

			<div class="search-box">
				<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
				<button type="button" id="searchBtn">검색</button>
			</div>

			<div id="searchHistory"></div>

		</div>

		<div id="sidebar-content">
			<div id="view-list">
				<ul id="result-list">
					<li style="padding: 20px; text-align: center; color:gray">주차장 이름을 검색하세요.</li>
				</ul>
			</div>

			<div id="view-detail" style="display: none;">
				<div class="detail-sub-header">
					<button type="button" class="back-btn" onclick="goBackToList()">
						&lt; 목록으로 돌아가기
					</button>
				</div>

				<div id="detail-info-area"></div>
			</div>
		</div>	
		<!-- <ul id="result-list">
			<li style="padding: 20px; text-align: center; color:gray">검색어를 입력하세요</li>
		</ul> -->
	</div>

	<button type="button" id="openSide">임시 버튼</button>
	<!-- <div class="search-wrap"> -->
	    <!-- <div class="search-title">주차장 검색</div> -->
	
		<!-- 검색 내용은 감출 이유가 없으니 get으로 -->
	    <!-- <form action="${contextRoot}/search.parking" method="get"> -->
	        
	    <!-- </form> -->
	
	    <!-- 검색 기록 -->
	    <!-- 검색 했던 목록들을 보여주기 위한 태그 -->
	<!-- </div> -->
	
	
	<c:if test="${not empty loginMember}">
	      <div class="favorite-link">
	          <a href="${contextRoot}/favorites.parking">찜 목록</a>
	      </div>
	</c:if>
	
	<!-- 주차장 목록 데이터가 지금 당장은 없으니까 더미 데이터를 이용해서 테스트 해보기 찜이 잘되는지, 찜 목록에 들어가는지 등 보기 위함 -->
	<div>
    	<span>강남대로150길</span> <!-- 이건 주차장 목록이라고 생각. -->
		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.) -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000001">
	        	<button type="submit">:하트2:찜하기</button>
	    	</form>
    	</c:if>
	</div>
	
	<div>
    	<span>논현로131길</span>
		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.) -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000002">
	        	<button type="submit">:하트2:찜하기</button>
	    	</form>
    	</c:if>
	</div>
	
	<div>
    	<span>테헤란로69길</span>
		<c:if test="${not empty loginMember}">
			<!-- 찜 하기 버튼은 회원일때만 보이게 하자. 주차장 정보는 보이게 하는게 좋다. (비회원이여도 주차장 정보는 보게 해주는게 맞다.)  -->
	    	<form action="${contextRoot}/favorites.parking" method="post" style="display:inline;">
	        	<input type="hidden" name="parkingNo" value="122-1-000003">
	        	<button type="submit">:하트2: 찜하기</button>
	    	</form>
    	</c:if>
	</div>
	
	<!-- 지도 불러오기 -->
	<%@ include file="/WEB-INF/views/parkingMap/parkingMap.jsp" %>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<script>
	$(function(){
	
	    let memId = "${loginMember != null ? loginMember.memId : ''}"; // 세션에서 갖고온 로그인 멤버에 대한 조회
	
	    //동적인 요소에 이벤트 걸기 (11시 44분에 추가)
	    $("#searchHistory").on("mousedown", "span", function () {
	        $("#keyword").val($(this).text());
	        $("#searchHistory").slideUp();
	    });

	    $("#keyword").click(function(){ // 클릭을 했을땐 다 보이게끔
	
	    	let value = $(this).val(); // ajax안에 넣으면 의도한 대로 값이 나오지 않음.
	    	
	        $.ajax({
	            url : "searchList.parking",
	            data : { memId : memId },
	            success : function(list){
	            	
	            	if(value.length!==0) { // 만약 검색 내용란에 입력한게 있으면 키워드에 맞게 나온 내용들 안지우기
	            		$("#searchHistory").slideDown(); // 슬라이드 다운 냅두기 만약 안걸어주면 목록 안보임
	                	return;
	                }
	
	                $("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
	                // 따라서 비워주는 역할을 해두는게 좋다.
	               
	                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
	                    $("#searchHistory").html(
	                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
	                    );
	               
	                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
	                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
	                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
	                    return;
	                }
	
	                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.
	
	                for(let h of list){
	                    if(h.searchContent){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
	                        ul.append(
	                            $("<li>")
	                                .append("<span>" + h.searchContent + "</span>")
	                                .append("<span class='history-date'>" + h.hDate + "</span>") //검색 내용 및 날짜를 띄우게 하기
	                        );
	                    }
	                }
	                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기
	            },
	           
	            error : function(){
	                 console.log("통신 실패!");
	            }
	        });
	    });
	
	    $("#keyword").blur(function(){
	        $("#searchHistory").slideUp();
	    });
	   
	    $("#keyword").on("input",function(){
	    	let value = $(this).val(); // 입력할때의 검색 내용 길이
	    	if(value.length===0) { // 입력한 내용이 아예 없을때
	    		$.ajax({
		            url : "searchList.parking",
		            data : { memId : memId },
		            success : function(list){
		                $("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
		                // 따라서 비워주는 역할을 해두는게 좋다.
		               
		                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
		                    $("#searchHistory").html(
		                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
		                    );
		                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
		                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
		                   
		                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
		                    return;
		                }
		
		                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.

		                for(let h of list){
		                    if(h.searchContent){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
		                        ul.append(
		                            $("<li>")
		                                .append("<span>" + h.searchContent + "</span>")
		                                .append("<span class='history-date'>" + h.hDate + "</span>") //검색 내용 및 날짜를 띄우게 하기
		                        );
		                    }
		                }
		
		                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기
		            },
		           
		            error : function(){
		                 console.log("통신 실패!");
		            }
		        });
	    	} else {
	    		 if (value.trim().length < 2) { // 이게 문제가 두글자를 입력할때 예를 들어, 대로를 입력하면 대로 라는 키워드만 포함되서 나와야하는데
	    			  //입력할때 대를 먼저 입력하니까 대에 대한것도 나온다..
	    			  //그래서 두글자 이상으로 걸어두었다. (물론 공백 제외)
	    		      $("#searchHistory")
	    		          .html("<div class='empty-history'>두 글자 이상 입력하세요</div>")
	    		          .slideDown();
	    		      return;
	    		 }
	    		
	    		$.ajax({
	    			url : "searchKeywordParking.parking",
	    			data : { value : value },
	    			success : function(list) {
	    				// 이제 목록을 어떻게 넣는가? 이게 문제.
	    				console.log("통신 성공!");
	    			    console.log(list);
	    						
	    				$("#searchHistory").empty();// 매번 DB에서 회원의 검색 기록을 조회 해오기 때문에 검색 기록이 누적 되는 상황이 발생한다.
	    				
		                // 따라서 비워주는 역할을 해두는게 좋다.
		               
		                if(!list || list.length === 0){ // 반환 받은 리스트가 없거나 길이가 0이면 (비회원 일때 처리,회원도 최초 검색 할때)
		                    $("#searchHistory").html(
		                        "<div class='empty-history'>검색 기록이 없습니다.</div>"
		                    );
		                    //$("#searchHistory").css('display','block'); // 검색 내용 란에 클릭을 했을때 보이게 하기
		                    //slideDown은 none일때만 적용 가능하기 때문에 위에 기능을 지웠다.
		                   
		                    $("#searchHistory").slideDown(); // 슬라이드 형식으로 나오게 하기
		                    return;
		                }
		
		                let ul = $("<ul>"); // 공간을 과도하게 차지 하기 때문에 ul태그를 밖으로 빼자.
		
		                for(let h of list){
		                    if(h.parkingName){  // 만약에 검색 내용이 존재한다면 근데 이렇게 되면 조회는 계속 하니까 내용이 많아진다.
		                        ul.append(
		                            $("<li>")
		                                .append("<span>" + h.parkingName + "</span>")
		                                 //검색 내용 및 날짜를 띄우게 하기
		                        );
		                    }
		                }
		                $("#searchHistory").append(ul).slideDown();  // 슬라이드 형식으로 나오게 하기 		
	    			},
	    			
	    			error : function(){
		                 console.log("통신 실패!");
		            }
	    		});
	    	}
	    });

		$("#openSide").click(function(){
			$("#sidebar").addClass("active");
		});

		$("#searchBtn").click(function(){
			let keyword = $("#keyword").val();
			if(!keyword){
				alert("검색어를 입력하세요");
				return;
			}

			searchParkingList(keyword);

			$("#searchHistory").slideUp();
		});

		 $("#keyword").on("keyup", function(key) {
            if(key.keyCode == 13) {
                $("#searchBtn").click();
            }
        });

	    $("#searchHistory").on("mousedown", "li", function () {
	        let selectedText = $(this).find("span").first().text();
	        // 입력창 값 세팅
	        $("#keyword").val(selectedText);
	        // 현재 목록 중 선택한 값과 다른 li 제거
	        $("#searchHistory li").each(function () {
	            let text = $(this).find("span").first().text();
	            if (text !== selectedText) {
	                $(this).remove();
	            }
	        });
	    });
	});

	function searchParkingList(keyword){
		$("#view-detail").hide();
		$("#view-list").show();

		$("#result-list").html('<li style="padding:20px; text-align:center;">검색 중...</li>');

		const resultList = $("#result-list");
		$.ajax({
			url: "parkingSearch.get",
			data:{keyword: keyword},
			success: function(list){
				resultList.empty();

				if(list.length === 0){
					resultList.html('<li style="padding:20px; text-align:center;">검색 결과가 없습니다.</li>');
                    return;
				}
				let html = "";
				list.forEach(p => {
					let item = $(`
						<li class="result-item">
							<h4>\${p.parkingName}</h4>
							<p> 기본 요금 \${p.price}원</p>
							<p>시간당 추가 요금 \${p.priceTime}원</p>
						</li>
					`);

					item.click(function(){
						if(window.moveMap){
							window.moveMap(p.location_X, p.location_Y, p.parkingName);
						}

						openDetailView(p);
					});

					resultList.append(item);
				});
			},
			error:function(){
				 resultList.html('<li style="padding:20px; text-align:center; color:red;">검색 실패</li>');
			}
		});
	}

	function openDetailView(p){
		console.log("??")
		const detailHtml = `
			<div style="padding:20px;">
				<h4 style="font-weight:bold; font-size:20px;">\${p.parkingName}</h4>
				
				<div class="price-box" style="background:#f8f9fa; padding:15px; border-radius:8px;">
					<p> 기본: <strong>\${p.price}원</strong></p>
					<p> 추가: <strong>\${p.priceTime}원</strong></p>
				</div>
				
				<div style="margin-top:20px; display:flex; gap:5px;">
					<button class="btn-reserve" style="flex:1; padding:10px; border-radius:5px; border:none; background:#28a745; color:white;"
						onclick="location.href='${pageContext.request.contextPath}/reservation.get?parkingNo=\${p.parkingNo}'">
						예약하기
					</button>
					<button class="btn-route" style="flex:1; padding:10px; border-radius:5px; border:none; background:#007bff; color:white;"
						onclick="if(window.findRoute) window.findRoute(\${p.location_X}, \${p.location_Y}, '\${p.parkingName}', this)">
						길찾기
					</button>
				</div>
				<div id="sidebar-route-result-\${p.parkingNo}" style="margin-top:10px; font-size:13px; color:#333;"></div>
			</div>
		`;
		$("#detail-info-area").html(detailHtml);

		$("#view-list").hide();
		$("#view-detail").fadeIn(200);
	}

		function goBackToList(){
			$("#view-detail").hide();
   			$("#view-list").fadeIn(200);
		}
</script>
</body>
</html>

