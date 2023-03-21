package com.ahn.tripplan.schedule.todolist.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.todolist.dao.ToDoListDAO;

@Service
public class ToDoListBO {

	@Autowired
	private ToDoListDAO toDoListDAO;
	
	public int insertToDoList(int userId, String nickname, int scheduleId, String listContent) {
		return toDoListDAO.insertList(userId, nickname, scheduleId, listContent);
	}
}
