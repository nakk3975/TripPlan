package com.ahn.tripplan.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ahn.tripplan.user.bo.UserBO;
import com.ahn.tripplan.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@PostMapping("/signup")
	public Map<String,String> signup(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("nickname") String nickname
			, @RequestParam("email") String email
			, @RequestParam("phoneNumber") String phoneNumber) {
		
		int count = userBO.addUser(loginId, password, name, nickname, email, phoneNumber);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/signup/duplication")
	public Map<String, Boolean> signupDuplication(@RequestParam("loginId") String loginId) {
		
		int count = userBO.selectLoginId(loginId);
		
		Map<String, Boolean> result = new HashMap<>();
		
		result.put("result", count == 1);

		return result;
	}
	
	@PostMapping("/signin")
	public Map<String, String> signin(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request) {
		
		User user = userBO.selectLogin(loginId, password);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			HttpSession session = request.getSession();
			
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/passwordsearch")
	public Map<String, String> passwordsearch(
			@RequestParam("loginId") String loginId
			, @RequestParam("email") String email
			, HttpServletRequest request) {
		
		User user = userBO.passwordSearch(loginId, email);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			HttpSession session = request.getSession();
			
			session.setAttribute("userId", user.getId());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	@PostMapping("/passwordchange")
	public Map<String, String> passwordChange(
			@RequestParam("id") int id
			, @RequestParam("password") String password){
		
		int count = userBO.updatePassword(id, password);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	@GetMapping("/idcheck")
	public Map<String, String> idCheck(
			@RequestParam("name") String name
			, @RequestParam("email") String email
			, @RequestParam("phoneNumber") String phoneNumber
			, HttpServletRequest request) {
		
		User user = userBO.selectId(name, email, phoneNumber);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			HttpSession session = request.getSession();
			
			session.setAttribute("userName", user.getName());
			session.setAttribute("userId", user.getLoginId());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
		
	}
	
}
