# TripPlan

> 웹 프로젝트 · 지도·일정 공유·커뮤니티

여행지 정보를 확인하고 여행 일정을 만들고 공유할 수 있도록 구현한 Spring Boot 기반 여행 플래너 웹 프로젝트입니다.

## 주요 기능

### 여행 정보

- 지도 API 연동
- 지도에 관광지 마커 및 상세 정보 표시
- 지역별 관광지 목록 조회
- 주변 관광지 검색 및 검색 반경 처리
- 관광지 상세 화면 제공

### 여행 일정

- 여행 일정 관리
- 일정 공유 및 초대된 일정 확인
- 초대된 일정에서 나가기

### 커뮤니티

- 게시글 조회 및 검색
- 좋아요
- 조회수
- 댓글 등록 및 삭제
- 게시글 삭제

### 관리자

- 관리자 페이지
- 관리자 페이지 접근 권한 제어
- 사용자 권한 관련 기능

## 기술 스택

| 영역 | 기술 |
| --- | --- |
| 언어 | Java 17 |
| 프레임워크·라이브러리 | Spring Boot 2.7.9, Spring MVC, JSON 처리 |
| 데이터·라이브러리 | MyBatis 2.3.0, MySQL |
| 화면 | JSP / JSTL |
| 개발 도구 | Gradle |

## 코드 둘러보기

| 위치 | 내용 |
| --- | --- |
| [tripplan/destination](src/main/java/com/ahn/tripplan/destination) | 관광지 조회 |
| [tripplan/schedule](src/main/java/com/ahn/tripplan/schedule) | 여행 일정·초대·할 일 |
| [tripplan/board](src/main/java/com/ahn/tripplan/board) | 게시글·댓글·좋아요 |
| [tripplan/admin](src/main/java/com/ahn/tripplan/admin) | 관리자 기능 |
| [src/main/resources/mappers](src/main/resources/mappers) | MyBatis SQL 매퍼 |
| [src/main/webapp/WEB-INF/jsp](src/main/webapp/WEB-INF/jsp) | JSP 화면 |

## 실행 방법

Java 17과 MySQL을 준비하고 DB 접속 정보 및 프로젝트에서 사용하는 지도/관광 정보 API 설정을 로컬 환경에 구성한 뒤 실행합니다.

```bash
./gradlew bootRun
```

Windows:

```bash
gradlew.bat bootRun
```

> DB 계정과 외부 API 인증 정보는 저장소에 직접 포함하기보다 별도 환경 설정으로 관리하는 것을 권장합니다.

## 목적

외부 관광 정보와 지도 API를 활용한 위치 기반 기능, 사용자 일정 공유, 커뮤니티, 관리자 권한 등 실제 웹 서비스에서 필요한 여러 기능을 하나의 프로젝트로 구현해 보기 위해 개발한 프로젝트입니다.

---

**함께 보기** · [2Team-Workspace](https://github.com/nakk3975/2Team-Workspace) · [EternalReturnGG](https://github.com/nakk3975/EternalReturnGG)
