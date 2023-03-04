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
	
}
