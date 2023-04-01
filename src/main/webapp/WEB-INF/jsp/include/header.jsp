<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<header>
			<div class="d-flex head-content justify-content-around">
				<a href="/destination/main/view" id="logo" class="col-2">Trip Plan</a>
				<nav class="main-menu col-8 pt-3">
					<ul class="nav justify-content-around">
						<li class="nav-item"><a href="/destination/main/view" class="nav-link font-weight-bold">메인화면</a></li>
						<li class="nav-item"><a href="/board/main/view" class="nav-link font-weight-bold">일정 게시판</a></li>
						<li class="nav-item"><a href="/destination/search/view" class="nav-link font-weight-bold">찾아보기</a></li>
						<li class="nav-item"><a href="/destination/map/view" class="nav-link font-weight-bold">주변지도</a></li>
						<li class="nav-item"><a href="/schedule/view" class="nav-link font-weight-bold">일정보기</a></li>
						<c:if test="${userRole eq 0}">
							<li class="nav-item"><a href="/admin/main/view" class="nav-link font-weight-bold">관리자 페이지</a></li>
						</c:if>
					</ul>
				</nav>
				<c:if test="${not empty userId}">
					<span class="col-2 pt-4">${userLoginId}님<a href="/user/signout">로그아웃</a></span>
				</c:if>
			</div>
			<hr>
		</header>