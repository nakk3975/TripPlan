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
					<h3>로그인</h3>
					<form id="loginForm">
						<input type="text" class="form-control" placeholder="아이디" id="idInput">
						<input type="password" class="form-control mt-3" placeholder="비밀번호" id="passwordInput">
						<button type="submit" class="btn btn-primary btn-block mt-3" id="loginBtn">로그인</button>
					</form>
					<br>
					<div class="text-center">
						<span id="loginFail" class="text-danger small" style="display:none">id 또는 비밀번호가 잘못 되었습니다.</span>
					</div>
					<br>
					<a href="/user/signup/view">회원가입</a>
					<br>
					<a href="#" class="mt-3">아이디 / 비밀번호 찾기</a>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script src="/static/js/form.js"></script>
	<script>	
		$(document).ready(function() {
			
			$("#loginForm").on("submit",function() {
				
				let id = $("#idInput").val();
				let password = $("#passwordInput").val();
				
				if(!valueCheck($("#idInput"), "아이디")){
					e.preventDefault();
					return;
				}
				
				if(!valueCheck($("#passwordInput"), "비밀번호")){
					e.preventDefault();
					return;
				}
				
				$.ajax({
					type: "post"
					, url: "/user/signin"
					, data: {"loginId":id, "password":password}
					, success:function(data) {
						if(data.result == "success"){
							location.href="#";
						} else {
							$("#loginFail").show();
						}
					}
					, error:function() {
						alert("로그인 에러");
					}
				});
				return false;
			});
		});
	</script>	
</body>
</html>