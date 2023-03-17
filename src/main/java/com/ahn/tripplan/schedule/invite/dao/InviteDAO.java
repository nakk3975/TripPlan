package com.ahn.tripplan.schedule.invite.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.schedule.invite.model.InviteMember;

@Repository
public interface InviteDAO {

	public int insertInviteSchedule(
			@Param("scheduleId") int scheduleId
			,@Param("userId") int userId);
	
	public List<InviteMember> selectInviteList(@Param("userId") int userId);
	
	public int deleteInviteRefuse(
			@Param("scheduleId") int scheduleId
			, @Param("userId") int userId);
	
	public int insertScheduleMember(
			@Param("scheduleId") int scheduleId
			, @Param("userId") int userId);
}
