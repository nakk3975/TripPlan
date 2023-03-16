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
	<script src="
		https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js"></script>

	<link rel="stylesheet" type="text/css" href="/static/js/jquery.datetimepicker.css">
	<script src="/static/js/jquery.js"></script>
	<script src="/static/js/jquery.datetimepicker.full.min.js"></script>
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section>
			<div id="calendar-container">
    			<div id="calendar"></div>	
  			</div>
  			<div class="pt-3">
  				<!-- full calendar에서 스케줄 추가 버튼 -->
				<button id="addScheduleButton" class="btn btn-primary btn-block" data-toggle="modal" data-target="#scheduleModal">새로운 일정 추가</button>
  			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<!-- 일정 추가 클릭시 일정 입력 모달 -->
	<div id="scheduleModal" class="modal fade">
  		<div class="modal-dialog modal-lg" role="document">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title">새로운 일정 추가</h5>
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
      			</div>
      			<div class="modal-body">
        			<form id="scheduleTitleForm">
          				<div class="form-group">
            				<label id="scheduleTitleLabel">제목</label>
            				<input type="text" class="form-control" id="scheduleTitle">
          				</div>
          				<div class="form-group">
				            <label id="scheduleStartDate">시작 날짜, 시간</label>
				            <input type="text" class="form-control" id="scheduleStartDatepicker">
            
			          	</div>
			          	<div class="form-group">
				            <label id="scheduleEndDate">끝나는 날짜, 시간</label>
				            <input type="text" class="form-control" id="scheduleEndDatepicker">
            
			          	</div>
			          	<div class="form-group">
            				<label id="scheduleCostLabel">비용</label>
            				<input type="text" class="form-control" id="scheduleCost">
          				</div>
          				<div class="form-group">
            				<label id="scheduleMoveLabel">이동수단</label>
            				<input type="text" class="form-control" id="scheduleMove">
          				</div>
          				<div class="form-group">
            				<label id="scheduleContentLabel">내용</label>
            				<textarea class="form-control" id="scheduleContent" rows="3"></textarea>
          				</div>
       				</form>
   				</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        			<button type="button" class="btn btn-primary" id="saveScheduleBtn" >저장</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!-- 내용 저장 모달 -->
	<!-- 일정 추가 클릭시 일정 입력 모달 -->
	

<script src="/static/js/form.js"></script>

<script>

	$(document).ready(function(){
		
		// 일정 저장
		$("#saveScheduleBtn").on("click", function() {
			let title = $("#scheduleTitle").val();
			let startTime = $("#scheduleStartDatepicker").val();
			let endTime = $("#scheduleEndDatepicker").val();
			let cost = $("#scheduleCost").val();
			let move = $("#scheduleMove").val();
			let content = $("#scheduleContent").val();
			
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
			if(!valueCheck($("#scheduleTitle"), "제목")){
				return;
			}
			
			
			$.ajax({
				type:"post"
				, url:"/schedule/inputTitle"
				, data:{"title":title}
				, success:function(data) {
					if(data.result == "success") {
						$.ajax({
					 		type:"post"
					 		, url:"/schedule/input"
					 		, data:{"content":content, "startTime":startTime, "endTime":endTime, "move":move, "cost":cost}
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
						alert("일정 추가 실패");
						location.reload();
					}
				}
				, error:function() {
					alert("일정 추가 에러")
				}
			});
		});
		
		// datetimepicker
		$("#scheduleStartDatepicker").datetimepicker();
		$("#scheduleEndDatepicker").datetimepicker();
		
		
		// ful calendar 화면
      	// calendar element 취득
    	var calendarEl = $('#calendar')[0];
      	// full-calendar 생성하기
      	var calendar = new FullCalendar.Calendar(calendarEl, {
        	height: '700px', // calendar 높이 설정
        	expandRows: true, // 화면에 맞게 높이 재설정
        	// 해더에 표시할 툴바
        	headerToolbar: {
          		left: 'prev,next today',
          		center: 'title',
          		right: 'dayGridMonth,timeGridDay'
        	},
        	navLinks: true,
        	initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        	editable: true ,
        	locale: 'ko', // 한국어 설정
        	events: function(info, successCallback, failureCallback) {
        		$.ajax({
        			type:"post"
        			, url:"/schedule/list"
        			, success:function(data) {
        				var events = [];
        				for(let i = 0; i < data.length; i++) {
        					events.push({
        						id : data[i].id
        						, title : data[i].title
        						, start : data[i].startTime
        						, end : data[i].endTime
        					});
        				}
        				successCallback(events);
        			}
        			, error:function() {
        				alert("불러오기 에러");
        			}
        		});
        	}
      	});
   		// 캘린더 랜더링
   		calendar.render();
   		
   		// 일정 클릭시 수정
   		calendar.on("eventClick", function(info) {
   			let id = info.event.id;
   			location.href="/schedule/detail/view?scheduleId=" + id;
   		});
	});
</script>
</body>
</html>