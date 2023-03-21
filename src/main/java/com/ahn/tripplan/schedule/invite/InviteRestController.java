package com.ahn.tripplan.schedule.invite;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.schedule.invite.bo.InviteBO;
import com.ahn.tripplan.user.model.User;

@RequestMapping("/schedule/invite")
@RestController
public class InviteRestController {

	@Autowired
	private InviteBO inviteBO;
	
	@PostMapping("/invite")
	public Map<String, String> scheduleInvite(
			@RequestParam("scheduleId") int scheduleId
			, @RequestParam("userId") int userId) {
		
		int count = inviteBO.insertInviteMember(scheduleId, userId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/delete")
	public Map<String, String> inviteRefuse(
			@RequestParam("scheduleId") int scheduleId
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		
		int count = inviteBO.deleteInvite(scheduleId, userId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/accept")
	public Map<String, String> inviteAccept(
			@RequestParam("scheduleId") int scheduleId
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		
		int count = inviteBO.insertInviteSchedule(scheduleId, userId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/search")
	public Map<String, String> inviteMemberSearch(
			@RequestParam("nickname") String nickname) {
		
		User user = inviteBO.selectInviteMember(nickname);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			result.put("result", "success");
			result.put("nickname", user.getNickname());
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
