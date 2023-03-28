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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    
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
				<h3>${selectBoard.title}</h3>
				<span class="text-secondary pt-3 small"><fmt:formatDate value="${selectBoard.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
			</div>
			<hr style="border: solid 1px;">
			<div>
				<span class="d-flex justify-content-end">작성자 : ${selectBoard.nickname}</span>
				<div style="white-space: pre-wrap; word-break: break-all;">${selectBoard.boardContent}</div>
			</div>
			<div class="text-secondary">${selectBoard.tag}</div>
			<div class="d-flex justify-content-between">
				<div>
					<c:choose>
						<c:when test="${selectBoard.like eq false}">
							<i class="bi bi-heart" id="likeInput" data-id="${selectBoard.id}" style="font-size:20px; color: red;"></i>
						</c:when>
						<c:otherwise>
							<i class="bi bi-heart-fill" id="likeCancel" data-id="${selectBoard.id}" style="font-size:20px; color: red;"></i>
						</c:otherwise>
					</c:choose>
				<span class="text-center ml-2"> ${selectBoard.likeCount}개</span>
				</div>
				<c:if test="${userId eq selectBoard.userId}">
					<div>
						<a href="#" id="boardDeleteBtn" class="text-danger" data-id="${selectBoard.id}">삭제</a>
					</div>
				</c:if>
			</div>
			<div class="pt-2">
				<h6 id="commentHead">댓글</h6>
				<hr>
				<div class="input-group mb-3">
				  	<input type="text" class="form-control" id="commentInput" placeholder="댓글을 입력하세요">
			    	<button type="button" class="input-group-text btn" id="commentBtn" data-id="${selectBoard.id}" >등록</button>
				</div>
				<c:forEach var="comment" items="${selectBoard.comment}">
					<div class="pt-2" id="commentLine">
						<h5>${comment.nickname}</h5>
						${comment.commentContent}
					</div>
				</c:forEach>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			$("#boardDeleteBtn").on("click", function() {
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
										location.href="/board/main/view";
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
			
			$("#likeCancel").on("click", function() {
				let boardId = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/board/unlike"
					, data:{"boardId":boardId}
					, success:function(data) {
						if(data.result == "success"){
							location.reload();
						} else {
							alert("좋아요 취소 실패");
						}
					}
					, error:function() {
						alert("좋아요 취소 에러");
					}
				});
			});
			
			$("#likeInput").on("click", function() {
				let boardId = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/board/like"
					, data:{"boardId":boardId}
					, success:function(data) {
						if(data.result == "success"){
							location.reload();
						} else {
							alert("좋아요 실패");
						}
					}
					, error:function() {
						alert("좋아요 에러");
					}
				});
			});
			
			$("#commentBtn").on("click", function() {
				let id = $(this).data("id");
				let comment = $("#commentInput").val();
				
				$.ajax({
					type:"post"
					, url:"/board/comment/create"
					, data:{"boardId":id, "commentContent":comment}
					, success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("댓글 등록 실패");
						}
					}
					, error:function() {
						alert("댓글 등록 에러");
					}
				});
			});
		});
	</script>
</body>
</html>