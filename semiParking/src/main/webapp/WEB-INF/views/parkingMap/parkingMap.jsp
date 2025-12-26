<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 예약 (네이버 지도)</title>
<style>
    /* [1] 지도를 화면에 꽉 채우기 위한 필수 설정 
    body, html { 
        margin: 0; 
        padding: 0; 
        height: 100%; 
        overflow: hidden; /* 스크롤 방지
    }*/
    
    #map {
    	margin-left: 100px;
    	margin-right: 100px;
        height: 100vh; /* 화면 전체 높이 */
        z-index: 1;
    }
    
    /* [2] 검색창 스타일 (지도 위에 둥둥 떠있어야 함) */
    #search-box {
        position: absolute;
        top: 20px; 
        left: 20px; 
        z-index: 100; /* 지도보다 위에 오도록 설정 */
        background: white; 
        padding: 15px; 
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        display: flex; 
        gap: 10px;
    }
    
    #search-box input { 
        padding: 8px; 
        width: 200px; 
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    #search-box button { 
        padding: 8px 15px; 
        cursor: pointer; 
        background: #007bff; 
        color: white; 
        border: none; 
        border-radius: 4px;
        font-weight: bold;
    }
    
    /* [3] 인포윈도우(정보창) 디자인 */
    .iw_inner { 
        padding: 5px; 
        min-width: 280px; /* 창 넓이 확보 */
    }
    
    .iw_inner h4 { 
        margin: 0 0 10px 0; 
        font-size: 18px; 
        font-weight: bold; 
        border-bottom: 1px solid #eee;
        padding-bottom: 5px;
    }
    
    .iw_inner p { 
        margin: 5px 0; 
        font-size: 14px; 
        color: #555; 
    }

    /* [4] 버튼 그룹 스타일 */
    .btn-group { 
        display: flex; 
        gap: 5px; 
        margin-top: 15px; 
    }
    
    .btn-reserve, .btn-route {
        flex: 1; /* 반반 채우기 */
        padding: 8px 0;
        border: none;
        border-radius: 4px;
        color: white;
        cursor: pointer;
        font-size: 13px;
        font-weight: bold;
    }

    .btn-reserve { background-color: #28a745; } /* 초록색 */
    .btn-reserve:hover { background-color: #218838; }

    .btn-route { background-color: #007bff; }   /* 파란색 */
    .btn-route:hover { background-color: #0069d9; }
    
    .time-highlight { 
        color: #d63384; 
        font-weight: bold; 
        font-size: 15px; 
    }
</style>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- [필수] 네이버 지도 API (ncpClientId에 본인 키 입력) -->
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=sdqbu1mss0"></script>
</head>
<body>

    <div id="map"></div>

<script>
    let map;
    let markers = [];
    let infoWindows = []; // 인포윈도우 관리용 배열
    let myLocation = null; // 내 위치 저장

    // 1. 지도 초기화
    $(function() {
        // 기본 위치 (서울 시청)
        const defaultPos = new naver.maps.LatLng(37.5665, 126.9780);

        map = new naver.maps.Map('map', {
            center: defaultPos,
            zoom: 15
        });

        // 2. 내 위치(GPS) 가져오기
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((position) => {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;
                myLocation = new naver.maps.LatLng(lat, lng);

                map.setCenter(myLocation); // 내 위치로 이동

                // 내 위치 마커 (파란색)
                new naver.maps.Marker({
                    position: myLocation,
                    map: map,
                    title: "내 위치",
                    icon: {
                        content: '<div style="width:20px;height:20px;background:blue;border-radius:50%;border:2px solid white;box-shadow:0 0 5px black;"></div>',
                        anchor: new naver.maps.Point(10, 10)
                    }
                });
            });
        }

        // 3. DB 데이터 로드
        loadParkingData();
    });

    // DB 데이터 가져오기 (AJAX)
    function loadParkingData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/parkingList.get",
            type: "GET",
            dataType: "json",
            success: function(list) {
                console.log("주차장 개수: " + list.length);
                list.forEach(parking => createMarker(parking));
            },
            error: function() { console.log("로딩 실패"); }
        });
    }

    // 마커 생성 함수
    function createMarker(parking) {
        // [중요] 기존 데이터에 맞춰 X=위도, Y=경도 매핑 (DB 데이터 확인 필수)
        const lat = parseFloat(parking.location_X); // 위도 (37...)
        const lng = parseFloat(parking.location_Y); // 경도 (127...)

        const position = new naver.maps.LatLng(lat, lng);

        const marker = new naver.maps.Marker({
            map: map,
            position: position,
            title: parking.parkingName
            // icon: "이미지경로" (필요시 추가)
        });    

        // 인포윈도우 내용 (HTML)
        const contentString = `
            <div class="iw_inner">
                <h4>\${parking.parkingName}</h4>
                <p>기본요금: \${parking.price}원</p>
                <p>총 주차면: \${parking.total}면</p>
                <p> 현재 주차 가능 주차면: \${parking.current}면</p>

                <div class="btn-group">
	                <c:choose>
	                	<c:when test="\${empty loginMember}">
		                	<button class="btn-reserve" style="background-color:lightgray"
		                        onclick="location.href='${pageContext.request.contextPath}/reservation.get?parkingNo=\${parking.parkingNo}'" disabled>
		                        예약
		                    </button>
	                	</c:when>
	                	<c:otherwise>
		                	<button class="btn-reserve"
		                        onclick="location.href='${pageContext.request.contextPath}/reservation.get?parkingNo=\${parking.parkingNo}'">
		                        예약
		                    </button>
	                	</c:otherwise>
	                </c:choose>
                    <button class="btn-route" 
                        onclick="findRoute(\${lat}, \${lng}, '\${parking.parkingName}', this)">
                        길찾기
                    </button>
                </div>
            </div>
        `;

        const infowindow = new naver.maps.InfoWindow({
            content: contentString,
            backgroundColor: "#fff",
            borderColor: "#ccc",
            borderWidth: 1,
            anchorSize: new naver.maps.Size(10, 10),
            anchorSkew: true
        });

        markers.push(marker);
        infoWindows.push(infowindow);

        //마커 클릭 이벤트
        naver.maps.Event.addListener(marker, "click", function(e) {
            // 다른 열린 창이 있다면 닫기
            map.panTo(position);

            infoWindows.forEach(iw => iw.close());
            
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }

            $("#sidebar").addClass("active");

            openDetailView(parking);
        });
        
    }

    let currentPath = null;

    function formatTime(ms) {
        const totalMinutes = Math.round(ms / 1000 / 60);
        
        if (totalMinutes < 60) {
            return totalMinutes + "분";
        } else {
            const hours = Math.floor(totalMinutes / 60);
            const minutes = totalMinutes % 60;
            return hours + "시간 " + minutes + "분";
        }
    }

    // 거리 포맷팅 (미터 -> km)
    function formatDistance(meters) {
        if (meters < 1000) {
            return meters + "m";
        } else {
            return (meters / 1000).toFixed(1) + "km"; // 소수점 첫째 자리까지
        }
    }

    function findRoute(destLat, destLng, destName, btnElement){
        if(!myLocation){
            alert("위치를 찾을 수 없습니다.")
            return;
        }

        if(btnElement) btnElement.innerText = "탐색중...";

        const startStr = myLocation.lng() + "," +myLocation.lat();
        const goalStr = destLng + "," + destLat;

        $.ajax({
            url: "${pageContext.request.contextPath}/getRoute.get",
            type: "GET",
            data:{
                start: startStr,
                goal: goalStr
            },
            dataType: "json",
            success: function(data){
                if(data.code === 0){
                    const summary = data.route.trafast[0].summary;
                
                    const durationStr = formatTime(summary.duration);   // 예: 1시간 5분
                    const distanceStr = formatDistance(summary.distance); // 예: 15.2km
                    
                    // 1. 화면에 정보 표시 (버튼 텍스트 변경 or 알림창)
                    if(btnElement) {
                        // 버튼 글씨를 "15분 (3km)" 형태로 변경하고 클릭 방지
                        btnElement.innerHTML = `<b>\${durationStr}</b> <small>(\${distanceStr})</small>`;
                        btnElement.style.backgroundColor = "#555"; // 색상 변경
                        btnElement.disabled = true; // 중복 클릭 방지
                    } else {
                        alert(`소요시간: \${durationStr}, 거리: \${distanceStr}`);
                    }
                    if(currentPath){
                        currentPath.setMap(null);
                    }

                    const pathArray = data.route.trafast[0].path;

                    const linePath = [];
                    pathArray.forEach(function(coord){
                        linePath.push(new naver.maps.LatLng(coord[1],coord[0]));
                    });

                    currentPath = new naver.maps.Polyline({
                        map:map,
                        path: linePath,
                        strokeColor: '#007bff', // 파란색
                        strokeWeight: 5,        // 두께
                        strokeOpacity: 0.8      // 투명도
                    });

                    // 5. 경로가 잘 보이도록 지도 범위 재설정 (FitBounds)
                    // 출발지와 도착지를 포함하는 사각형 영역을 만듦
                    const bounds = new naver.maps.LatLngBounds(
                        myLocation, 
                        new naver.maps.LatLng(destLat, destLng)
                    );
                    map.fitBounds(bounds);

                } else {
                    console.log(data);
                    alert("경로를 찾을 수 없습니다. (메시지: " + data.message + ")");
                }
            },
            error: function() {
                alert("경로 탐색 요청 실패");
            }
        });
    }

    function moveMap(lat, lng, name){
        const moveLatLng = new naver.maps.LatLng(lat, lng);

        map.setCenter(moveLatLng);
        map.setZoom(18);

        let targetMarker = null;

        for(let marker of markers){
            if(marker.getTitle() === name){
                targetMarker = marker;
                break;
            }
        }

        if(targetMarker){
            naver.maps.Event.trigger(targetMarker,"click");
        }else{
            console.log("비상");
        }
    }
</script>

</body>
</html>