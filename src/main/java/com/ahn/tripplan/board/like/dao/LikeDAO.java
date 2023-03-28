package com.ahn.tripplan.board.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {

	public int insertLike(
			@Param("userId") int userId
			, @Param("boardId") int boardId);
	
	public int selectCountLike(@Param("boardId") int boardId);
	
	public int deleteLike(
			@Param("userId") int userId
			, @Param("boardId") int boardId);
	
	public int selectLikeById(
			@Param("userId") int userId
			, @Param("boardId") int boardId);
	
	public int deleteLikeByBoardId(@Param("boardId") int boardId);
	
}
