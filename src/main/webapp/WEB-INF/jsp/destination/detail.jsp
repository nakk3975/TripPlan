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
		<section>
			<div class="d-flex">
			 	<img id="image" src="" width="600">
			 	<div class="pl-2">
				 	<h2 id="title"></h2>
				 	<h5 id="address">주소 :</h5>
				 	<h5 id="tel">전화번호 : </h5>
				 	<h5 id="homepage">홈페이지 : </h5>
				 	<h5>개요</h5>
				 	<div id="explanation"></div>
				 	<a href="/destination/main/view">목록으로</a>
			 	</div>
		 	</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		function getParameterByName(name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		  	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		  	results = regex.exec(location.search);
		  	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}
		
		$(document).ready(function() {
			let contentId = getParameterByName("contentid");

			$.ajax({
				type:"get"
				, url:"/destination/detail"
				, data:{"contentId":contentId}
				, dataType: "json"
				, success:function(data) {
					var item = data.response.body.items.item[0];
					
					let title = item.title;
					let image = item.firstimage;
					let tel = item.tel;
					let address = item.addr1;
					let url = item.homepage;
					let outline = item.overview;
					
					$("#title").append(title);
					$("#image").attr("src",image);
					$("#address").append(" " + address);
					if(tel == ""){
						$("#tel").append(" " + "전화번호 없음");
					} else {
						$("#tel").append(" " + tel);
					}
					$("#homepage").append(" " + url);
					$("#explanation").append(outline);
				}
				, error:function() {
					alert("api 오류");
				}
			});
			
		});
	</script>
</body>
</html>