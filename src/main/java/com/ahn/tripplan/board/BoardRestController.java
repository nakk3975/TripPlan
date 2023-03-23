package com.ahn.tripplan.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.board.bo.BoardBO;

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
}
