package com.ahn.tripplan.destination;

import java.io.IOException;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.destination.bo.DestinationBO;

@RestController
@RequestMapping("/destination")
public class DestinationRestController {

	@Autowired
	private DestinationBO destinationBO;
	
	@GetMapping("/main")
    public String callApi() throws IOException, URISyntaxException{
        return destinationBO.SelectImageApi();
    }
	
	@GetMapping("/detail")
	public String detailDestination(@RequestParam("contentId") String contentId) throws IOException, URISyntaxException {
		return destinationBO.SelectDetailApi(contentId);
	}
	
	@GetMapping("/map")
	public String destinationMap() throws IOException, URISyntaxException {
		return destinationBO.SelectMapApi();
	}
	
	@GetMapping("/areaList")
	public String areaList() throws IOException, URISyntaxException {
		return destinationBO.selectAreaList();
	}
	
	@GetMapping("/countryList")
	public String countryList(@RequestParam("areaCode") int areaCode) throws IOException, URISyntaxException {
		return destinationBO.selectCountyList(areaCode);
	}
	
	@GetMapping("/districtList")
	public String districtList(
			@RequestParam("areaCode") int areaCode
			, @RequestParam("sigunguCode") int sigunguCode) throws IOException, URISyntaxException {
		return destinationBO.selectDistrictList(areaCode, sigunguCode);
	}
	
	@GetMapping("/myLocation")
	public String myLocationList(
			@RequestParam("mapX") double mapX
			, @RequestParam("mapY") double mapY
			, @RequestParam("radius") int radius) throws IOException, URISyntaxException {
		return destinationBO.selectMyLocationList(mapX, mapY, radius);
	}
	
}
