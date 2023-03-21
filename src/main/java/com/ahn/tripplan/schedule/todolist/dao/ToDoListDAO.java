package com.ahn.tripplan.schedule.todolist.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ToDoListDAO {

	public int insertList(
			@Param("userId") int userId
			, @Param("nickname") String nickname
			, @Param("scheduleId") int scheduleId
			, @Param("listContent") String listContent);
}
