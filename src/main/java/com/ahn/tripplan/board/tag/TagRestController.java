package com.ahn.tripplan.board.tag;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.board.bo.BoardBO;
import com.ahn.tripplan.board.tag.bo.TagBO;

@RestController
@RequestMapping("/board/tag")
public class TagRestController {

	@Autowired
	private BoardBO boardBO;
	@Autowired
	private TagBO tagBO;
	
	@PostMapping("/create")
	public Map<String, String> createTag(
			@RequestParam("tag") String tag
			, HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		int boardId = boardBO.selectBoardId(userId);
		
		int count = tagBO.addTag(boardId, tag);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	@GetMapping("/delete")
	public Map<String, String> deleteTag(
			@RequestParam("boardId") int boardId) {
		
		int count = tagBO.deleteTag(boardId);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
}
