package com.ahn.tripplan.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.board.bo.BoardBO;
import com.ahn.tripplan.board.model.BoardDetail;

@RestController
@RequestMapping("/board")
public class BoardRestController {
	
	@Autowired
	private BoardBO boardBO;
	
	@PostMapping("/create")
	public Map<String, String> createBoard(
			HttpSession session
			, @RequestParam("scheduleId") int scheduleId
			, @RequestParam("title") String title
			, @RequestParam("boardContent") String boardContent) {
		
		int userId = (int) session.getAttribute("userId");
		
		int count = boardBO.insertCreateBoard(userId, scheduleId, title, boardContent);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/hit")
	public Map<String, String> updateHit(
			@RequestParam("boardId") int boardId){
		
		int count = boardBO.updateHit(boardId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/delete")
	public Map<String, String> deleteBoard(
			@RequestParam("id") int id
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		int count = boardBO.deleteBoard(id, userId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}

	@GetMapping("/search")
	public Map<String, Object> searchTitleList(
			@RequestParam("text") String text
			, @RequestParam("title") String title) {

		List<BoardDetail> board = boardBO.selectSearchList(text, title);
		
		Map<String, Object> result = new HashMap<>();
		 System.out.println(board);
		if(board != null) {
			result.put("result", "success");
			result.put("boards", board);

		} else {
			result.put("result", "fail");
		}
		return result;
	}
}
