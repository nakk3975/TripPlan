package com.ahn.tripplan.schedule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@GetMapping("/view")
	public String scheduleView() {
		return "schedule/schedule";
	}
	
	@GetMapping("/input/view")
	public String scheduleInputView() {
		return "schedule/input";
	}
	
	
}
