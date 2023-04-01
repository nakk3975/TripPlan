<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<table class="table">
				<thead>
					<tr>
						<th class="col-1">No.</th>
						<th class="col-7">제목</th>
						<th class="col-1">작성자</th>
						<th class="col-2">작성일</th>
						<th class="col-1">관리</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:forEach var="board" items="${boards}" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td class="board-title" data-id="${board.id}" style="cursor:pointer">${board.title}</td>
							<td>${board.nickname}</td>
							<td><fmt:formatDate value="${board.createdAt}" pattern="yyyy/MM/dd HH:mm"/></td>
							<td><button type="button" class="btn btn-danger delete-btn" data-id="${board.id}">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			$(".board-title").on("click", function() {
				let id = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/board/hit"
					, data:{"boardId":id}
					, success:function(data) {
						location.href="/board/detail/view?id=" + id;
					}
					, error:function() {
						alert("조회수 에러");
					}
				});
			});
			
			$(".delete-btn").on("click",function() {
				let id = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/board/tag/delete"
					, data:{"boardId":id}
					, success:function(data) {
						if(data.result == "success"){
							$.ajax({
								type:"get"
								, url:"/board/delete"
								, data:{"id":id}
								, success:function(data) {
									if(data.result == "success") {
										alert("삭제가 완료되었습니다.");
										location.reload();
									} else {
										alert("삭제 실패");
									}
								}
								, error:function() {
									alert("삭제 에러");
								}
							});
						} else {
							alert("태그 삭제 실패");
						}
					}
					, error:function() {
						alert("태그 삭제 에러");
					}
				});
			});
		});
		
	</script>
</body>
</html>