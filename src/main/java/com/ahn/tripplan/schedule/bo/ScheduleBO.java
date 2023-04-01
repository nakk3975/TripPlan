package com.ahn.tripplan.schedule.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.dao.ScheduleDAO;
import com.ahn.tripplan.schedule.invite.bo.InviteBO;
import com.ahn.tripplan.schedule.invite.model.InviteMember;
import com.ahn.tripplan.schedule.invite.model.ScheduleMember;
import com.ahn.tripplan.schedule.model.Schedule;
import com.ahn.tripplan.schedule.model.ScheduleData;
import com.ahn.tripplan.schedule.model.ScheduleDetail;
import com.ahn.tripplan.schedule.model.ScheduleInviteDetail;
import com.ahn.tripplan.schedule.model.ScheduleMemberDetail;
import com.ahn.tripplan.schedule.todolist.bo.ToDoListBO;
import com.ahn.tripplan.schedule.todolist.model.ToDoList;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class ScheduleBO {

	@Autowired
	private ScheduleDAO scheduleDAO;
	@Autowired
	private UserBO userBO;
	@Autowired
	private InviteBO inviteBO;
	@Autowired
	private ToDoListBO toDoListBO;
	
	// 일정 제목 및 정보 저장
	public int insertScheduel(int userId, String title) {
		return scheduleDAO.insertSchedule(userId, title);
	}
	
	// 일정 내용 저장
	public int insertScheduleData(
			int scheduleId
			, String content
			, String startTime
			, String endTime
			, String move
			, int cost) {
		
		return scheduleDAO.insertScheduleData(scheduleId, content, startTime, endTime, move, cost);
	}
	
	// 현재 로그인 한 사용자의 일정 정보
	public int selectByUserScheduleId(int userId) {
		int scheduleId = scheduleDAO.selectScheduleByUserId(userId);
		return scheduleId;	
	}
	
	// 위에서 검색한 전체 일정
	public List<ScheduleDetail> selectSchedule(int userId) {
		List<Schedule> scheduleList = scheduleDAO.selectSchedule(userId);
		List<ScheduleDetail> detailList = new ArrayList<>();
		
		List<ScheduleMember> scheduleMember = inviteBO.selectInviteSchedule(userId);
			for(ScheduleMember member:scheduleMember) {
				List<Schedule> scheduleInviteList = scheduleDAO.selectInviteSchedule(member.getScheduleId());	
				for(Schedule schedule:scheduleInviteList) {
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
			}
		
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
	
	// 일정 상세 보기
	public ScheduleDetail ScheduleDetail(int scheduleId) {
		Schedule schedule = scheduleDAO.selectScheduleById(scheduleId);
		ScheduleData scheduleData = scheduleDAO.selectScheduleData(scheduleId);
		User user = userBO.getUserById(schedule.getUserId());
		ScheduleDetail detail = new ScheduleDetail();
		List<ToDoList> toDoList = toDoListBO.toDoSelect(scheduleId);
		
		detail.setUserId(user.getId());
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
		detail.setToDoListComment(toDoList);
		
		return detail;
	}
	
	// 일정 삭제
	public int ScheduleDelete(int scheduleId, int userId) {
		int result = scheduleDAO.deleteSchedule(scheduleId, userId);
		
		if(result == 1) {
			return scheduleDAO.deleteScheduleData(scheduleId);
		} else {
			return 0;
		}
	}
	
	// 일정 제목 수정
	public int updateScheduel(
			int scheduleId
			, String title) {
		return scheduleDAO.updateSchedule(scheduleId, title);
	}
	
	// 일정 내용 수정
	public int updateScheduleData(
			int id
			, String content
			, String startTime
			, String endTime
			, String move
			, int cost) {
		
		return scheduleDAO.updateScheduleData(id, content, startTime, endTime, move, cost);
	}
	
	// 초대 받은 일정 상세
	public List<ScheduleInviteDetail> inviteDetail(int userId) {
		List<InviteMember> inviteInfo = inviteBO.selectInviteScheduleList(userId);
		
		List<ScheduleInviteDetail> detailList = new ArrayList<>();
		
		for(InviteMember invite:inviteInfo) {
			ScheduleInviteDetail detail = new ScheduleInviteDetail();
			Schedule schedule = scheduleDAO.selectScheduleById(invite.getScheduleId());
			User user = userBO.getUserById(schedule.getUserId());
			
			detail.setId(invite.getId());
			detail.setScheduleId(invite.getScheduleId());
			detail.setUserId(invite.getUserId());
			// 초대 한 사람의 닉네임
			detail.setNickname(user.getNickname());
			// 초대 한 일정의 제목
			detail.setTitle(schedule.getTitle());
			
			detailList.add(detail);
		}
		
		return detailList;
	}
	
	// 초대 받은 멤버 리스트
	public List<ScheduleMemberDetail> inviteMember(int scheduleId) {
		List<ScheduleMember> memberList = inviteBO.selectScheduleMember(scheduleId);
		List<ScheduleMemberDetail> detailList = new ArrayList<>();
		
		for(ScheduleMember member:memberList) {
			ScheduleMemberDetail detail = new ScheduleMemberDetail();
			User user = userBO.getUserById(member.getUserId());
			
			detail.setNickname(user.getNickname());
			detail.setRole(member.getRole());
			detail.setUpdatedAt(member.getUpdatedAt());
			
			detailList.add(detail);
		}
		return detailList;
	}
	
	
	
	
}

