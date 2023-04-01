package com.ahn.tripplan.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.admin.bo.AdminBO;

@RestController
@RequestMapping("/admin")
public class AdminRestController {

	@Autowired
	private AdminBO adminBO;
	
	@PostMapping("/level")
	public Map<String, String> levelChange(@RequestParam("id") int id) {
		
		int count = adminBO.updateUserLevel(id);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/delete")
	public Map<String, String> deleteUser(@RequestParam("id") int id) {
		
		int count = adminBO.deleteUser(id);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
