package com.motuma.professionalnetwork.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.motuma.professionalnetwork.models.Comment;
import com.motuma.professionalnetwork.models.Message;
import com.motuma.professionalnetwork.models.User;
import com.motuma.professionalnetwork.services.CommentService;
import com.motuma.professionalnetwork.services.MessageService;
import com.motuma.professionalnetwork.services.UserService;

@Controller
public class Comments {
	private UserService userService;
	private MessageService messageService;
	private CommentService commentService;
	public Comments(MessageService messageService, UserService userService, CommentService commentService) {
		this.userService = userService;
		this.messageService = messageService;
		this.commentService = commentService;
	}
	@RequestMapping("/comments/{id}")
	public String postMessage(@PathVariable Long id, @RequestParam(value="comment") String comment, Model model, Principal principal) {
		 String username = principal.getName();
	     User currentUser = userService.findByUsername(username);
	     
	    
	     
	     Comment newComment = new Comment();
	     newComment.setComment(comment);
	     newComment.setUser(currentUser);
	     
	     
	     Message currentMessage = messageService.getMessage(id);
	     newComment.setMessage(currentMessage);
	     commentService.update(newComment);
	     
	     
	     
	     
	    return "redirect:/";

	}
}
