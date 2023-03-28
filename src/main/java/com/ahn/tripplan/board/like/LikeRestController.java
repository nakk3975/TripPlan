package com.ahn.tripplan.board.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.board.like.bo.LikeBO;


@RestController
@RequestMapping("/board")
public class LikeRestController {

	@Autowired
	private LikeBO likeBO;
	
	@GetMapping("/like")
	public Map<String, String> inputLike(
			@RequestParam("boardId") int boardId
			, HttpSession session) {
		
		int userId = (Integer)session.getAttribute("userId");
		
		int count = likeBO.insertLike(userId, boardId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/unlike")
	public Map<String,String> inputUnlike(
			@RequestParam("boardId") int boardId
			, HttpSession session){
		
		int userId = (Integer)session.getAttribute("userId");
		int count = likeBO.deleteLike(userId, boardId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
