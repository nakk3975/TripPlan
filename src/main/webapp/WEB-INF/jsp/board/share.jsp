<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			<form id="scheduleShareForm">
   				<div class="form-group">
       				<label id="scheduleTitleLabel">제목</label>
       				<input type="text" class="form-control" id="boardTitle">
   				</div>
        		<div class="form-group">
          			<label id="scheduleContentLabel">내용</label>
       				<!-- 나중에 개행 수정 -->
       				<fmt:formatDate value="${schedule.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm"/>
       				<fmt:formatDate value="${schedule.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
       				<textarea class="form-control" id="boardContent" rows="10">
시간 : ${startTime} ~ ${endTime}
비용 : ${schedule.cost}
내용 : ${schedule.content}
					</textarea>
       				
        		</div>
        		<div class="form-group">
       				<label id="scheduleTagLabel">태그</label>
       				<input type="text" class="form-control" id="boardTag" placeholder="#서울 #대구 #부산 #광주">
   				</div>
     		</form>
   			<div class="d-flex justify-content-between">
     			<button type="button" class="btn btn-primary" id="saveBoardBtn" data-id="${schedule.id}">저장</button>
     			<a href="/board/main/view" class="btn btn-danger">취소</a>
   			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	<script>
		$(document).ready(function() {
			
			$("#saveBoardBtn").on("click", function() {
				let id = $(this).data("id");
				let title = $("#boardTitle").val();
				let content = $("#boardContent").val();
				let tag = $("#boardTag").val();
				
				$.ajax({
					type:"post"
					, url:"/board/create"
					, data:{"scheduleId":id, "title":title, "boardContent":content}
					, success:function(data) {
						if(data.result == "success") {
							$.ajax({
								type:"post"
								, url:"/board/tag/create"
								, data:{"tag":tag}
								, success:function(data) {
									if(data.result == "success") {
										alert("저장이 완료되었습니다.");
										location.href="/board/main/view";
									} else {
										alert("태그 저장 실패");
									}
								}
								, error:function() {
									alert("태그 입력 에러");
								}
							});
						} else {
							alert("저장 실패");
						}
					}
					, error:function() {
						alert("입력 에러");
					}
				});
			});
		
		});
	</script>
</body>
</html>