package com.motuma.professionalnetwork.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.motuma.professionalnetwork.models.Comment;
import com.motuma.professionalnetwork.repositories.CommentRepository;

@Service
public class CommentService {
private CommentRepository commentRepository;
	
	public CommentService(CommentRepository messageRepository) {
		this.commentRepository = messageRepository;
	}
	
	public List<Comment> allComments(){
		return commentRepository.findAll();
	}
	
	
	public void create(Comment comment) {
		commentRepository.save(comment);
	}

	public Comment getComment(long id) {
		return (Comment) commentRepository.findOne(id);
	}
	public void update(Comment comment) {
		commentRepository.save(comment);
	}
	public void destroy(long id) {
		commentRepository.delete(id);
	}
}
