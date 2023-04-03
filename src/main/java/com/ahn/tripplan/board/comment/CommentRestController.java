package com.ahn.tripplan.board.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.board.comment.bo.CommentBO;

@RestController
@RequestMapping("/board/comment")
public class CommentRestController {
	
	@Autowired
	private CommentBO commentBO;
	
	@PostMapping("/create")
	public Map<String, String> createComment(
			@RequestParam("boardId") int boardId
			, @RequestParam("commentContent") String commentContent
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		int count = commentBO.addComment(userId, boardId, commentContent);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	@GetMapping("/delete")
	public Map<String, String> deleteComment(
			@RequestParam("id") int id
			, HttpSession session) {
		
		int userId = (int) session.getAttribute("userId");
		int count = commentBO.deleteComment(id, userId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
}
