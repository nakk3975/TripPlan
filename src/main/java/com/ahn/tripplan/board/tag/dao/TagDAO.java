package com.ahn.tripplan.board.tag.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.board.tag.model.Tag;

@Repository
public interface TagDAO {
	
	public int insertTag(
			@Param("boardId") int boardId
			, @Param("tag") String tag);
	
	public Tag selectTag(@Param("boardId") int boardId);
	
	public int deleteTag(@Param("boardId") int boardId);
}
