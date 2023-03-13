package com.ahn.tripplan.schedule.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.dao.ScheduleDAO;

@Service
public class ScheduleBO {

	@Autowired
	private ScheduleDAO scheduleDAO;
	
	public int insertScheduel(
			int userId
			, String title) {
		return scheduleDAO.insertSchedule(userId, title);
	}
	
	public int insertScheduleData(
			int scheduleId
			, String content
			, String startTime
			, String endTime
			, String move
			, int cost) {
		return scheduleDAO.insertScheduleData(scheduleId, content, startTime, endTime, move, cost);
	}
	
	public int selectByUserScheduleId(int userId) {
		int scheduleId = scheduleDAO.selectScheduleByUserId(userId);
		return scheduleId;
		
	}
	
}

