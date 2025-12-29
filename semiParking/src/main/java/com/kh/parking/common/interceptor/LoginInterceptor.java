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
		
		String method = request.getMethod(); // 메서드 방식 갖고오기
		
		if(loginMember!=null && loginMember.getStatus().equals("Y")) { // 로그인 정보가 있어야하고 상태가 Y일때 
			return true; // 흐름 유지 
		} else if(loginMember!=null && loginMember.getStatus().equals("H")){ // 휴면 회원 일 때 
			
			if(uri.endsWith("/mypage.me")) { // 마이페이지는 허용 가능하게 해야한다. (휴면 해제를 해야 하므로) 
			    return true;
			}
			
			
			if("/parking/favorites.parking".equals(uri) && "GET".equalsIgnoreCase(method)) { // 찜 목록 조회는 흐름 유지
				return true;
				
			}
			
			//이거는 location.href로 인해서 페이지가 이동됨과 동시에 메뉴바에 alertMsg가 있으니까 띄워진것. 
			if("/parking/removefavorite.parking".equals(uri)) { // 찜 목록 삭제는 흐름 막기 				
				session.setAttribute("alertMsg", "휴면 해제 후 이용 가능한 서비스입니다.");
				return false; 
			}
			
			
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
	            response.getWriter().write("휴면 해제 후 이용 가능한 서비스입니다.");
	            return false;   // 컨트롤러로 못 가게 막기
	        }
	        
	        ///////////////// 여기는 비동기식 처리가 아닐때 처리하는 코드
	        session.setAttribute("alertMsg", "휴면 해제 후 이용 가능한 서비스입니다.");
	        response.sendRedirect(request.getContextPath());// 메인 페이지로 이동 
	        ////////////////
		} else if(loginMember==null) { // 비회원일때 
			//session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
			//response.sendRedirect(request.getContextPath()); // 메인 페이지로 이동 
			
			////////////////////////
			String requestedWith = request.getHeader("X-Requested-With");
			
			boolean isAjax = "XMLHttpRequest".equals(requestedWith);
	        //XMLHttpRequest이면 AJAX요청임을 알게해주는 변수 

	        if(isAjax){
	            response.setStatus(403); // 금지
	            response.setContentType("text/plain; charset=UTF-8");
	            response.getWriter().write("로그인 후 이용 가능한 서비스입니다.");
	            return false;   // 컨트롤러로 못 가게 막기
	        }
	        ////////////////////////////
	        session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	        response.sendRedirect(request.getContextPath());// 메인 페이지로 이동 
		}
		return false; 
	}
}