package com.home.chorganizer.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.home.chorganizer.models.Chore;
import com.home.chorganizer.models.House;
import com.home.chorganizer.models.User;
import com.home.chorganizer.services.ChoreService;
import com.home.chorganizer.services.HouseService;
import com.home.chorganizer.services.UserService;
import com.home.chorganizer.validator.HouseValidator;
import com.home.chorganizer.validator.UserValidator;

@Controller
public class UserController {
	
    
    private UserService userService;
    private UserValidator userValidator;
	private ChoreService choreService;
	private HouseService houseService;
	private HouseValidator houseValidator;
	
    public UserController(UserService userService, UserValidator userValidator,ChoreService choreService, HouseService houseService, HouseValidator houseValidator) {
        this.userService = userService;
        this.choreService = choreService;
        this.userValidator = userValidator;
        this.houseService = houseService;
        this.houseValidator = houseValidator;
        // Create roles on boot up
        this.userService.makeRoles();
    }
    
    @RequestMapping("/login")
    public String login(@ModelAttribute("user") User user, @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, HttpSession session) {
    	if(logout != null) {
            model.addAttribute("logout", "Logout Successful!");
        }
        if(error != null) {
            model.addAttribute("logError", "Invalid credentials, please try again.");
        }
        return "index.jsp";
    }
    
    
    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, @RequestParam("password") String password, Model model, HttpSession session, HttpServletRequest request) {
        userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "index.jsp";
        }
        if(userService.allUsers().size() == 0) {
        	User u = userService.saveSuper(user);
        	try {
        		request.login(u.getEmail(), password);
        	} catch(ServletException e) {
        		// can't fail
        	}
            session.setAttribute("userId", u.getId());
            return "redirect:/home";
        }
        else {
            User u = userService.savePleb(user);
            try {
        		request.login(u.getEmail(), password);
        	} catch(ServletException e) {
        		// can't fail
        	}
            session.setAttribute("userId", u.getId());
            return "redirect:/addHouse";
        }
    }
    
    // Add House Form for new users
    @RequestMapping(value="/addHouse", method=RequestMethod.GET)
    public String addHouse(@ModelAttribute("house") House house, Principal principal, Model model, @RequestParam(value="error", required=false) String error) {
    	String email = principal.getName();
    	User user = userService.findByEmail(email);
    	if(user == null) { // user must be logged in
    		return "redirect:/login";
    	}
    	if(user.getHouse() == null && user.getRoles().size() <= 2) { //user has no current house, and not be the super user
    		model.addAttribute("user", user);
    		if(error != null) {
    			model.addAttribute("logError", "Invalid house credentials, please try again.");
    		}
    		return "addHouse.jsp";
    	} else { //user has house or is an admin
    		if(user.getRoles().size() >= 2) { // admin go elsewhere
            	return "redirect:/admin";
            }
    		return "redirect:/home";
    	}
    	
    }
    // connect to a existing house
    @RequestMapping(value="/addHouse", method=RequestMethod.POST)
    public String connectHouse(Principal principal, @RequestParam("houseName") String name, @RequestParam("housePassword") String password) {
    	if(houseService.authenticateHouse(name, password)) { //successfully signed up for house
    		House house = houseService.findByName(name);
    		String email = principal.getName();
    		User member = userService.findByEmail(email);
    		userService.addHouse(house, member);
    		return "redirect:/home";
    	} else { //failed to validate house
    		return "redirect:/addHouse?error=true";
    	}
    }
    
    // create a new house
    @RequestMapping(value="/createHouse", method=RequestMethod.POST)
    public String createHouse(@Valid @ModelAttribute("house") House house, BindingResult result, HttpSession session, Principal principal) {
    	houseValidator.validate(house, result);
    	if(result.hasErrors()) { //return user to form to fix errors
    		return "addHouse.jsp";
    	} else { // create house and add member
    		House home = houseService.createHouse(house);
    		String email = principal.getName();
    		User member = userService.findByEmail(email);
    		userService.addHouse(home, member);
    		return "redirect:/home";
    	}
    }
    
    @RequestMapping(value= {"/", "/home"})
    public String user(@ModelAttribute("chore") Chore chore, HttpSession session, Principal principal, Model model, @RequestParam(value="priority", required=false) String priority) {
    	String email = principal.getName();
    	if(email == null) {
    		return "redirect:/login";
    	}
    	User user = userService.findByEmail(email);
    	House house = user.getHouse();
    	if(house == null) {
    		return "redirect:/addHouse";
    	}
    	model.addAttribute("user", user);
    	Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
        if(user.getRoles().size() > 1) {
        	return "redirect:/admin";
        }
        return "userdash.jsp";
    }
    
    @RequestMapping("/admin")
    public String admin(@ModelAttribute("chore") Chore chore, HttpSession session, Principal principal, Model model, @RequestParam(value="priority", required=false) String priority) {
        String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        model.addAttribute("allUsers", userService.allUsers());
        User user = userService.findByEmail(email);
        session.setAttribute("userId", user.getId());
        Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
        if(user.getRoles().size() > 2) {
        	model.addAttribute("super", "this is a super admin user");
        }
        if(user.getRoles().size() > 1) {
        	model.addAttribute("admin", "this is an admin user"); 
        }
        return "admindash.jsp";
    }    
 
    @RequestMapping("/make-admin/{id}")
    public String makeAd(@PathVariable("id") Long id){
        User user = userService.findById(id);
        userService.updateAdmin(user);
        return "redirect:/admin";
    }
    @PostMapping("/take-admin/{id}")
    public String takeAd(@PathVariable("id") Long id){
        User user = userService.findById(id);
        userService.updatePleb(user);
        return "redirect:/admin";
    }
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id){
    	userService.deleteUser(id);
        return "redirect:/admin";
    }
    
    @RequestMapping("/logout")
    public String logout(Principal principal, HttpSession session) {
    	String email = principal.getName();
        User user = userService.findByEmail(email);
        userService.updateSignIn(user);
        session.invalidate();
        return "redirect:/login?logout";
    }
    
    @RequestMapping(value="/chores/new", method=RequestMethod.POST)
    public String createChore(@Valid @ModelAttribute("chore") Chore chore, BindingResult result, Model model, HttpSession session) {
       if (result.hasErrors()) {
           return "admindash.jsp";
       } else {
		   Long userId = (Long) session.getAttribute("userId");
		   User user = userService.findById(userId);
		   model.addAttribute("user", user);
		   chore.setCreator(user);
	       choreService.createChore(chore);
	       return "redirect:/admin";
       }

    }
    
    @GetMapping("/chores/{id}/delete")
   	public String deleteChore(@PathVariable("id")Long id) {
   		choreService.deleteChore(id);
   		return "redirect:/home";
   	}
    
    @RequestMapping("chores/{idEdit}/edit")
    public String edit(@ModelAttribute("chore") Chore chore, @PathVariable("idEdit") Long id, Principal principal, Model model, HttpSession session) {
    	String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        model.addAttribute("allUsers", userService.allUsers());
        User user = userService.findByEmail(email);
        session.setAttribute("userId", user.getId());
    	Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
    	Chore choreToEdit = choreService.findOne(id);
//    	Long currentUser = (Long) session.getAttribute("userId");
//    	if (choreToEdit.getCreator().getId() != currentUser) {
//    		return "redirect:/admin";
//    	} else {
    	List<User> users = userService.allUsers();
    	model.addAttribute("users", users);
    	model.addAttribute("chore", choreToEdit);
    	return "/edit.jsp";  
//    	}
    }
    
    @PostMapping("/chores/{id}/edit")
    public String editChore(@Valid@ModelAttribute("chore") Chore chore, BindingResult result, @PathVariable("id") Long id, Model model, HttpSession session) {
    	if (result.hasErrors()) {
    		List<User> users = userService.allUsers();
    		model.addAttribute("users", users);
            return "/edit.jsp";
    	} else {
    		Long currentUser = (Long) session.getAttribute("userId");
    		User u = userService.findById(currentUser);
    		chore.setCreator(u);
    		choreService.updateChore(chore);
    		return "redirect:/chores/{id}/edit";
    	} 
    }
    
}
