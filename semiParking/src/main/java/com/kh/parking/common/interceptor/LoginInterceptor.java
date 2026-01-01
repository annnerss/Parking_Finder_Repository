package com.kh.parking.common.interceptor;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import com.kh.parking.member.model.vo.Member;

public class LoginInterceptor implements HandlerInterceptor {
	
	private static final String MYPAGE_URI = "/mypage.me"; // 마이페이지 URI 
	private static final String FAVORITES_URI = "/favorites.parking"; // 찜 목록 URI, 찜 등록하기 URI 
	private static final String REMOVE_FAVORITES_URI = "/removefavorite.parking";
	
	//1. 간섭 시점 1 : 요청 처리 전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		String uri = request.getRequestURI(); // 현재 URI 갖고 오기 
		
		String method = request.getMethod(); // 메서드 방식 갖고오기
		
		if(loginMember!=null && loginMember.getStatus().equals("Y")) { // 로그인 정보가 있어야하고 상태가 Y일때 
			return true; // 흐름 유지 
		} else if(loginMember!=null && loginMember.getStatus().equals("H")){ // 휴면 회원 일 때 
			
			if(uri.endsWith(MYPAGE_URI) || (uri.endsWith(FAVORITES_URI)) && "GET".equalsIgnoreCase(method)) {
				// uri가 /mypage.me , /favorites.parking으로 끝날때 휴면 회원이여도 마이페이지랑 찜 목록 조회는 이용 가능하게 한다. 
				return true; 
			} else if(uri.endsWith(REMOVE_FAVORITES_URI)) { // 찜 목록에서 삭제하기 버튼은 흐름 유지 X.
				session.setAttribute("alertMsg", "휴면 해제 후 이용 가능한 서비스입니다.");
				return false; 
			}
			
			handleBlockedRequest(request, response, session, "휴면 해제 후 이용 가능한 서비스입니다."); 
	        
		} else if(loginMember==null) { // 비회원일때 
			
			handleBlockedRequest(request, response, session, "로그인 후 이용 가능한 서비스입니다."); 
		}
		return false; 
	}
	
	private boolean handleBlockedRequest(HttpServletRequest request, HttpServletResponse response, HttpSession session, String message) throws IOException {
		// AJAX 요청인지 확인
        String requestedWith = request.getHeader("X-Requested-With");
        
        //클라이언트가 AJAX 요청을 보낼 때, jQuery는 자동으로 요청 헤더에 이 값을 추가함:
        //X-Requested-With: XMLHttpRequest
        //AJAX 요청이면 "XMLHttpRequest"
        //일반 브라우저 이동이면 null
        
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);
        //XMLHttpRequest이면 AJAX요청임을 알게해주는 변수 

        if(isAjax){
            response.setStatus(403); // 금지
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write(message);
            return false;   // 컨트롤러로 못 가게 막기
        }
        
        //비동기식 처리가 아닐때 처리하는 코드
        session.setAttribute("alertMsg", message);
        response.sendRedirect(request.getContextPath());// 메인 페이지로 이동
        
        return false; 
	}
}