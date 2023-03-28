package com.ahn.tripplan.board.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.like.dao.LikeDAO;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;
	
	public int insertLike(int userId, int boardId) {
		return likeDAO.insertLike(userId ,boardId);
	}
	
	public int selectCountLike(int boardId) {
		return likeDAO.selectCountLike(boardId);
	}
	
	public int deleteLike(int userId, int boardId) {
		return likeDAO.deleteLike(userId, boardId);
	}
	
	public boolean isLike(int userId, int boardId) {
		int count = likeDAO.selectLikeById(userId, boardId);
		if(count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public int deleteLikeByPost(int boardId) {	
		return likeDAO.deleteLikeByBoardId(boardId);

	}
	
}
