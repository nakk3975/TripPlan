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
					<h3>회원가입</h3>
					<div class="input-group">
					  	<input type="text" class="form-control" placeholder="아이디" id="idInput">
					  	<button class="btn btn-primary" type="button" id="idCheckBtn">중복체크</button>
					</div>
					<span id="idDuplication" class="text-danger small" style="display:none">중복된 아이디 입니다.</span>
					<span id="idNotDuplication" class="text-success small" style="display:none">사용 가능한 아이디 입니다.</span>
					<input type="password" class="form-control mt-3" placeholder="비밀번호" id="passwordInput">
					<input type="password" class="form-control mt-3" placeholder="비밀번호 확인" id="passwordConfirmInput">
					<input type="text" class="form-control mt-3" placeholder="이름" id="nameInput">
					<input type="text" class="form-control mt-3" placeholder="닉네임" id="nicknameInput">
					<input type="text" class="form-control mt-3" placeholder="이메일" id="emailInput">
					<input type="text" class="form-control mt-3" placeholder="전화번호" id="phoneNumberInput">
					<button type="button" class="btn btn-block btn-primary mt-3" id="joinBtn">가입</button>
					
					<div class="d-flex justify-content-center mt-3">
						<h6><a href="/user/signin/view">로그인</a></h6>
					</div>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			
			var check = false;
			
			$("#idCheckBtn").on("click", function() {
				let id = $("#idInput").val();
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				
				$.ajax({
					type:"get"
					, url:"/user/signup/duplication"
					, data:{"loginId": id}
					, success:function(data) {
						if(data.result) {
							$("#idDuplication").show();
							$("#idNotDuplication").hide();
							check = false;
						} else {
							$("#idDuplication").hide();
							$("#idNotDuplication").show();
							check = true;
						}
					}
					, error:function(){
						alert("중복검사 에러");
					}
				});
			});
			
			$("#joinBtn").on("click", function() {
				let id = $("#idInput").val();
				let password = $("#passwordInput").val();
				let passwordConfirm = $("#passwordConfirmInput").val();
				let name = $("#nameInput").val();
				let nickname = $("#nicknameInput").val();
				let email = $("#emailInput").val();
				let phoneNumber = $("#phoneNumberInput").val();
				let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				
				
				if(password != passwordConfirm) {
					alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
					passwordConfirm.val("");
					passwordConfirm.focus();
					return;
				}
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				if(!valueCheck($("#passwordInput"), "패스워드")){
					return;
				}
				if(!valueCheck($("#passwordConfirmInput"), "패스워드확인")){
					return;
				}
				if(!valueCheck($("#nameInput"), "이름")){
					return;
				}
				if(!valueCheck($("#nicknameInput"), "닉네임")){
					return;
				}
				if(!valueCheck($("#emailInput"), "이메일")){
					return;
				}
				if(!valueCheck($("#phoneNumberInput"), "전화번호")){
					return;
				}
				
				if(!exptext.test(email)){
					alert("이메일 형식이 맞지 않습니다.");
					email.val("");
					email.focus();
					return;
				}
				
				if(!check){
					alert("아이디 중복체크를 해주세요");
					return;
				}
				
				$.ajax({
					type:"post"
					, url:"/user/signup"
					, data:{"loginId":id, "password":password, "name":name, "nickname":nickname, "email":email, "phoneNumber":phoneNumber}
					, success:function(data) {
						if(data.result == "success"){
							alert("가입이 완료되었습니다.");
							location.href="/user/signin/view";
						} else {
							alert("가입 실패");
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