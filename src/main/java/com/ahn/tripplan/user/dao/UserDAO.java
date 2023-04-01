package com.ahn.tripplan.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.user.model.User;

@Repository
public interface UserDAO {

	public int insertUser(
			@Param("loginId") String loginId
			, @Param("password") String password
			, @Param("name") String name
			, @Param("nickname") String nickname
			, @Param("email") String email
			, @Param("phoneNumber") String phoneNumber);
	
	public int selectId(@Param("loginId") String loginId);
	
	public User selectLogin(
			@Param("loginId") String loginId
			, @Param("password") String password);
	
	public User selectPasswordSearch(
			@Param("loginId") String loginId
			, @Param("email") String email);
	
	public int updatePassword(
			@Param("id") int id
			, @Param("password") String password);
	
	public User selectIdByUser(
			@Param("name") String name
			, @Param("email") String email
			, @Param("phoneNumber") String phoneNumber);
	
	public User selectUserById(@Param("id") int id);
	
	public List<User> selectUser(@Param("userId") int userId);
	
	public User selectInviteMember(@Param("nickname") String nickname);
	
	public List<User> selectUserList();
	
	public int updateLevel(@Param("id") int id);
	
	public int downgradeLevel(@Param("id") int id);
	
	public int selectLevel(@Param("id") int id);
	
	public int deleteUser(@Param("id") int id);
}
