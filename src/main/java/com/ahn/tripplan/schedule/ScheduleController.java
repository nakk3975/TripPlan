package com.ahn.tripplan.schedule;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@GetMapping("/view")
	public String scheduleView(Model model
			, HttpSession session) {
		
		int userId = (Integer)session.getAttribute("userId");
		
		
		return "schedule/schedule";
	}
	
	@GetMapping("/input/view")
	public String scheduleInputView() {
		return "schedule/input";
	}
	
	
}
