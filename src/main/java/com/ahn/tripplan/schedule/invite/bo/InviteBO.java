package com.ahn.tripplan.schedule.invite.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.invite.dao.InviteDAO;
import com.ahn.tripplan.schedule.invite.model.InviteMember;

@Service
public class InviteBO {

	@Autowired
	private InviteDAO inviteDAO;
	
	// 초대중으로 이동
	public int insertInviteMember(int scheduleId, int userId) {
		return inviteDAO.insertInviteSchedule(scheduleId, userId);
	}
	
	// 자신이 초대 받은 일정
	public List<InviteMember> selectInviteScheduleList(int userId) {
		return inviteDAO.selectInviteList(userId);
	}
	
	// 초대 받은 일정 거절
	public int deleteInvite(int scheduleId, int userId) {
		return inviteDAO.deleteInviteRefuse(scheduleId, userId);
	}
	
	// 초대 받은 일정 수락
	public int insertInviteSchedule(int scheduleId, int userId) {
		return inviteDAO.insertScheduleMember(scheduleId, userId);
	}
}
