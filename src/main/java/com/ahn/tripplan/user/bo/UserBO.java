package com.ahn.tripplan.user.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.common.EncryptUtils;
import com.ahn.tripplan.user.dao.UserDAO;
import com.ahn.tripplan.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	
	public int addUser(
			String loginId
			, String password
			, String name
			, String nickname
			, String email
			, String phoneNumber) {
		
		String encryptPassword = EncryptUtils.md5(password);
		return userDAO.insertUser(loginId, encryptPassword, name, nickname, email, phoneNumber);
	}
	
	public int selectLoginId(String loginId) {
		return userDAO.selectId(loginId);
	}
	
	public User selectLogin(String loginId, String password) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.selectLogin(loginId, encryptPassword);
	}
	
	public User passwordSearch(String loginId, String email) {
		return userDAO.selectPasswordSearch(loginId, email);
	}
	
	public int updatePassword(int id, String password) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.updatePassword(id, encryptPassword);
	}
	
	public User selectId(String name, String email, String phoneNumber) {
		return userDAO.selectIdByUser(name, email, phoneNumber);
	}
	
	public User getUserById(int id) {
		return userDAO.selectUserById(id);
	}
	
	public List<User> selectUserList(int userId) {
		return userDAO.selectUser(userId);
	}
	
	public User selectInviteUser(String nickname) {
		return userDAO.selectInviteMember(nickname);
	}
	
	public List<User> selectAllUserList() {
		return userDAO.selectUserList();
	}
	
	public int updateUserLevel(int userId) {
		if(userDAO.selectLevel(userId) == 1) {
			return userDAO.updateLevel(userId);
		} else {
			return userDAO.downgradeLevel(userId);
		}
	}
	
	public int deleteUser(int userId) {
		return userDAO.deleteUser(userId);
	}
}
