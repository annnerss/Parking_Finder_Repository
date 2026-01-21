# Parking_Finder_Repository
# 1. Project Overview (프로젝트 개요)
- 프로젝트 이름: Parking Finder
- 프로젝트 설명: 주변 주차장 정보 및 실시간 예약 서비스 제공

<br/>
<br/>

# 2. Team Members (팀원 및 팀 소개)
| 서채원 | 전성중 | 유근영 | 조주현 |
|:------:|:------:|:------:|:------:|
| <img src="https://avatars.githubusercontent.com/u/250162373?s=400&u=59aa0a768a3383c0fdbf0a71b1e54e56bcff3ff5&v=4" alt="서채원" width="150"> | <img src="https://avatars.githubusercontent.com/u/223277907?v=4" alt="전성중" width="150"> | <img src="https://avatars.githubusercontent.com/u/100747174?v=4" alt="유근영" width="150"> | <img src="https://avatars.githubusercontent.com/u/249597393?v=4" alt="조주현" width="150"> |
| Team Leader | Team Member | Team Member | Team Member |
| [GitHub](https://github.com/annnerss) | [GitHub](https://github.com/jsj0345) | [GitHub](https://github.com/YuGeunYoung) | [GitHub](https://github.com/juhyeon1202) |

<br/>
<br/>

# 3. Key Features (주요 기능)
- **회원가입**:
  - 회원가입 시 DB에 유저정보가 등록됩니다.

- **로그인**:
  - 사용자 인증 정보를 통해 로그인합니다.
 
- **주변 주차장 마커 렌더링**:
  - 네이버 지도 API를 연동해서 내 주변 주차장 검색, 최적경로 탐색, 조회가 가능합니다.

- **주차장 예약**:
  - 원하는 주차장과 원하는 시간대로 회원이 선택한 쿠폰을 사용한 저렴한 예약이 가능합니다.

- **결제**:
  - 주차장 예약을 할 때 카카오페이 API를 연동한 모바일 QR 결제까지 가능합니다.
  
- **사이트 관리자**:
  - 등록되어 있는 주차장 관리, 회원 주차장 예약 관리, 비공개 문의 게시판 관리가 가능합니다.

<br/>
<br/>

# 4. Tasks & Responsibilities (작업 및 역할 분담)
|  |  |  |
|-----------------|-----------------|-----------------|
| 서채원    |  <img src="https://avatars.githubusercontent.com/u/250162373?s=400&u=59aa0a768a3383c0fdbf0a71b1e54e56bcff3ff5&v=4" alt="서채원" width="100"> | <ul><li>프로젝트 계획 및 관리</li><li>팀 리딩 및 커뮤니케이션</li><li>메인 페이지/메뉴바/공통 CSS 스타일링 구현</li><li>관리자 전용 기능 구현(주차장 목록 검색, 회원 예약 정보 수정/취소, 비공개 문의 게시판 접근 제한)</li><li>카카오페이 API 결제 시스템 연동/DB에 결제 내역 저장 및 관리</li><li>보유 쿠폰 목록 조회/결제시 할인율 적용 기능 구현</li></ul>     |
| 전성중   |  <img src="https://avatars.githubusercontent.com/u/223277907?v=4" alt="전성중" width="100">| <ul><li>회원 로그인 처리 및 세션관리</li><li>휴면 계정 판단 로직 및 상태 기반 접근 제어</li><li>계정 상태에 따른 기능 접근 정책 정의</li><li>찜 등록 및 찜 목록 조회</li><li>검색 히스토리 저장 및 조회 기능</li><li>검색 입력 기반 히스토리 조건 조회 처리</li></ul> |
| 유근영   |  <img src="https://avatars.githubusercontent.com/u/100747174?v=4" alt="유근영" width="100">    |     <ul><li>네이버 지도 API 기능 연동/DB기반 마커 랜더링 구현</li><li>GPS 기반 최적 경로 탐색 구현</li><li>스케쥴러를 이용한 실시간 주차 대수 구현/예약 자동 비활성화 구현</li><li>메인 화면 사이드 바 구현</li><li>주차장 검색기능 구현</li><li>입/출차 시간 설정에 따른 요금 계산 로직 구현</li></ul>  |
| 조주현    |  <img src="https://avatars.githubusercontent.com/u/249597393?v=4" alt="조주현" width="100">    | <ul><li>문의사항 글 조회/작성/삭제/검색 기능 구현</li><li>문의글 수정 및 삭제 기능 권한 제한 처리</li><li>사진 리뷰 작성 기능</li><li>회원가입 시 할인 쿠폰 자동 발급 기능</li><li>중복 및 유효하지 않은 쿠폰 발급 제한</li><li>만료일에 따른 쿠폰 사용 불가 제한</li></ul>    |
<br/>
<br/>

# 5. Technology Stack (기술 스택)
## 5.1 Language
|  |  |
|-----------------|-----------------|
| CSS    |  <img src="https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white" alt="CSS" width="100"> |
| JavaScript    |  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white" alt="JavaScript" width="100"> |
| HTML    |  <img src="https://img.shields.io/badge/HTML-239120?style=for-the-badge&logo=html5&logoColor=white" alt="HTML" width="100"> |

https://github.com/envoy1084/awesome-badges
<br/>

## 5.2 Frotend
|  |  |  |
|-----------------|-----------------|-----------------|
| React    |  <img src="https://github.com/user-attachments/assets/e3b49dbb-981b-4804-acf9-012c854a2fd2" alt="React" width="100"> | ?    |

<br/>

## 5.3 Backend
|  |  |  |
|-----------------|-----------------|-----------------|
| SqlDeveloper    |  <img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=black" alt="SqlDeveloper" width="100">    | ?    |
<br/>

## 5.4 Cooperation
|  |  |
|-----------------|-----------------|
| Git    |  <img src="https://github.com/user-attachments/assets/483abc38-ed4d-487c-b43a-3963b33430e6" alt="git" width="100">    |
| Notion    |  <img src="https://github.com/user-attachments/assets/34141eb9-deca-416a-a83f-ff9543cc2f9a" alt="Notion" width="100">    |

<br/>

# 6. Development Workflow (개발 워크플로우)
## 브랜치 전략 (Branch Strategy)
우리의 브랜치 전략은 Git Flow를 기반으로 하며, 다음과 같은 브랜치를 사용합니다.

- Main Branch
  - 배포 가능한 상태의 코드를 유지합니다.
  - 모든 배포는 이 브랜치에서 이루어집니다.
  
- {name} Branch
  - 팀원 각자의 개발 브랜치입니다.
  - 모든 기능 개발은 이 브랜치에서 이루어집니다.

<br/>
