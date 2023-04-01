package com.ahn.tripplan.board.tag.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.tag.dao.TagDAO;
import com.ahn.tripplan.board.tag.model.Tag;

@Service
public class TagBO {

	@Autowired
	private TagDAO tagDAO;
	
	public int addTag(int boardId, String tag) {	
		return tagDAO.insertTag(boardId, tag);		
	}
	
	public Tag selectTag(int boardId) {
		return tagDAO.selectTag(boardId);
	}
	
	public int deleteTag(int boardId) {
		return tagDAO.deleteTag(boardId);
	}
	
	public List<Tag> searchTag(String text) {
		return tagDAO.selectSearchTag(text);
	}
	
}
