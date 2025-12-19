<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 예약 (네이버 지도)</title>
<style>
    body, html { margin:0; padding:0; height:100%; }
    #map { width: 100%; height: 100vh; }
    
    /* 인포윈도우 스타일 */
    .iw_inner { padding: 10px; min-width: 200px; }
    .iw_inner h4 { margin: 0 0 10px 0; font-size: 16px; }
    .btn-group { display: flex; gap: 5px; margin-top: 10px; }
    
    .btn-reserve { 
        flex: 1; padding: 5px; background: #28a745; color: white; border: none; cursor: pointer; border-radius: 4px;
    }
    .btn-route { 
        flex: 1; padding: 5px; background: #03c75a; color: white; border: none; cursor: pointer; border-radius: 4px;
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
                <p>💰 기본요금: \${parking.price}원</p>
                <p>🚗 총 주차면: \${parking.total}면</p>
                <p> 현재 주차 가능 주차면: \${parking.total-parking.current}면</p>

                <div class="btn-group">
                    <button class="btn-reserve" 
                        onclick="location.href='${pageContext.request.contextPath}/reservation.get?parkingNo=\${parking.parkingNo}'">
                        예약
                    </button>
                    <!-- 길찾기 버튼: 네이버 지도 웹사이트로 연결 -->
                    <button class="btn-route" 
                        onclick="findRoute(\${lat}, \${lng}, '\${parking.parkingName}')">
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

        // 마커 클릭 이벤트
        naver.maps.Event.addListener(marker, "click", function(e) {
            // 다른 열린 창이 있다면 닫기
            infoWindows.forEach(iw => iw.close());
            
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
        });
    }

    let currentPath = null;

    function findRoute(destLat, destLng, destName){
        if(!myLocation){
            alert("위치를 찾을 수 없습니다.")
            return;
        }

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
                // console.log(data);
                if(data.code === 0){
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
</script>

</body>
</html>