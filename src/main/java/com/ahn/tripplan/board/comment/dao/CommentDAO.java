package com.ahn.tripplan.board.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.board.comment.model.Comment;

@Repository
public interface CommentDAO {

	public int insertComment(
			@Param("userId") int userId
			, @Param("boardId") int boardId
			, @Param("commentContent") String commentContent);
	
	public List<Comment> selectCommentList(int boardId);
}
