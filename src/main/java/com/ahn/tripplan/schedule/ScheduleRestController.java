package com.ahn.tripplan.schedule;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.schedule.bo.ScheduleBO;
import com.ahn.tripplan.schedule.model.ScheduleDetail;

@RestController
@RequestMapping("/schedule")
public class ScheduleRestController {

	@Autowired
	private ScheduleBO scheduleBO;
	
	@PostMapping("/inputTitle")
	public Map<String, String> scheduleInputTitle(
		@RequestParam("title") String title
		, HttpSession session){
		
		int userId = (int)session.getAttribute("userId");
		int count = scheduleBO.insertScheduel(userId, title);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/input")
	public Map<String, String> scheduleInput(
			@RequestParam("content") String content
			, @RequestParam("startTime") Date startTime
			, @RequestParam("endTime") Date endTime
			, @RequestParam("move") String move
			, @RequestParam("cost") int cost
			, HttpSession session) {
		
		int userId = (int)session.getAttribute("userId");
		int scheduleId = scheduleBO.selectByUserScheduleId(userId);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String startDateTime = dateFormat.format(startTime);
		String endDateTime = dateFormat.format(endTime);
		System.out.println(scheduleId);
		int count = scheduleBO.insertScheduleData(scheduleId, content, startDateTime, endDateTime, move, cost);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/list")
	public List<ScheduleDetail> ScheduleList(HttpSession session) {
		int userId = (Integer)session.getAttribute("userId");
		
		List<ScheduleDetail> detail = scheduleBO.selectSchedule(userId);
		
		return detail;
	}
	
}
