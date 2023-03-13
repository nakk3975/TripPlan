package com.ahn.tripplan.schedule.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

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
}
