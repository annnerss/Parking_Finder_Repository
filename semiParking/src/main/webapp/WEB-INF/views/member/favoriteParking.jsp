<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>찜 목록</title>
    <style>
        .favorite-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
            font-weight: 600;
        }

        .favorite-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border: 2px solid #1A237E;
            border-radius: 10px;
            transition: box-shadow 0.2s;
        }

        .favorite-card:hover { box-shadow: 0 4px 20px rgba(26, 35, 126,0.2); }

        .favorite-info { text-align:left; }

        .favorite-actions { text-align: right; }

        .empty-box {
            padding: 80px 0;
            text-align: center;
            color: #999;
            font-size: 16px;
        }
        
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/common/menubar.jsp" %>

<div class="content-wrapper">
    <h2>찜 목록</h2>
    <c:if test="${empty parkingList}">
        <div class="empty-box">
            찜한 주차장이 없습니다.
        </div>
    </c:if>

    <c:if test="${not empty parkingList}">
        <div class="favorite-list">
            <c:forEach var="item" items="${parkingList}"> 
                <div class="favorite-card">
                    <div class="favorite-info">
                        <div class="favorite-title"> 주차장 이름 : ${item.parkingName}</div>
                        <div class="favorite-basicPrice"> 기본 요금 : ${item.price}</div>
                        <div class="favorite-price"> 1시간 / ${item.priceTime}원 </div>

                        <input type="hidden" id="parkingNo" name="parkingNo"value="${item.parkingNo}">
                    </div>

                    <div class="favorite-actions">
                        <button class="btn btn-delete" id="remove"> 삭제하기 </button>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 모델에서 받아온 parkingList를 순회 -->
    </c:if>
    
    <script>
        $(function(){
            $(".btn-delete").click(function(){
                let parkingNo = $(this).closest(".favorite-card").find("#parkingNo").val(); // 버튼을 눌렀을때 기준으로 가장 가까운 상위 태그 (지정한 선택자가 가장 가까운 범위에 있을때)
                
                let removeTag = $(this).closest(".favorite-card"); // 버튼을 눌렀을때 기준으로 가장 가까운 상위 태그 (지정한 선택자가 가장 가까운 범위에 있을때)

                if(confirm("찜 목록에서 정말 삭제하시겠습니까?")) {
                    $.ajax({
                        url : "removefavorite.parking",
                        
                        data : {
                            parkingNo : parkingNo,
                            memId : "${loginMember.memId}"
                        },
                        
                        success : function(result) {
                            if(result==="삭제") {
                                removeTag.remove(); // div태그 삭제 
                                alert("삭제했습니다.");
                            }
                        },
                        error : function() {
                            console.log("통신 실패!");
                        }
                    });
                      
               } else {
                   return;
               }
                
                location.href="favorites.parking";
            });
        });
    </script>

</div>

</body>
</html>