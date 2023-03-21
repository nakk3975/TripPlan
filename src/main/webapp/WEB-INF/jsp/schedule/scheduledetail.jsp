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
	
	<link rel="stylesheet" type="text/css" href="/static/js/jquery.datetimepicker.css" >
	<script src="/static/js/jquery.js"></script>
	<script src="/static/js/jquery.datetimepicker.full.min.js"></script>
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="col-12">
			<h2>일정 상세</h2>
			<div class="d-flex">
				<div class="col-9">
					<div>
						<label>제목</label>
						<h4>${schedule.title}</h4>
					</div>
					<div>
						<label>기간</label>
						<h5>
							<fmt:formatDate value="${schedule.startTime}" pattern="yyyy-MM-dd HH:mm"/>
						 	~ 
						 	<fmt:formatDate value="${schedule.endTime}" pattern="yyyy-MM-dd HH:mm"/>
						</h5>
					</div>
					<div>
						<label>비용</label>
						<h5>${schedule.cost}원</h5>
					</div>
					<div>
						<label>이동수단</label>
						<h5>${schedule.move}</h5>
					</div>
				</div>
				<div class="col-3">
					<h5>일정 멤버</h5>
					<table border=1 class="text-center">
						<c:forEach var="member" items="${members}">
							<tr>
								<td class="nickname">${member.nickname}</td>
								<c:if test="${userId eq schedule.userId}">
									<c:choose>
										<c:when test="${member.role eq 0}">
											<td><a href="#" class="changeAuthority" data-role="${member.role}">권한 없음</a></td>
										</c:when>
										<c:otherwise>
											<td><a href="#" class="changeAuthority" data-role="${member.role}">권한 있음</a></td>
										</c:otherwise>
									</c:choose>
								</c:if>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>	
			<div>
				<label>내용</label>
				<h5 class="col-12 border" style="word_wrap:break-word;  word-break: break-all;">${schedule.content}</h5>
			</div>
			<c:forEach var="member" items="${members}">
				<c:choose>
					<c:when test="${member.role eq 0}">
						<button type="button" id="inviteBtn" class="btn btn-success" data-toggle="modal" data-target="#inviteModal">초대</button>
					</c:when>
					<c:when test="${member.role eq 1}">
						<div class="d-flex justify-content-between">
							<div>
								<button type="button" id="updateBtn" class="btn btn-primary" data-toggle="modal" data-target="#scheduleModal">수정</button>
								<button type="button" id="inviteBtn" class="btn btn-success" data-toggle="modal" data-target="#inviteModal">초대</button>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-between">
							<div>
								<button type="button" id="updateBtn" class="btn btn-primary" data-toggle="modal" data-target="#scheduleModal">수정</button>
								<button type="button" id="inviteBtn" class="btn btn-success" data-toggle="modal" data-target="#inviteModal">초대</button>
							</div>
							<button type="button" id="deleteBtn" class="btn btn-danger" data-id="${schedule.id}">삭제</button>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<div id="wishList" class="pt-3">
				<h4>추가로 가고 싶은 곳</h4>
				<div class="input-group mb-3">
				  	<input type="text" class="form-control">
				  	<span class="btn input-group-text" id="insertToDoList">입력</span>
				</div>
				<c:forEach var="" items="">				
					<div class="d-flex align-items-start col-10 mt-1">
						<h6></h6>&nbsp;
						<span></span>
					</div>
				</c:forEach>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<!-- 수정 클릭시 일정 입력 모달 -->
	<div id="scheduleModal" class="modal fade">
  		<div class="modal-dialog modal-lg" role="document">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title">일정 수정</h5>
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
      			</div>
      			<div class="modal-body">
        			<form id="scheduleTitleForm">
          				<div class="form-group">
            				<label id="scheduleTitleLabel">제목</label>
            				<input type="text" class="form-control" id="scheduleTitle" value="${schedule.title}">
          				</div>
          				<div class="form-group">
				            <label id="scheduleStartDate">시작 날짜, 시간</label>
				            <input type="text" class="form-control" id="scheduleStartDatepicker" value="<fmt:formatDate value="${schedule.startTime}" pattern="yyyy-MM-dd HH:mm"/>">
            
			          	</div>
			          	<div class="form-group">
				            <label id="scheduleEndDate">끝나는 날짜, 시간</label>
				            <input type="text" class="form-control" id="scheduleEndDatepicker" value="<fmt:formatDate value="${schedule.endTime}" pattern="yyyy-MM-dd HH:mm"/>">
            
			          	</div>
			          	<div class="form-group">
            				<label id="scheduleCostLabel">비용</label>
            				<input type="text" class="form-control" id="scheduleCost" value="${schedule.cost}">
          				</div>
          				<div class="form-group">
            				<label id="scheduleMoveLabel">이동수단</label>
            				<input type="text" class="form-control" id="scheduleMove" value="${schedule.move}">
          				</div>
          				<div class="form-group">
            				<label id="scheduleContentLabel">내용</label>
            				<textarea class="form-control" id="scheduleContent" rows="3">${schedule.content}</textarea>
          				</div>
       				</form>
   				</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        			<button type="button" class="btn btn-primary" id="updateScheduleBtn" data-id="${schedule.id}" data-data-id="${schedule.scheduleId}" >저장</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!-- 초대 버튼 클릭시 유저 검색 모달 -->
	<div id="inviteModal" class="modal fade">
  		<div class="modal-dialog modal-lg" role="document">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title">멤버 검색</h5>
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
      			</div>
      			<div class="modal-body">
        			<form id="memberSearchForm text-center">
          				<div class="form-group">
            				<label id="memberLabel">멤버 아이디</label>
            				<div class="input-group mb-3">
  								<input type="text" class="form-control" id="memberSeacrch">
  								<div class="input-group-append">
    								<button type="button" class="input-group-text btn" id="memberSearchBtn">검색</button>
  								</div>
							</div>
          				</div>
          				<div class="form-group">
            				<table class="table text-center">
								<thead>
									<tr>
										<th>번호</th>
										<th>닉네임</th>
										<th></th>
									</tr>
								</thead>
								
								<tbody id="searchTableBody">
									<c:forEach var="user" items="${users}" varStatus="status">
										<tr>
											<td>${status.count}</td>
											<td class="nickname" id="searchNickname">${user.nickname}</td>
											<td><button type="button" class="memberInviteBtn btn btn-primary" data-member-id="${user.id}" data-schedule-id="${schedule.id}">초대</button></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
          				</div>
       				</form>
   				</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      			</div>
    		</div>
  		</div>
	</div>


	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			
			// 권한 수정
			$(".changeAuthority").on("click", function() {
				let role = $(this).data("role");
				
				$.ajax({
					type:"post"
					, url:"/schedule/member/authority"
					, data:{"role":role}
					, success:function(data) {
						if(data.result == "success") {
							alert("권한 수정이 완료되었습니다.");
							location.reload();
						} else {
							alert("권한 수정에 실패하였습니다.");
						}
					}
					, error:function() {
						alert("권한 수정 에러");
					}
				});
			});
			
			// 검색 버튼 클릭시
			$("#memberSearchBtn").on("click", function() {
				let nickname = $("#memberSeacrch").val();
				
				$.ajax({
					type:"post"
					, url:"/schedule/invite/search"
					, data:{"nickname":nickname}
					, success:function(data) {
						if(data.result == "success") {
							$(".nickname").empty();
							$("#searchNickname").append(data.nickname);
							$("#searchTableBody tr:not(:first)").remove();
						} else {
							alert("일치하는 유저가 없습니다.");
						}
					}
					, error:function() {
						alert("검색 에러");
					}
				});
			});
			
			// 초대 버튼 클릭시
			$(".memberInviteBtn").on("click", function() {
				let userId = $(this).data("member-id");
				let scheduleId = $(this).data("schedule-id");
				
				$.ajax({
					type:"post"
					, url:"/schedule/invite/invite"
					, data:{"scheduleId":scheduleId, "userId":userId}
					, success:function(data) {
						if(data.result == "success") {
							alert("초대 성공");
						} else {
							alert("초대에 실패하였습니다.");
						}
					}
					, error:function() {
						alert("초대 에러");
					}
				});
			});
			
			// 일정 저장
			$("#updateScheduleBtn").on("click", function() {
				let id = $(this).data("id");
				let dataId = $(this).data("data-id");
				let title = $("#scheduleTitle").val();
				let content = $("#scheduleContent").val();
				let startTime = $("#scheduleStartDatepicker").val();
				let endTime = $("#scheduleEndDatepicker").val();
				let cost = $("#scheduleCost").val();
				let move = $("#scheduleMove").val();
				
				if(!valueCheck($("#scheduleTitle"), "제목")){
					return;
				}
				if(!valueCheck($("#scheduleStartDatepicker"), "시작 시간")){
					return;
				}

				if(!valueCheck($("#scheduleEndDatepicker"), "종료 시간")){
					return;
				}

				if(!valueCheck($("#scheduleCost"), "비용")){
					return;
				}

				if(!valueCheck($("#scheduleMove"), "이동수단")){
					return;
				}

				if(!valueCheck($("#scheduleContent"), "내용")){
					return;
				}
				
				$.ajax({
					type:"post"
					, url:"/schedule/updatetitle"
					, data:{"id":id, "title":title}
					, success:function(data) {
						if(data.result == "success") {	
							$.ajax({
								type:"post"
								, url:"/schedule/update"
						 		, data:{"id":dataId, "content":content, "startTime":startTime, "endTime":endTime, "move":move, "cost":cost}
						 		, success:function(data) {
						 			if(data.result == "success"){
						 				alert("저장이 완료 되었습니다.");
						 				location.reload();
						 			} else {
						 				alert("일정 저장 실패");
						 			}
						 		}
						 		, error:function() {
						 			alert("일정 저장 에러");
						 		}
							});
						} else {
							alert("일정 수정 실패");
							location.reload();
						}
					}
					, error:function() {
						alert("일정 수정 에러");
					}
				});
			});
			
			// datetimepicker
			$("#scheduleStartDatepicker").datetimepicker();
			$("#scheduleEndDatepicker").datetimepicker();
			
			// 삭제
			$("#deleteBtn").on("click", function() {
				let id = $(this).data("id");
				
				$.ajax({
					type:"get"
					, url:"/schedule/delete"
					, data:{"scheduleId":id}
					, success:function(data) {
						if(data.result == "success") {
							alert("삭제가 완료되었습니다.");
							location.href="/schedule/view";
						} else {
							alert("삭제 실패");
						}
					}
					, error:function() {
						alert("삭제 에러");
					}
				});
			});
		});
	</script>
</body>
</html>