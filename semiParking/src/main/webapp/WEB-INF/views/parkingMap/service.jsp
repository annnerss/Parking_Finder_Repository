<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>서비스 소개 - Parking Finder</title>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Nanum+Gothic&display=swap" rel="stylesheet">
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- FontAwesome (아이콘) -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<!-- AOS Animation Library (스크롤 시 부드러운 애니메이션) -->
	<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<style>
    body {
        font-family:'Nanum Gothic';
        color: white;
        overflow-x: hidden;
    }

    .hero-section {
        background: #1A237E;
        color: white;
        height: 500px;
        display: flex;
        align-items: center;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .hero-bg-pattern {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        opacity: 0.1;
        background-image: radial-gradient(#ffffff 1px, transparent 1px);
        background-size: 30px 30px;
    }

    .hero-content h1 {
        font-size: 3.5rem;
        font-weight: 800;
        margin-bottom: 20px;
        text-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }

    .hero-content p {
        font-size: 1.2rem;
        opacity: 0.9;
        margin-bottom: 40px;
    }

    .btn-hero {
        background-color: white;
        color: #1A237E;
        font-weight: 700;
        padding: 15px 40px;
        border-radius: 50px;
        font-size: 1.1rem;
        border: none;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .btn-hero:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        background-color: #f8f9fa;
        text-decoration: none;
        color: #2563EB;
    }

    .features-section {
        padding: 100px 0;
        background-color: #F8F9FA;
    }

    .section-title {
        text-align: center;
        margin-bottom: 60px;
    }
    .section-title h2 { font-weight: 800; font-size: 2.5rem; color: #1f2937; }
    .section-title p { color: #6b7280; font-size: 1.1rem; }

    .feature-card {
        background: white;
        padding: 40px 30px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        text-align: center;
        transition: transform 0.3s ease;
        height: 100%;
        border: 1px solid rgba(0,0,0,0.03);
    }

    .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    }

    .icon-box {
        width: 80px; height: 80px;
        background-color: #EFF6FF;
        color: #1A237E;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        margin: 0 auto 25px;
    }

    .feature-card h3 { font-weight: 700; margin-bottom: 15px; font-size: 1.4rem; }
    .feature-card p { color: #666; line-height: 1.6; }

    .stats-section {
        padding: 80px 0;
        background-color: white;
    }
    .stat-item { text-align: center; margin-bottom: 30px; }
    .stat-number { font-size: 3rem; font-weight: 800; color: #1A237E; }
    .stat-label { font-size: 1.1rem; font-weight: 600; color: black; }

    .cta-section {
        background: #111827;
        color: white;
        padding: 80px 0;
        text-align: center;
    }
    .cta-section h2 { margin-bottom: 20px; font-weight: 700; }
    .cta-section p { color: #9CA3AF; margin-bottom: 40px; }
    .btn-outline-white {
        border: 2px solid white;
        color: white;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        transition: 0.3s;
    }
    .btn-outline-white:hover {
        background: white;
        color: #111827;
        text-decoration: none;
    }
</style>
</head>
<body>

    <%@ include file="/WEB-INF/views/common/menubar.jsp" %>

    <c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
    <!-- 1. 히어로 섹션 -->
    <section class="hero-section">
        <div class="hero-bg-pattern"></div>
        <div class="container hero-content" data-aos="fade-up" data-aos-duration="1000">
            <h1>주차, 더 이상 고민하지 마세요</h1>
            <p>목적지 주변 최적의 주차장을 찾고, 실시간 현황 확인부터 예약까지 한 번에.<br>
            당신의 드라이빙 라이프를 스마트하게 바꿔드립니다.</p>
            <a href="${contextRoot}" class="btn-hero">
                <i class="fas fa-map-marked-alt"></i> 지금 주차장 찾기
            </a>
        </div>
    </section>

    <!-- 2. 주요 기능 섹션 -->
    <section class="features-section">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Why Parking Finder?</h2>
                <p>저희가 제공하는 핵심 서비스입니다</p>
            </div>

            <div class="row">
                <!-- 기능 1 -->
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="icon-box">
                            <i class="fas fa-search-location"></i>
                        </div>
                        <h3>스마트 검색</h3>
                        <p>네이버 지도 기반의 정밀한 데이터로<br>목적지 주변 주차장을 쉽고 빠르게<br>검색할 수 있습니다.</p>
                    </div>
                </div>

                <!-- 기능 2 -->
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="icon-box">
                            <i class="fas fa-car-side"></i>
                        </div>
                        <h3>실시간 현황 & 예약</h3>
                        <p>빈 자리가 있는지 가볼 필요 없습니다.<br>실시간 잔여 구획을 확인하고<br>미리 예약하여 자리를 확보하세요.</p>
                    </div>
                </div>

                <!-- 기능 3 -->
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="icon-box">
                            <i class="fas fa-route"></i>
                        </div>
                        <h3>최적 경로 안내</h3>
                        <p>현재 내 위치에서 주차장까지,<br>네이버 지도 기반의 실시간 교통정보를 반영한<br>최적의 경로를 안내해 드립니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 3. 통계 섹션 (신뢰도) -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-4 stat-item" data-aos="zoom-in">
                    <div class="stat-number counter">500+</div>
                    <div class="stat-label">등록된 주차장</div>
                </div>
                <div class="col-md-4 stat-item" data-aos="zoom-in" data-aos-delay="100">
                    <div class="stat-number counter">24h</div>
                    <div class="stat-label">언제나 이용 가능</div>
                </div>
                <div class="col-md-4 stat-item" data-aos="zoom-in" data-aos-delay="200">
                    <div class="stat-number counter">100%</div>
                    <div class="stat-label">실제 사용자 리뷰</div>
                </div>
            </div>
        </div>
    </section>

    <!-- 4. 하단 CTA -->
    <section class="cta-section">
        <div class="container" data-aos="fade-up">
            <h2>지금 바로 시작해보세요</h2>
            <p>복잡한 도심 속 주차 전쟁, 이제 Parking Finder와 함께라면 문제없습니다.</p>
            <a href="${contextRoot}" class="btn-outline-white">서비스 이용하기</a>
        </div>
    </section>

    <!-- 푸터 포함 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        // AOS 애니메이션 초기화
        AOS.init({
            once: true, // 스크롤 내릴 때 한 번만 실행
            offset: 100 // 애니메이션 시작 지점
        });
    </script>

</body>
</html>