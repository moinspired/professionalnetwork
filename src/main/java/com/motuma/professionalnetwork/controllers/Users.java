package com.motuma.professionalnetwork.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.motuma.professionalnetwork.models.Message;
import com.motuma.professionalnetwork.models.Profile;
import com.motuma.professionalnetwork.models.User;
import com.motuma.professionalnetwork.services.CommentService;
import com.motuma.professionalnetwork.services.MessageService;
import com.motuma.professionalnetwork.services.ProfileService;
import com.motuma.professionalnetwork.services.SecurityService;
import com.motuma.professionalnetwork.services.UserService;

@Controller
public class Users {
	@Autowired
	private UserService userService;

	@Autowired
	private MessageService messageService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private SecurityService securityService;

	@Autowired
	private ProfileService profileService;

	@RequestMapping("/createProfile")
	public String createProfile(Principal principal, Model model) {
		String username = principal.getName();
		User user = userService.findByUsername(username);
		model.addAttribute(user);
		
		System.out.println("Inside get reg");
		return "createProfile.jsp";
	}

	@PostMapping("/createProfile")
	public String creatInfo(
			@RequestParam(value="headline") String headline, 
			@RequestParam(value="currentPosition") String currentPosition,
			@RequestParam(value="education") String education,
			@RequestParam(value="summary") String summary, Principal principal, Model model){


		String username = principal.getName();
		User user = userService.findByUsername(username);
	
		System.out.println(user);

		model.addAttribute(user);
		
		Profile newProfile = new Profile();
		newProfile.setHeadline(headline);
		newProfile.setCurrentPosition(currentPosition);
		newProfile.setEducation(education);
		newProfile.setSummary(summary);
		newProfile.setUser(user);
		
		profileService.update(newProfile);
		

		return "redirect:/createProfile";
	}


	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			return "loginPage.jsp";
		}
		userService.saveWithUserRole(user);
		securityService.autologin(user.getUsername(), user.getPassword());
		return "redirect:/login";
	}



	@RequestMapping("/login")
	public String login(@ModelAttribute("user") User user, @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
		if(error != null) {
			model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
		}
		if(logout != null) {
			model.addAttribute("logoutMessage", "Logout Successfull!");
		}
		return "loginPage.jsp";
	}

	@RequestMapping(value = {"/", "/home"})
	public String home(Principal principal, Model model) {
		List<User> networks = new ArrayList<User>();

		List<Message> messages = new ArrayList<Message>();

		String username = principal.getName();
		User user = userService.findByUsername(username);
		try {
			for(User network:  user.getUserFriends()) {
				networks.add(network);
			}
			for(User network:  user.getFriends()) {
				networks.add(network);
			}

			model.addAttribute("networks", networks);
			model.addAttribute("invitations",  user.getInvitation());

			model.addAttribute("currentUser", user);
			model.addAttribute("messages", messageService.allMessages());
			
			model.addAttribute("userProfile", profileService.getProfile(user.getId()));
		} catch (NullPointerException e) {

			return "professionalProfile.jsp";
		}
		return "professionalProfile.jsp";
	}

	@RequestMapping("/users")
	public String findConnection(Principal principal, Model model) {
		List<User> nonNetwork = new ArrayList<User>();
		List<User> networks = new ArrayList<User>();
		List<Object> userProfile = new ArrayList<Object>();
		
		
		String username = principal.getName();
		User currentUser = userService.findByUsername(username);


		for(User network:  currentUser.getUserFriends()) {
			networks.add(network);
		}
		for(User network:  currentUser.getFriends()) {
			networks.add(network);
		}

		model.addAttribute("networks", networks);
		model.addAttribute("invitations",  currentUser.getInvitation());
	

		//excluding users that are not connected to the logged in 
		for (User item : userService.getUsers()) { 
			if (item.equals(currentUser)) {

			}
			else if ( currentUser.getFriends().contains(item)) {

			} 
			else if ( currentUser.getUserFriends().contains(item)) {

			}  
			else if ( currentUser.getInvitation().contains(item)) {

			}
			else if ( currentUser.getUserInvites().contains(item)) {

			}    

			else {
				nonNetwork.add(item);
			}
		}
		
		//get all the user and their network in a list
		for(Profile prof: profileService.allProfile()) {
			System.out.println(userProfile.add(prof.getId()));
		}
		
		
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("users", nonNetwork);
		model.addAttribute("profiles", profileService.allProfile());

		return "connectUsers.jsp";
	}


	@RequestMapping("/user/{id}")
	public String display(@PathVariable Long id, Model model, Principal principal) {
		User user = userService.getUser(id);
		model.addAttribute("user", user);
		
		model.addAttribute("userProfile", profileService.getProfile(id));
	
		return "profilePage.jsp";
	}

	@RequestMapping("/connect/user/{id}")
	public String makeConnection(@PathVariable Long id, Model model, Principal principal) {
		User user = userService.getUser(id);


		String username = principal.getName();
		User currentUser = userService.findByUsername(username);

		user.getInvitation().add(currentUser);
		userService.updateUse(user);

		return "redirect:/users";
	}

	@RequestMapping("/accept/user/{id}")
	public String acceptInvitation(@PathVariable Long id, Model model, Principal principal) {

		User user = userService.getUser(id);

		String username = principal.getName();
		User currentUser = userService.findByUsername(username);

		//add invitation to frienship
		currentUser.getFriends().add(user);
		userService.updateUse(currentUser);

		//remove user's invitation
		currentUser.getInvitation().remove(user);
		userService.updateUse(currentUser);
		//        
		//        
		//        for(User invite: currentUser.getInvitation()) {
		//        	System.out.println(invite.getName());
		//        	memberCount++;
		//        	if(invite.getId() == id) {
		//        		System.out.println(memberCount);
		//   
		//        	}
		//        }
		//         
		return "redirect:/";

	}

	@RequestMapping("/ignore/user/{id}")
	public String ignore(@PathVariable Long id, Model model, Principal principal) {
		User user = userService.getUser(id);

		String username = principal.getName();
		User currentUser = userService.findByUsername(username);

		currentUser.getInvitation().remove(user);
		userService.updateUse(currentUser);


		for(User use: currentUser.getInvitation()) {
			System.out.println(user.getName());
		}
		return "redirect:/";
	}


}