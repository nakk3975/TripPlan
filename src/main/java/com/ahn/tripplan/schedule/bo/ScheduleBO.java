package com.ahn.tripplan.schedule.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.dao.ScheduleDAO;
import com.ahn.tripplan.schedule.model.Schedule;
import com.ahn.tripplan.schedule.model.ScheduleData;
import com.ahn.tripplan.schedule.model.ScheduleDetail;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class ScheduleBO {

	@Autowired
	private ScheduleDAO scheduleDAO;
	@Autowired
	private UserBO userBO;
	
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
	
	public List<ScheduleDetail> selectSchedule(int userId) {
		List<Schedule> scheduleList = scheduleDAO.selectSchedule(userId);
		
		List<ScheduleDetail> detailList = new ArrayList<>();
		
		for(Schedule schedule:scheduleList) {
			ScheduleData scheduleData = scheduleDAO.selectScheduleData(schedule.getId());
			ScheduleDetail detail = new ScheduleDetail();
			User user = userBO.getUserById(schedule.getUserId());
			if(schedule.getId() == scheduleData.getScheduleId()) {
				detail.setId(schedule.getId());
				detail.setScheduleId(scheduleData.getId());
				detail.setUserId(user.getId());
				detail.setTitle(schedule.getTitle());
				detail.setContent(scheduleData.getContent());
				detail.setStartTime(scheduleData.getStartTime());
				detail.setEndTime(scheduleData.getEndTime());
				detail.setMove(scheduleData.getMove());
				detail.setCost(scheduleData.getCost());
				detail.setCreatedAt(scheduleData.getCreatedAt());
				
				detailList.add(detail);
			}
		}
		return detailList;
		
	}
	
	public ScheduleDetail ScheduleDetail(int scheduleId) {
		Schedule schedule = scheduleDAO.selectScheduleById(scheduleId);
		ScheduleData scheduleData = scheduleDAO.selectScheduleData(scheduleId);
		
		ScheduleDetail detail = new ScheduleDetail();
		
		detail.setId(schedule.getId());
		detail.setScheduleId(scheduleData.getId());
		detail.setTitle(schedule.getTitle());
		detail.setContent(scheduleData.getContent());
		detail.setStartTime(scheduleData.getStartTime());
		detail.setEndTime(scheduleData.getEndTime());
		detail.setMove(scheduleData.getMove());
		detail.setCost(scheduleData.getCost());
		detail.setCreatedAt(scheduleData.getCreatedAt());
		detail.setUpdatedAt(scheduleData.getUpdatedAt());
		
		return detail;
	}
	
	public int ScheduleDelete(int scheduleId, int userId) {
		int result = scheduleDAO.deleteSchedule(scheduleId, userId);
		
		if(result == 1) {
			return scheduleDAO.deleteScheduleData(scheduleId);
		} else {
			return 0;
		}
	}
	
	public int updateScheduel(
			int scheduleId
			, String title) {
		return scheduleDAO.updateSchedule(scheduleId, title);
	}
	
	public int updateScheduleData(
			int id
			, String content
			, String startTime
			, String endTime
			, String move
			, int cost) {
		
		return scheduleDAO.updateScheduleData(id, content, startTime, endTime, move, cost);
	}
	
}

