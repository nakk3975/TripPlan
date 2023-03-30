package com.ahn.tripplan.destination;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/destination")
public class DestinationController {
	
	@GetMapping("/main/view")
	public String main() {
		return "destination/main";
	}
	
	@GetMapping("/detail/view")
	public String detail () {
		return "destination/detail";
	}
	
	@GetMapping("/search/view")
	public String search() {
		return "destination/search";
	}
	
	@GetMapping("/map/view")
	public String mapView() {
		return "destination/map";
	}
	
}
