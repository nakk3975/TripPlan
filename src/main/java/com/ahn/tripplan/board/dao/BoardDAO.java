package com.ahn.tripplan.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ahn.tripplan.board.model.Board;

@Repository
public interface BoardDAO {
	
	public int createBoard(
			@Param("userId") int userId
			, @Param("scheduleId") int scheduleId
			, @Param("title") String title
			, @Param("boardContent") String boardContent);
	
	public List<Board> selectBoardList();
}
