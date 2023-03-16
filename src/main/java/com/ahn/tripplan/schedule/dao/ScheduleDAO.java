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
	
	public Schedule selectScheduleById(@Param("scheduleId") int scheduleId);
	
	public int deleteSchedule(
			@Param("scheduleId") int scheduleId
			, @Param("userId") int userId);
	
	public int deleteScheduleData(@Param("scheduleId") int scheduleId);
	
	public int updateSchedule(
			@Param("scheduleId") int scheduleId
			, @Param("title") String title);
	
	public int updateScheduleData(
			@Param("scheduleId") int scheduleId
			, @Param("content") String content
			, @Param("startTime") String startTime
			, @Param("endTime") String endTime
			, @Param("move") String move
			, @Param("cost") int cost);
	
}
