package com.ahn.tripplan.schedule.todolist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.schedule.todolist.model.ToDoList;

@Repository
public interface ToDoListDAO {

	public int insertList(
			@Param("userId") int userId
			, @Param("nickname") String nickname
			, @Param("scheduleId") int scheduleId
			, @Param("listContent") String listContent);
	
	public List<ToDoList> selectList(@Param("scheduleId") int scheduleId);
}
