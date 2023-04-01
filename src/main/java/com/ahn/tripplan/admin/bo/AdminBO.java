package com.ahn.tripplan.admin.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.bo.BoardBO;
import com.ahn.tripplan.board.model.BoardDetail;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class AdminBO {

	@Autowired
	private BoardBO boardBO;
	
	@Autowired
	private UserBO userBO;
	
	public List<BoardDetail> adminBoardList() {
		return boardBO.selectMainList();
	}
	
	public List<User> adminUserList() {
		return userBO.selectAllUserList();
	}
	
	public int updateUserLevel(int id) {
		return userBO.updateUserLevel(id);
	}
	
	public int deleteUser(int id) {
		return userBO.deleteUser(id);
	}
	
	
}
