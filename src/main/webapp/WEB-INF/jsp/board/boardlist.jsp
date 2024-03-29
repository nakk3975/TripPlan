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
			<div class="d-flex justify-content-between">
				<h2>일정 게시판</h2>
				<div class="input-group mb-3 col-4">
					<select id="searchTitle" class="form-control col-4">
    					<option value="title">제목+내용</option>
    					<option value="tag">태그</option>
					</select>
  					<input type="text" class="form-control" id="boardSearch">
  					<span class="input-group-text" id="searchBtn">검색</span>
				</div>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th class="col-1">No.</th>
						<th class="col-7">제목</th>
						<th class="col-1">작성자</th>
						<th class="col-2">작성일</th>
						<th class="col-1">조회</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:forEach var="board" items="${boards}" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td class="board-title" data-id="${board.id}" style="cursor:pointer">${board.title}</td>
							<td>${board.nickname}</td>
							<td><fmt:formatDate value="${board.createdAt}" pattern="yyyy/MM/dd HH:mm"/></td>
							<td>${board.hit}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			// 게시글 검색 기능
			$("#searchBtn").on("click", function() {
				let text = $("#boardSearch").val();
				let selectTitle = $("#searchTitle option:selected").val();
				
				if(text == "") {
					return;
				}
				$.ajax({
					type:"get"
					, url:"/board/search"
					, data:{"text":text, "title":selectTitle}
					, success:function(data) {
						if(data.result == "success") {
							$("#tbody").empty();
							let tbodyHtml = "";
					        let boards = data.boards;
					        
					        for (let i = 0; i < boards.length; i++) {
					          let board = boards[i];
					          let createdAt = new Date(board.createdAt);
					          let formattedDate = createdAt.getFullYear() + '/' +
					                              (createdAt.getMonth() + 1) + '/' +
					                              createdAt.getDate() + ' ' +
					                              createdAt.getHours() + ':' +
					                              createdAt.getMinutes();
					          
					          tbodyHtml += "<tr>";
					          tbodyHtml += "<td>" + (i + 1) + "</td>";
					          tbodyHtml += '<td class="board-title" data-id="' + board.id + '" style="cursor:pointer">' + board.title + "</td>";
					          tbodyHtml += "<td>" + board.nickname + "</td>";
					          tbodyHtml += "<td>" + formattedDate + "</td>";
					          tbodyHtml += "<td>" + board.hit + "</td>";
					          tbodyHtml += "</tr>";
					        }
					        $("#tbody").append(tbodyHtml);
						} else {
							alert("검색 결과가 없습니다.");
						}
					}
					, error:function() {
						alert("검색 에러");
					}
				});
			});
			
			// 게시글 클릭시 조회수가 올라가는 기능
			$("#tbody").on("click", ".board-title", function() {
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
		});
	</script>
</body>
</html>