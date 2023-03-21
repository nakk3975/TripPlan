package com.ahn.tripplan.schedule.todolist;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.schedule.todolist.bo.ToDoListBO;

@RequestMapping("/todo")
@RestController
public class ToDoListRestController {

	@Autowired
	private ToDoListBO toDoListBO;
	
	@PostMapping("/create")
	public Map<String, String> createComment(
			@RequestParam("scheduleId") int scheduleId
			, @RequestParam("listContent") String listContent
			, HttpSession session) {
		
		int userId = (Integer)session.getAttribute("userId");
		String nickname = (String)session.getAttribute("userLoginId");
		
		int count = toDoListBO.insertToDoList(userId, nickname, scheduleId, listContent);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
