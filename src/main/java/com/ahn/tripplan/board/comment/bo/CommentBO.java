package com.ahn.tripplan.board.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ahn.tripplan.board.comment.dao.CommentDAO;
import com.ahn.tripplan.board.comment.model.Comment;
import com.ahn.tripplan.board.comment.model.CommentDetail;
import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@Service
public class CommentBO {

	@Autowired
	private CommentDAO commentDAO;
	@Autowired
	private UserBO userBO;
	
	public int addComment(int userId, int boardId, String commentContent) {
		return commentDAO.insertComment(userId, boardId, commentContent);
	}
	
	public List<CommentDetail> selectComment(int boardId) {
		List<Comment> comments = commentDAO.selectCommentList(boardId);
		List<CommentDetail> detailList = new ArrayList<>();
		
		for(Comment comment:comments) {
			CommentDetail detail = new CommentDetail();
			
			User user = userBO.getUserById(comment.getUserId());
			
			detail.setId(comment.getId());
			detail.setBoardId(comment.getBoardId());
			detail.setUserId(comment.getUserId());
			detail.setNickname(user.getNickname());
			detail.setCommentContent(comment.getCommentContent());
			detail.setCreatedAt(comment.getCreatedAt());
			detail.setUpdatedAt(comment.getUpdatedAt());
			
			detailList.add(detail);
		}
		return detailList;
	}
}
