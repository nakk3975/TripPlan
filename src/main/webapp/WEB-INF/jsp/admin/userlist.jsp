<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripPlan</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section>
			<div>
				<h3>유저 관리</h3>
				<table class="table text-center">
					<thead>
						<tr>
							<th>닉네임</th>
							<th>권한</th>
							<th>권한수정</th>
							<th>탈퇴</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${users}">
							<c:if test="${user.id ne userId}">
								<tr>
									<td>${user.nickname}</td>
									<c:choose>
										<c:when test="${user.level eq 0}">
											<td>관리자</td>
										</c:when>
										<c:otherwise>
											<td>일반회원</td>
										</c:otherwise>
									</c:choose>
									<td><button type="button" class="btn btn-warning update-btn" data-id="${user.id}">권한변경</button></td>
									<td><button type="button" class="btn btn-danger delete-btn" data-id="${user.id}">삭제</button></td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			// 삭제
			$(".delete-btn").on("click", function() {
				let id = $(this).data("id");
				
				$.ajax({
					type:"get"
						, url:"/admin/delete"
						, data:{"id":id}
						, success:function(data) {
							if(data.result == "success") {
								alert("회원 탈퇴가 완료되었습니다");
								location.reload();
							} else {
								alert("회원 탈퇴 실패");
							}
						}
						, error:function() {
							alert("탈퇴 에러");
						}
				});
			});
			
			// 권한 수정
			$(".update-btn").on("click", function() {
				let id = $(this).data("id");
				
				$.ajax({
					type:"post"
					, url:"/admin/level"
					, data:{"id":id}
					, success:function(data) {
						if(data.result == "success") {
							alert("권한 변경이 완료되었습니다");
							location.reload();
						} else {
							alert("권한 변경 실패");
						}
					}
					, error:function() {
						alert("권한 변경 에러");
					}
				});
			});
		});
	</script>
</body>
</html>