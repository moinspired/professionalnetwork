package com.motuma.professionalnetwork.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.motuma.professionalnetwork.models.Comment;
import com.motuma.professionalnetwork.models.Message;

@Repository
public interface CommentRepository  extends CrudRepository<Comment, Long>{
	List<Comment> findAll();
}
