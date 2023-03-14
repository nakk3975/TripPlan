package com.ahn.tripplan.user.dao;

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
}
