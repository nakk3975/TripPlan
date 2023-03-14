package com.ahn.tripplan.schedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.schedule.model.Schedule;
import com.ahn.tripplan.schedule.model.ScheduleData;

@Repository
public interface ScheduleDAO {
	
	public int insertSchedule(
			@Param("userId") int userId
			, @Param("title") String title);
	
	public int insertScheduleData(
			@Param("scheduleId") int scheduleId
			, @Param("content") String content
			, @Param("startTime") String startTime
			, @Param("endTime") String endTime
			, @Param("move") String move
			, @Param("cost") int cost);
	
	public int selectScheduleByUserId(@Param("userId") int userId);
	
	public List<Schedule> selectSchedule(@Param("userId") int userId);
	
	public ScheduleData selectScheduleData(@Param("scheduleId") int scheduleId);
}
