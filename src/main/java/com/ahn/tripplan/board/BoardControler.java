package com.ahn.tripplan.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ahn.tripplan.board.bo.BoardBO;
import com.ahn.tripplan.board.model.BoardDetail;
import com.ahn.tripplan.schedule.model.ScheduleDetail;

@Controller
@RequestMapping("/board")
public class BoardControler {
	
	@Autowired
	private BoardBO boardBO;
	
	@GetMapping("/main/view")
	public String boardList(Model model) {
		
		List<BoardDetail> board = boardBO.selectMainList();
		
		model.addAttribute("boards", board);
		
		return "board/boardlist";
	}
	
	@GetMapping("/create/view")
	public String boardCreate(
			@RequestParam("scheduleId") int scheduleId
			, Model model) {
		
		ScheduleDetail detail = boardBO.getScheduleData(scheduleId);
		
		model.addAttribute("schedule", detail);
		
		return "board/share";
	}
	
	@GetMapping("/detail/view")
	public String boardDetail(
			@RequestParam("id") int id
			, Model model
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		BoardDetail boardDetail = boardBO.selectDetail(userId, id);
		
		model.addAttribute("selectBoard", boardDetail);
		
		return "board/detail";
	}
	
}
