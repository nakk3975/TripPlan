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
	<section class="contents d-flex justify-content-center">
			<div class="join">
				<div class="text-center">
					<h3>아이디 찾기</h3>
					<div class="text-secondary text-center">찾으시려는 계정의 이름과 이메일을 <br>입력해 주세요.</div>
					<input type="text" placeholder="이름" id="nameInput" class="form-control" >
					<input type="text" placeholder="이메일" id="emailIdInput" class="form-control mt-3">
					<input type="text" placeholder="전화번호 (010-0000-0000)" id="phoneNumberInput" class="form-control mt-3">
					<div class="text-center">
						<span id="idSearchFail" class="text-danger small" style="display:none">일치하는 아이디가 없습니다.</span>
					</div>
					<button type="button" id="searchIdBtn" class="btn btn-primary btn-block mt-3">아이디 찾기</button>
					<hr>
					<h3>비밀번호 찾기</h3>
					<div class="text-secondary text-center">찾으시려는 계정의 아이디와 이메일을 <br>입력해 주세요.</div>
					<input type="text" placeholder="아이디" id="idInput" class="form-control" >
					<input type="text" placeholder="이메일" id="emailPasswordInput" class="form-control mt-3">
					<div class="text-center">
						<span id="passwordSearchFail" class="text-danger small" style="display:none">id, 이메일이 일치하지 않습니다.</span>
					</div>
					<button type="button" id="searchPasswordBtn" class="btn btn-primary btn-block mt-3">비밀번호 찾기</button>
					<br>
					<a href="/user/signin/view">로그인으로 이동</a>
			</div>
		</div>
	</section>
	<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
</div>
	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			$("#searchIdBtn").on("click", function() {
				let name = $("#nameInput").val();
				let email = $("#emailIdInput").val();
				let phoneNumber = $("#phoneNumberInput").val();
				
				if(!valueCheck($("#nameInput"), "이름")){
					return;
				}
				
				if(!valueCheck($("#emailIdInput"), "이메일")){
					return;
				}
				
				if(!valueCheck($("#phoneNumberInput"), "이메일")){
					return;
				}
				
				$.ajax({
					tpye: "get"
					, url: "/user/idcheck"
					, data: {"name":name, "email":email, "phoneNumber":phoneNumber}
					, success:function(data) {
						if(data.result == "success") {
							location.href = "/user/idCheck/view";
						} else {
							$("#idSearchFail").show();
						}
					}
					, error:function() {
						alert("아이디 찾기 오류");
					}
				});
			});
			
			$("#searchPasswordBtn").on("click", function() {
				let id = $("#idInput").val();
				let email = $("#emailPasswordInput").val();
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				
				if(!valueCheck($("#emailPasswordInput"), "이메일")){
					return;
				}
				
				$.ajax({
					type: "post"
					, url: "/user/passwordsearch"
					, data: {"loginId":id, "email":email}
					, success:function(data) {
						if(data.result == "success"){
							location.href = "/user/passwordChange/view";
						} else {
							$("#passwordSearchFail").show();
						}
					}
					, error:function(){
						alert("비밀번호 찾기 오류");
					}
				});
			});
		});
	</script>
</body>
</html>