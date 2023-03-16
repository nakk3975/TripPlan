package com.ahn.tripplan.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ahn.tripplan.schedule.bo.ScheduleBO;
import com.ahn.tripplan.schedule.model.ScheduleDetail;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private ScheduleBO scheduleBO;
	
	@GetMapping("/view")
	public String scheduleView() {
		return "schedule/schedule";
	}
	
	@GetMapping("/detail/view")
	public String scheduleDetail(
			@RequestParam("scheduleId") int scheduleId
			, Model model) {
		
		ScheduleDetail scheduleDetail = scheduleBO.ScheduleDetail(scheduleId);
		
		model.addAttribute("schedule", scheduleDetail);
		
		return "schedule/scheduledetail";
	}
	
}
