package com.ahn.tripplan.destination.bo;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class DestinationBO {

	private final String apiUrl = "http://apis.data.go.kr/B551011/KorService1";
	private final String key = "Uw6gaLxXT6Kse3SbXODEh3jf7z4UQQ5UWXm0qQflrhIHEXFvNGRRi+WrU1BQu8rhdkUYKwr7vvQnAfhhhSxkjw==";
	private final String mobileOS = "ETC";
	private final String mobileApp = "TripPlan";
	private final String dataType = "json";
	
	StringBuilder urlBuilder = new StringBuilder(apiUrl);
	
	// 메인화면 이미지
	public String SelectImageApi()  throws IOException, URISyntaxException {
		
		String apiList = "/areaBasedList1";
		int numOfRows = 10;
		int pageNo = 1;
		int contentTypeId = 12;
		
		String serviceKey = URLEncoder.encode(key,"UTF-8");
		
		String requestUrl = apiUrl + apiList + "?serviceKey=" + serviceKey + "&MobileOS=" + mobileOS + "&MobileApp=" + mobileApp + "&_type=" + dataType
				+ "&numOfRows=" + numOfRows
				+ "&pageNo=" + pageNo
				+ "&contentTypeId=" + contentTypeId; 
		
		URI uri = new URI(requestUrl);
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		
		String response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class).getBody();
		
		return response;
		
	}
	
	// 상세 화면
	public String SelectDetailApi(String contentId)  throws IOException, URISyntaxException {
		
		String apiList = "/detailCommon1";
		
		String serviceKey = URLEncoder.encode(key,"UTF-8");
		
		String requestUrl = apiUrl + apiList + "?serviceKey=" + serviceKey + "&MobileOS=" + mobileOS + "&MobileApp=" + mobileApp + "&_type=" + dataType
				+ "&contentId=" + contentId
				+ "&defaultYN=Y&firstImageYN=Y&addrinfoYN=Y&&overviewYN=Y";
		
		URI uri = new URI(requestUrl);
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		
		String response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class).getBody();
		
		return response;
	}
	
	// 지도에 마커 추가
	public String SelectMapApi()  throws IOException, URISyntaxException {
		
		String apiList = "/detailCommon1";
		
		String serviceKey = URLEncoder.encode(key,"UTF-8");
		
		String requestUrl = apiUrl + apiList + "?serviceKey=" + serviceKey + "&MobileOS=" + mobileOS + "&MobileApp=" + mobileApp + "&_type=" + dataType
				+ "defaultYN=Y&contentTypeId=12&addrinfoYN=Y&mapinfoYN=Y";
		
		URI uri = new URI(requestUrl);
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		
		String response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class).getBody();
		
		return response;
		
	}

}
