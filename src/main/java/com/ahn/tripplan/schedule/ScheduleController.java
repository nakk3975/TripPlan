package com.ahn.tripplan.schedule;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ahn.tripplan.schedule.bo.ScheduleBO;
import com.ahn.tripplan.schedule.model.ScheduleDetail;
import com.ahn.tripplan.schedule.model.ScheduleInviteDetail;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private ScheduleBO scheduleBO;
	@Autowired
	private UserBO userBO;
	
	
	@GetMapping("/view")
	public String scheduleView() {
		return "schedule/schedule";
	}
	
	@GetMapping("/detail/view")
	public String scheduleDetail(
			@RequestParam("scheduleId") int scheduleId
			, HttpSession session
			, Model model) {
		
		int userId = (int)session.getAttribute("userId");
		
		ScheduleDetail scheduleDetail = scheduleBO.ScheduleDetail(scheduleId);
		List<User> user = userBO.selectUserList(userId);
		
		model.addAttribute("schedule", scheduleDetail);
		model.addAttribute("users", user);
		
		return "schedule/scheduledetail";
	}
	
	@GetMapping("/invite/view")
	public String scheduleInviteSearchMember(
			HttpSession session
			, Model model) {
		
		int userId = (int)session.getAttribute("userId");
		List<ScheduleInviteDetail> detail = scheduleBO.inviteDetail(userId);
		
		model.addAttribute("invites", detail);
		
		return "schedule/scheduleinvite";
	}
}
