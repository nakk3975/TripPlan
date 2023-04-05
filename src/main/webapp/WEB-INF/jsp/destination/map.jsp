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
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49c8561d6ade226603d1a6b19ae78fe0&libraries=services,clusterer,drawing"></script>
	<!-- local key : e3a6629e36b2cf4296fd30de2823875a -->
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">
	
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section>
			 <div id="map" style="width:1200px;height:800px;"></div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	<script>
		$(document).ready(function() {
			
			var map = "";
			
			if (navigator.geolocation) {
	            navigator.geolocation.getCurrentPosition(function (position) {
	                var latitude = position.coords.latitude; // 위도
	                var longitude = position.coords.longitude; // 경도

	                // 지도 생성
	                var container = document.getElementById('map');
	                var options = {
	                    center: new daum.maps.LatLng(latitude, longitude), // 현재 위치를 지도의 중심으로 설정
	                    level: 3
	                };
	                map = new daum.maps.Map(container, options);

	                // 마커 생성
	                var markerPosition = new daum.maps.LatLng(latitude, longitude);
	                var marker = new daum.maps.Marker({
	                    position: markerPosition
	                });
	                marker.setMap(map);
	            });
	        } else {
	            alert('위치 정보를 가져올 수 없습니다.');
	            var container = document.getElementById('map');
                var options = {
                    center: new daum.maps.LatLng(33.450701, 126.570667), // 현재 위치를 지도의 중심으로 설정
                    level: 3
                };
                map = new daum.maps.Map(container, options);
	        }
			
			// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
			var markers = [];
			
			// API에서 관광지 정보를 가져옵니다.
            $.ajax({
                type:"get"
                , url:"/destination/map"
                , dataType:"json"
                , success: function(data) {
                    // 관광지 정보를 받아온 후, 지도에 마커를 생성합니다.
                    var items = data.response.body.items.item;
                    for (var i = 0; i < items.length; i++) {
                        var item = items[i];
                        var tel = "";
                        if(item.tel == "") {
                        	tel = "없음";
                        } else {
                        	tel = item.tel;
                        }
                        
                        addMarker(new kakao.maps.LatLng(item.mapy, item.mapx), item.title, item.addr1, tel, item.contentid);
                    }	
				},
                error: function() {
                    alert("불러오기 에러");
                }
            });
			
         // 마커를 생성하고 지도위에 표시하는 함수입니다
            function addMarker(position, title, addr1, tel, contentId) {
                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    position: position
                });

                // 마커가 지도 위에 표시되도록 설정합니다
                marker.setMap(map);

                // 생성된 마커를 배열에 추가합니다
                markers.push(marker);

                var infowindow = new kakao.maps.InfoWindow({
                	content:
                		'<div style="width: 300px" class="text-center p-2">' + 
                        '<div class="font-weight-bold;">' + title + '</div>' +
                        '<div>주소 : ' + addr1 + '</div>' +
                        '<div>전화번호 : ' + tel + '</div>' +
                        '<div class="small text-secondary">클릭시 상세보기 페이지로 이동됩니다.</div>' +
                        '</div>'
                });
                
             	// 마커를 클릭했을 때 인포윈도우를 열고 해당 위치의 contentId 값을 추출하여 상세보기 페이지로 이동합니다
                kakao.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map, marker);
                    window.location.href = "/destination/detail/view?contentid=" + contentId;
                });
             
                // 마커에 마우스를 올렸을 때 인포윈도우를 열도록 합니다
                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));

                // 마커에 마우스를 내렸을 때 인포윈도우를 닫도록 합니다
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
            }

            // 마커 위에 표시하는걸
            function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }
            
        	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }
		 });
	</script>
</body>
</html>