package com.ahn.tripplan.board.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.comment.bo.CommentBO;
import com.ahn.tripplan.board.comment.model.CommentDetail;
import com.ahn.tripplan.board.dao.BoardDAO;
import com.ahn.tripplan.board.like.bo.LikeBO;
import com.ahn.tripplan.board.model.Board;
import com.ahn.tripplan.board.model.BoardDetail;
import com.ahn.tripplan.board.tag.bo.TagBO;
import com.ahn.tripplan.board.tag.model.Tag;
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
	@Autowired
	private CommentBO commentBO;
	@Autowired
	private LikeBO likeBO;
	@Autowired
	private TagBO tagBO;
	
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
	
	public BoardDetail selectDetail(int userId, int id) {
		
		Board board = boardDAO.selectBoardDetail(id);
		User user = userBO.getUserById(board.getUserId());
		BoardDetail detail = new BoardDetail();
		List<CommentDetail> commentDeatil = commentBO.selectComment(id);
		int likeCount = likeBO.selectCountLike(board.getId());
		boolean isLike = likeBO.isLike(userId, board.getId());
		Tag tag = tagBO.selectTag(board.getId());
		
		detail.setId(board.getId());
		detail.setUserId(board.getUserId());
		detail.setScheduleId(board.getScheduleId());
		detail.setNickname(user.getNickname());
		detail.setTitle(board.getTitle());
		detail.setBoardContent(board.getBoardContent());
		detail.setHit(board.getHit());
		detail.setComment(commentDeatil);
		detail.setLike(isLike);
		detail.setLikeCount(likeCount);
		detail.setTag(tag.getTag());
		detail.setCreatedAt(board.getCreatedAt());
		detail.setUpdatedAt(board.getUpdatedAt());
		
		return detail;
	}
	
	public int updateHit(int boardId) {
		return boardDAO.updateHitScore(boardId);
	}
	
	public int deleteBoard(int id) {
		return boardDAO.deleteBoard(id);
	}
	
	public int selectBoardId(int userId) {
		return boardDAO.selectboardIdLimit(userId);
	}
}
