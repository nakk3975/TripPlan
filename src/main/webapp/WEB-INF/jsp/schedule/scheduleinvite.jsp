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
		<section class="text-center">
			<h2>초대 받은 일정</h2>
			<table class="table text-center">
				<thead>
					<tr>
						<th>번호</th>
						<th>일정 이름</th>
						<th>초대한 사람</th>
						<th></th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="invite" items="${invites}" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${invite.title}</td>
							<td>${invite.nickname}</td>
							<td>
								<button type="button" class="acceptBtn btn btn-primary" data-id="${invite.scheduleId}">수락</button>
								<button type="button" class="refuseBtn btn btn-danger" data-id="${invite.scheduleId}">거절</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			// 수락 버튼 클릭 시
			$(".acceptBtn").on("click", function() {
				let scheduleId = $(this).data("id");
				
				$.ajax({
					type:"post"
					, url:"/schedule/invite/accept"
					, data:{"scheduleId":scheduleId}
					, success:function(data) {
						if(data.result == "success") {
							alert("수락 성공");
							$.ajax({
								type:"get"
								, url:"/schedule/invite/delete"
								, data:{"scheduleId":scheduleId}
								, success:function(data) {
									if(data.result == "success") {
										location.reload();
									} else {
										alert("일정 거절에 실패하였습니다.");
									}
								}
								, error:function() {
									alert("일정 거절 에러");
								}
							});
							location.reload();
						} else {
							alert("수락에 실패하였습니다.");
						}
					}
					, error:function() {
						alert("수락 에러");
					}
				});
				
			});
			
			// 거절 버튼 클릭 시
			$(".refuseBtn").on("click", function() {
				let scheduleId = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/schedule/invite/delete"
					, data:{"scheduleId":scheduleId}
					, success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("일정 거절에 실패하였습니다.");
						}
					}
					, error:function() {
						alert("일정 거절 에러");
					}
				});
			});
		});
	</script>
</body>
</html>