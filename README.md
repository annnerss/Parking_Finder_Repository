# Parking_Finder_Repository
# 1. Project Overview (프로젝트 개요)
- 프로젝트 이름: Parking Finder
- 프로젝트 설명: 주변 주차장 정보 및 실시간 예약 서비스 제공

<br/>
<br/>

# 2. Team Members (팀원 및 팀 소개)
| 서채원 | 전성중 | 유근영 | 조주현 |
|:------:|:------:|:------:|:------:|
| <img src="https://avatars.githubusercontent.com/u/250162373?s=400&u=59aa0a768a3383c0fdbf0a71b1e54e56bcff3ff5&v=4" alt="서채원" width="150"> | <img src="https://avatars.githubusercontent.com/u/223277907?v=4" alt="전성중" width="150"> | <img src="https://avatars.githubusercontent.com/u/250043719?v=4" alt="조수인" width="150"> | <img src="https://avatars.githubusercontent.com/u/216668731?v=4" alt="강민채" width="150"> |
| Team Leader | Team Member | Team Member | Team Member |
| [GitHub](https://github.com/annnerss) | [GitHub](https://github.com/jsj0345) | [GitHub](https://github.com/jsi4770) | [GitHub](https://github.com/minchaeee514) |

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
| 서채원    |  <img src="https://avatars.githubusercontent.com/u/250162373?s=400&u=59aa0a768a3383c0fdbf0a71b1e54e56bcff3ff5&v=4" alt="서채원" width="100"> | <ul><li>프로젝트 계획 및 관리</li><li>팀 리딩 및 커뮤니케이션</li><li>메인 페이지 구현</li><li>마이 페이지 - 진행중인 가계부 목록/이전 가계부 목록 조회 기능 구현</li><li>그룹 가계부 이메일로 회원 초대 기능 구현</li><li>실시간 그룹 가계부 초대 요청 알림 수락/거절 기능 구현</li><li>챌린지 목록 조회/참여 기능 구현</li><li>그룹 가계부 상세 페이지 구현</li><li>그룹 가계부 수입/지출 내역 목록 조회/삭제 기능 구현</li><li>가계부 관리자 기능 구현(예산 금액 수정, 멤버 추가/삭제, 가계부 삭제)</li><li>N분의 1 정산 로직</li><li>수입/지출 내역 추가시 실시간 알림 기능 구현</li></ul>     |
| 전성중   |  <img src="https://avatars.githubusercontent.com/u/223277907?v=4" alt="전성중" width="100">| <ul><li>회원 가입 페이지 구현</li><li>회원가입 기능 구현</li><li>로그인 페이지/기능 구현(소셜 로그인(API) 포함)</li><li>회원 상태에 따른 서비스 제한 기능 구현</li><li>내 가계부 고정 지출 등록 기능 구현</li><li>회원정보 수정 페이지 구현</li><li>수정 기능(프로필 사진 변경, 비밀번호 수정, 회원 탈퇴) 구현</li></ul> |
| 조수인   |  <img src="https://avatars.githubusercontent.com/u/250043719?v=4" alt="조수인" width="100">    |     <ul><li>가계부 종료까지 남은 기간/예산 계산 기능 구현 (예산 초과시 경고)</li><li>개인 소비 패턴(전월 대비, 카테고리별) 분석 기능 구현</li><li>개인/그룹 챌린지 달성시 뱃지 지급 기능 구현</li><li>마이 뱃지 페이지 구현</li><li>회원 별 보유중인 뱃지 목록 조회, 뱃지 분석 기능 구현</li><li>새로운 챌린지 신청 기능 구현</li><li>캘린더뷰 구현/금액, 내용, 카테고리 별 복합 검색 기능 구현</li></ul>  |
| 강민채    |  <img src="https://avatars.githubusercontent.com/u/216668731?v=4" alt="강민채" width="100">    | <ul><li>(개인/그룹)새로운 가계부 추가 페이지 구현</li><li>가계부 정보 입력폼 구현</li><li>개인 가계부 상세페이지 구현</li><li>개인 가계부 수입/지출 내역 목록 조회 기능 구현</li><li>예산 금액 수정 기능 구현</li><li>수입/지출 내역 추가 기능 구현</li><li>최근 수입/지출 내역 목록 조회/선택시 자동 입력 기능 구현</li><li>영수증 분석하기 (네이버 클로바/카카오 검색 API) 기능 구현</li></ul>    |
<br/>
<br/>

# 5. Technology Stack (기술 스택)
## 5.1 Language
|  |  |
|-----------------|-----------------|
| CSS    |  <img src="https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white" alt="CSS" width="100"> | ?    |
| JavaScript    |  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white" alt="JavaScript" width="100"> | ?    |

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
<br/>

UI개발을 위한 라이브러리 styled-components 설치
```
