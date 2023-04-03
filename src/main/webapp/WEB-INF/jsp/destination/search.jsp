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
			 <div class="d-flex justify-content-center">
			 	<table class="table table-hover text-center">
			 		<thead>
			 			<tr id="tableTitle">
			 				<th><h2>지역 선택</h2></th>
			 			</tr>
			 		</thead>
			 		<tbody id="areaList">
			 		
			 		</tbody>
			 	</table>
			 </div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script>
		$(document).ready(function() {
			
			$.ajax({
				type:"get"
				, url:"/destination/areaList"
				, dataType:"json"
				, success:function(data) {
					let items = data.response.body.items.item;
					for(let i = 0; i < items.length; i++) {
						let code = items[i].code;
						let name = items[i].name;
						let html = "<tr class='area-name' style='cursor:pointer' data-id='" + code + "'><td>" + name + "</td></tr>";
						$("#areaList").append(html);
					}
					let html = "<tr class='my-location' style='cursor:pointer'><td>내 주변</td></tr>"
					$("#areaList").append(html);
				}
				, error:function() {
					alert("지역 조회 에러");
				}
			});
			
			// 내 주변을 눌렀을 때
			$("#areaList").on("click", ".my-location", function() {
			    if (navigator.geolocation) { // 브라우저가 Geolocation API를 지원하는 경우
			        navigator.geolocation.getCurrentPosition(function(position) { // 사용자의 현재 위치 정보 가져오기
			            let lat = position.coords.latitude; // 위도
			            let lon = position.coords.longitude; // 경도
			            let radius = 3000; // 검색 반경 (2000m)
			
			            // Open API 요청
			            $.ajax({
			                type: "get"
			                , url: "/destination/myLocation"
			                , data:{"mapX":lon, "mapY":lat, "radius":radius}
			                , dataType: "json"
			                , success: function(data) {
			                    $("#areaList").html("");
			                    $("#tableTitle").html("");
			                    let items = data.response.body.items.item;
			                    for (let i = 0; i < items.length; i++) {
			                        let code = items[i].contentid;
			                        let name = items[i].title;
			                        let address = items[i].addr1;
			                        let html = "";
			                        let title = "";
			                        if(name == "") {
			                        	html = "<tr><td>주변에 관광지가 없습니다.</tr></td>"
			                        } else {
			                        	title = "<th colspan='2'><h2>내 주변 관광지 목록 (3km 이내)</h2></th><th></th>";
			                        	html = "<tr class='district-name' style='cursor:pointer' data-id='" + code + "'><td>" + name + "</td><td>" + address + "</td></tr>";
			                        }
			                        $("#tableTitle").html(title);
			                        $("#areaList").append(html);
			                    }
			                }
			                , error: function() {
			                    alert("주변 관광지 정보 조회 에러");
			                }
			            });
			        }, function(error) { // 위치 정보를 가져오지 못한 경우
			            alert("위치 정보를 가져올 수 없습니다.");
			        });
			    } else { // 브라우저가 Geolocation API를 지원하지 않는 경우
			        alert("현재 브라우저에서는 위치 정보를 가져올 수 없습니다.");
			    }
			});
			
			// 시를 눌렀을 때 군구 표시
			$("#areaList").on("click", ".area-name", function() {
				let areaCode = $(this).data("id");
				$.ajax({
					type:"get"
					, url:"/destination/countryList"
					, data:{"areaCode":areaCode}
					, dataType:"json"
					, success:function(data) {
						$("#areaList").html("");
						
						let items = data.response.body.items.item;
						for(let i = 0; i < items.length; i++) {
							let code = items[i].code;
							let name = items[i].name;
							let html = "<tr class='country-name' style='cursor:pointer' data-area='" + areaCode + "'data-id='" + code + "' data-name='" + name + "'><td>" + name + "</td></tr>";
							$("#areaList").append(html);
						}
					}
					,error:function() {
						alert("구 조회 에러");
					}
				});
			});
			
			// 군구 를 눌렀을때 그에 맞는 관광지 표시
			$("#areaList").on("click", ".country-name", function() {
				let countryCode = $(this).data("id");
				let countryName = $(this).data("name");
				let areaCode = $(this).data("area");
				$.ajax({
					type:"get"
					, url:"/destination/districtList"
					, data:{"areaCode":areaCode, "sigunguCode":countryCode}
					, dataType:"json"
					, success:function(data) {
						// 목록을 비워줍니다.
						$("#areaList").html("");
						$("#tableTitle").html("");
						let tableTitle = "<th colspan='2'><h2>" + countryName + " 관광지 목록</h2></th><th></th>"
						$("#tableTitle").append(tableTitle);
						
						let items = data.response.body.items.item;
						for(let i = 0; i < items.length; i++) {
							let code = items[i].contentid;
							let name = items[i].title;
							let address = items[i].addr1;
							
							let html = "<tr class='district-name' style='cursor:pointer' data-id='" + code + "'><td>" + name + "</td><td>" + address + "</td></tr>";
							$("#areaList").append(html);
						}
					}
					, error:function() {
						alert("구 목록 조회 에러");
					}
				});
			});
			
			// 관광지를 클릭했을 때 상세 페이지로 이동
			$("#areaList").on("click", ".district-name", function() {
				let contentId = $(this).data("id");
				location.href = "/destination/detail/view?contentid=" + contentId;
			});
		});
	</script>
</body>
</html>