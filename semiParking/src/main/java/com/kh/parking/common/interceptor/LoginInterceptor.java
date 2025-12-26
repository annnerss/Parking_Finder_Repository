package com.kh.parking.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.parking.member.model.vo.Member;

public class LoginInterceptor implements HandlerInterceptor {
	
	
	//1. 간섭 시점 1 : 요청 처리 전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//request : 사용자는 무엇을 요청했는가
		//response : 사용자에게 보낼 정보가 있는가
		//handler : 이 요청은 누가 처리할 것인가.
		
		HttpSession session = request.getSession();
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		String uri = request.getRequestURI(); // 현재 URI 갖고 오기 
		
		//System.out.println(uri);
		
		String method = request.getMethod(); // 메서드 방식 갖고오기
		
		if(loginMember!=null && loginMember.getStatus().equals("Y")) { // 로그인 정보가 있어야하고 상태가 Y일때 
			return true; // 흐름 유지 
		} else if(loginMember!=null && loginMember.getStatus().equals("H")){ // 휴면 회원 일 때 
			
			if(uri.endsWith("/mypage.me")) { // 마이페이지는 허용 가능하게 해야한다. (휴면 해제를 해야 하므로) 
			    return true;
			}
			
			if("/parking/favorites.parking".equals(uri) && "POST".equalsIgnoreCase(method)) { // 찜하기 버튼을 눌렀을때 인터셉터 걸기	
				session.setAttribute("alertMsg", "휴면 해제 후 이용 가능한 서비스입니다.");
				
				response.sendRedirect(request.getContextPath()); // 일단 임시방편, 메인페이지 혹은 현재페이지로 해야함.
			} else if("/parking/favorites.parking".equals(uri) && "GET".equalsIgnoreCase(method)) { // 찜 목록 조회는 흐름 유지 
				return true; 
			}
			
			if("/parking/removefavorite.parking".equals(uri)) { // 찜 목록 삭제는 흐름 막기 				
				session.setAttribute("alertMsg", "휴면 해제 후 이용 가능한 서비스입니다.");
			}
			 
			//response.sendRedirect(request.getContextPath()); 
		} else if(loginMember==null) { // 비회원일때 
			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
			response.sendRedirect(request.getContextPath()); // 메인 페이지로 이동 
		}
		
		return false; 
		
	}
	
}
