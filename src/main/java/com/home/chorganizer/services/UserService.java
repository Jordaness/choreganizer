package com.home.chorganizer.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.home.chorganizer.models.House;
import com.home.chorganizer.models.Role;
import com.home.chorganizer.models.User;
import com.home.chorganizer.repositories.RoleRepository;
import com.home.chorganizer.repositories.UserRepository;

@Service
public class UserService {
    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepository= userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
    
    public void makeRoles() {
    	if(roleRepository.findAll().size() == 0) {
    		Role user = new Role();
    		user.setType("ROLE_USER");
    		roleRepository.save(user);
    		
    		Role admin = new Role();
    		admin.setType("ROLE_ADMIN");
    		roleRepository.save(admin);
    		
    		Role houseManager = new Role();
    		houseManager.setType("ROLE_MANAGER");
    		roleRepository.save(houseManager);
    		
    		Role superb = new Role();
    		superb.setType("ROLE_SUPER");
    		roleRepository.save(superb);
    	}
    }

    public User savePleb(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        user.setRoles(roles);
        return userRepository.save(user);
    }
    public User saveAdmin(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        user.setRoles(roles);
        return userRepository.save(user);
    }
    public User saveManager(User user) {
    	 user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
         ArrayList<Role> roles = new ArrayList<Role>();
         roles.add(roleRepository.findByType("ROLE_USER"));
         roles.add(roleRepository.findByType("ROLE_ADMIN"));
         roles.add(roleRepository.findByType("ROLE_MANAGER"));
         user.setRoles(roles);
         return userRepository.save(user);
    }
    public User saveSuper(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        roles.add(roleRepository.findByType("ROLE_MANAGER"));
        roles.add(roleRepository.findByType("ROLE_SUPER"));
        user.setRoles(roles);
        return userRepository.save(user);
    } 

    public User findByEmail(String email) {
    	Optional<User> u = userRepository.findByEmail(email);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    public User findById(Long id) {
 	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    public boolean isSuperUser(User user) {
    	Role superUser = roleRepository.findByType("ROLE_SUPER");
    	if(user.getRoles().contains(superUser)) {
    		return true;
    	} else {
    		return false;
    	}
    	
    }
    
    public List<User> everyUser(){
    	return userRepository.findAll();
    }
    public List<User> allUsers(House house) {
    	return userRepository.findByHouse(house);
    }

    public void updatePleb(User user) {
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateAdmin(User user) {
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateManager(User user) {
    	ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        roles.add(roleRepository.findByType("ROLE_MANAGER"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateSuper(User user) {
    	ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        roles.add(roleRepository.findByType("ROLE_MANAGER"));
        roles.add(roleRepository.findByType("ROLE_SUPER"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateAccount(User user) {
    	userRepository.save(user);
    }
    
    public void updateSignIn(User user) {
    	user.setLastSignIn(new Date());
    	userRepository.save(user);
    }
    
    public void deleteUser(Long id) {
    	userRepository.deleteById(id);
    }
    
    public void addHouse(House house, User user) {
    	user.setHouse(house);
    	userRepository.save(user);
    }
    
    public void removeHouse(House house, User user) {
    	user.setHouse(null);
    	userRepository.save(user);
    }
}