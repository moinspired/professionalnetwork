package com.motuma.professionalnetwork.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.motuma.professionalnetwork.models.Message;
import com.motuma.professionalnetwork.models.User;
import com.motuma.professionalnetwork.services.MessageService;
import com.motuma.professionalnetwork.services.UserService;

@Controller
public class Messages {
	private UserService userService;
	private MessageService messageService;
	
	public Messages(MessageService messageService, UserService userService) {
		this.userService = userService;
		this.messageService = messageService;
	}
	@RequestMapping("/messages")
	public String postMessage(@RequestParam(value="message") String message, Model model, Principal principal) {
   	
        String username = principal.getName();
        User currentUser = userService.findByUsername(username);
        
        Message newMessage = new Message();
        newMessage.setMessage(message);
        newMessage.setUser(currentUser);
        messageService.update(newMessage);
        
        userService.updateUse(currentUser);
        for(Message msg: messageService.allMessages()) {
        	System.out.println(msg);
        }
     
		return "redirect:/";
	}
}
