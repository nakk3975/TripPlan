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
			 <article>
			 	<h2 class="text-center">추천 여행지</h2>
			 	<div id="destination-box" class="d-flex justify-content-between row text-center col-12">
				
              	</div>
              </article>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	<script>
	
		$(document).ready(function() {		
	
			$.ajax({
				type:"get"
				, url:"/destination/main"
				, dataType: "json"
				, success:function(data) {
					var items = data.response.body.items.item;
					for(let i = 0; i < items.length; i++) {
						let title = items[i].title;
						let image = items[i].firstimage;
						let contentId = items[i].contentid;
						if(image == null || image == ""){
							continue;
						}	
						let html = "<div class='destinations py-4'> <img class='destimation-img' width='250px' src='" + image + "' data-contentid=" + contentId + " /> <div class='destination-title' data-contentid=" + contentId + ">" + title + "</div> </div>";
						$("#destination-box").append(html);
					}
					// 이미지 클릭시 상세 정보 페이지로 이동
					$(".destimation-img").on("click", function() {
						let contentid = $(this).data("contentid"); 
						location.href = "/destination/detail/view?contentid=" + contentid;
					});
				}
				, error:function() {
					alert("API 오류");
				}
			});
			
		});
	</script>
</body>
</html>