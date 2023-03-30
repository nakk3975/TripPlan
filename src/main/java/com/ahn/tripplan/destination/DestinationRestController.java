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
		String result = destinationBO.SelectImageApi();
        return result;
    }
	
	@GetMapping("/detail")
	public String detailDestination(@RequestParam("contentId") String contentId) throws IOException, URISyntaxException {
		String result = destinationBO.SelectDetailApi(contentId);
		return result;
	}
	
	@GetMapping("/map")
	public String destinationMap() throws IOException, URISyntaxException {
		String result = destinationBO.SelectMapApi();
		return result;
	}
	
}
