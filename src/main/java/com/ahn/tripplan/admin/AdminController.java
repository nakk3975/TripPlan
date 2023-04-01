package com.ahn.tripplan.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ahn.tripplan.admin.bo.AdminBO;
import com.ahn.tripplan.board.model.BoardDetail;
import com.ahn.tripplan.user.model.User;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminBO adminBO;
	
	@GetMapping("/main/view")
	public String adminMain() {
		return "admin/main";
	}
	
	@GetMapping("/user/view")
	public String userListView(Model model) {
		List<User> user = adminBO.adminUserList();
		
		model.addAttribute("users", user);
		
		return "admin/userlist";
	}
	
	@GetMapping("/board/view")
	public String boardListView(Model model) {
		
		List<BoardDetail> board = adminBO.adminBoardList();
		
		model.addAttribute("boards", board);
		
		return "admin/boardlist";
	}
}
