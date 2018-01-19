package com.motuma.professionalnetwork.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.motuma.professionalnetwork.models.Message;
import com.motuma.professionalnetwork.repositories.MessageRepository;

@Service
public class MessageService {
	private MessageRepository messageRepository;
	
	public MessageService(MessageRepository messageRepository) {
		this.messageRepository = messageRepository;
	}
	
	public List<Message> allMessages(){
		return messageRepository.findAll();
	}
	
	
	public void create(Message message) {
		messageRepository.save(message);
	}

	public Message getMessage(long id) {
		return (Message) messageRepository.findOne(id);
	}
	public void update(Message message) {
		messageRepository.save(message);
	}
	public void destroy(long id) {
		messageRepository.delete(id);
	}
}
