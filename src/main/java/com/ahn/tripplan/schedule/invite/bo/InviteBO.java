package com.ahn.tripplan.schedule.invite.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.schedule.invite.dao.InviteDAO;
import com.ahn.tripplan.schedule.invite.model.InviteMember;
import com.ahn.tripplan.schedule.invite.model.ScheduleMember;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class InviteBO {

	@Autowired
	private InviteDAO inviteDAO;
	@Autowired
	private UserBO userBO;
	
	// 초대중으로 이동
	public int insertInviteMember(int scheduleId, int userId) {
		return inviteDAO.insertInviteSchedule(scheduleId, userId);
	}
	
	// 자신이 초대받은 일정
	public List<InviteMember> selectInviteScheduleList(int userId) {
		return inviteDAO.selectInviteList(userId);
	}
	
	// 초대받은 일정 거절
	public int deleteInvite(int scheduleId, int userId) {
		return inviteDAO.deleteInviteRefuse(scheduleId, userId);
	}
	
	// 초대받은 일정 수락
	public int insertInviteSchedule(int scheduleId, int userId) {
		return inviteDAO.insertScheduleMember(scheduleId, userId);
	}
	
	// 초대할 멤버 검색
	public User selectInviteMember(String nickname) {
		return userBO.selectInviteUser(nickname);
	}
	
	// 초대받은 일정 멤버 목록
	public List<ScheduleMember> selectScheduleMember(int scheduleId) {
		return inviteDAO.selectMember(scheduleId);
	}
	
	// 멤버 권한 수정
	public int updateAuthority(int role) {
		if(role == 0) {
			return inviteDAO.updateAuthorityUp(role);
		} else {
			return inviteDAO.updateAuthorityDown(role);
		}
	}
	
	// 초대가 완료된 리스트
	public List<ScheduleMember> selectInviteSchedule(int userId) {
		return inviteDAO.selectInviteSchedule(userId);
	}
	
	// 초대 된 일정 나가기
	public int deleteInviteSchedule(int id) {
		return inviteDAO.deleteInviteSchedule(id);
	}
}
