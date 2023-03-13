package com.ahn.tripplan.destination;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.ahn.tripplan.destination.model.DetailCommon;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

@Controller
@RequestMapping("/destination")
public class DestinationController {

	private final String SERVICE_KEY = "Uw6gaLxXT6Kse3SbXODEh3jf7z4UQQ5UWXm0qQflrhIHEXFvNGRRi%2BWrU1BQu8rhdkUYKwr7vvQnAfhhhSxkjw%3D%3D";
	
	@GetMapping("/main/view")
	public String main() {
		return "destination/main";
	}
	
	@GetMapping("/detail/view")
	public String detail (
			@RequestParam("contentid") String contentid
			, Model model) throws JsonMappingException, JsonProcessingException  {
		String url = "http://apis.data.go.kr/B551011/KorService1/detailCommon1?serviceKey=" + SERVICE_KEY 
				+ "&contentId=" + contentid + "defaultYN=Y&MobileOS=ETC&MobileApp=TripPlan&firstImageYN=Y"
						+ "&addrinfoYN=Y&overviewYN=Y&_type=json";
		RestTemplate restTemplate = new RestTemplate();
		DetailCommon response = restTemplate.getForObject(url, DetailCommon.class);
		
		model.addAttribute("data", response.getResponse().getBody().getItems().getItem());
		
		return "destination/detail";
	}
	
}
