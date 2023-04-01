package com.ahn.tripplan.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@GetMapping("/signin/view")
	public String signin() {
		return "user/signin";
	}
	
	@GetMapping("/signup/view")
	public String signup() {
		return "user/signup";
	}
	
	@GetMapping("/idSearch/view")
	public String idSearch() {
		return "user/idsearch";
	}
	
	@GetMapping("/passwordChange/view")
	public String passwordChange() {
		return "user/passwordchange";
	}
	
	@GetMapping("/idCheck/view")
	public String idCheck() {
		return "user/idcheck";
	}

	@GetMapping("/passwordchange")
	public String passwordChangSuccess(HttpServletRequest request) {

		HttpSession session = request.getSession();
		
		session.removeAttribute("userId");
		
		return "redirect:/user/signin/view";
	}
	
	@GetMapping("/idCheckSuccess")
	public String idCheckSuccess(HttpServletRequest request) {

		HttpSession session = request.getSession();
		
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		
		return "redirect:/user/signin/view";
	}
	
	@GetMapping("/signout")
	public String signout(HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userRole");
		
		return "redirect:/user/signin/view";
	}
	
}
