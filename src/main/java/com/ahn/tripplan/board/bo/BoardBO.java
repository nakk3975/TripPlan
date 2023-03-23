package com.ahn.tripplan.board.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.dao.BoardDAO;
import com.ahn.tripplan.board.model.Board;
import com.ahn.tripplan.board.model.BoardDetail;
import com.ahn.tripplan.schedule.bo.ScheduleBO;
import com.ahn.tripplan.schedule.model.ScheduleDetail;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class BoardBO {

	@Autowired
	private ScheduleBO scheduleBO;
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private UserBO userBO;
	
	public ScheduleDetail getScheduleData(int scheduleId) {
		ScheduleDetail scheduleDetail = scheduleBO.ScheduleDetail(scheduleId);
		
		return scheduleDetail;
	}
	
	public int insertCreateBoard(int userId, int scheduleId, String title, String boardContent) {
		return boardDAO.createBoard(userId, scheduleId, title, boardContent);
	}
	
	public List<BoardDetail> selectMainList() {
		List<Board> boardList = boardDAO.selectBoardList();
		List<BoardDetail> detailList = new ArrayList<>();
		
		for(Board board:boardList) {
			User user = userBO.getUserById(board.getUserId());
			BoardDetail detail = new BoardDetail();
			
			detail.setId(board.getId());
			detail.setUserId(board.getUserId());
			detail.setScheduleId(board.getScheduleId());
			detail.setNickname(user.getNickname());
			detail.setTitle(board.getTitle());
			detail.setBoardContent(board.getBoardContent());
			detail.setHit(board.getHit());
			detail.setCreatedAt(board.getCreatedAt());
			detail.setUpdatedAt(board.getUpdatedAt());
			
			detailList.add(detail);
		}
		
		return detailList;
		
	}
}
