package com.ahn.tripplan.common;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(
			HttpServletRequest request
			, HttpServletResponse response
			, Object handler) throws IOException {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		// /user/signin/view
		String uri = request.getRequestURI();
		
		// 로그인이 되어 있는 경우
		if(userId != null) {
			
			// 회원가입 페이지, 로그인 페이지를 접근할 경우
			// /user/signup/view, /user/signin/view
			// /user 로 시작하는 페이지 접근할 경우
			if(uri.startsWith("/user")) {
				// 메모 리스트 페이지로 이동
				response.sendRedirect("/destination/main/view");
				return false;
			}
		} else {
			// 로그인이 되어 있지 않은 경우
			// 메모리스트, 입력화면, 디테일화면으로 접근할 경우
			if(!uri.startsWith("/user")) {
				// 로그인 페이지로 이동
				response.sendRedirect("/user/signin/view");
				return false;
			}
		}
		return true;
	}
	
	@Override
	public void postHandle(
			HttpServletRequest request
			, HttpServletResponse response
			, Object handler
			, ModelAndView modelAndView) {
		
	}
	
	@Override
	public void afterCompletion(
			HttpServletRequest request
			, HttpServletResponse response
			, Object handler
			, Exception ex) {
		
	}
}
