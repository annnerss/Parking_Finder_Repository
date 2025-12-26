package com.kh.parking.member.controller;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kh.parking.member.model.service.MemberService;
import com.kh.parking.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service; // 자동으로 빈 주입. 
	
	@Autowired
	private BCryptPasswordEncoder bcrypt; // 암호화하는 빈 주입. 
	
	//로그인 처리 및 휴면 판단 메소드 
	@RequestMapping("/login.me")
	public String loginMember(Member member, HttpSession session) { 
		// 매개변수에서 session은 jsp파일이나 웹브라우저에서 다 공유 가능하기도하고 로그인 정보는 홈페이지에 있는 내내 필요해서 매개변수로!

		// 여기서는 휴면 계정인지 파악을 해야한다. 그래서 컨트롤러에 휴면 계정인지 파악하는 로직 및 로그인 로직을 각각 구현 해야 한다.
		// 일단 우선순위는 로그인 로직부터
		Member loginMember = service.selectMember(member); // 아이디와 비밀번호로 데이터베이스에 접근 후, 조회, 휴면 처리까지 싹 다하기

		if(loginMember!=null && bcrypt.matches(member.getMemPwd(), loginMember.getMemPwd())) { // 평문과 암호화된 비밀번호가 일치하는지 검증
			
			if(loginMember.getStatus().equals("Y") || loginMember.getStatus()==null) { // STATUS가 Y면 로그인 바로 하게 하기 
				
				session.setAttribute("alertMsg", "로그인 완료!");
				session.setAttribute("loginMember", loginMember); // 세션에 로그인 정보 담기
					
			} else if(loginMember.getStatus().equals("H")) { // STATUS가 H면 휴면 계정이니까 강제로 이동 
				
				session.setAttribute("alertMsg", "휴면 계정입니다. 마이 페이지에서 정보를 수정후, 수정버튼을 눌러주세요. 수정을 안하면 휴면 상태가 유지 됩니다.");
				session.setAttribute("loginMember", loginMember); // 세션에 로그인 정보 담기
				
				//마이페이지로 이동 할 시 회원 정보도 유지해줘야 한다.
				
				return "member/mypage"; 
			} else if(loginMember.getStatus().equals("N")) { // 탈퇴 했고 DB에 STATUS = 'N'인 경우 
				session.setAttribute("alertMsg", "회원 정보가 없습니다.");
			}
			 
		} else {
			session.setAttribute("alertMsg", "로그인 실패!");
		}
		
		return "redirect:/"; // 메인 페이지로 재요청. 

	}
	
	//마이 페이지로 이동 
	@RequestMapping("/mypage.me")
	public String moveMypage() {
		return "member/mypage"; 
	}
	
	@RequestMapping("/update.me")
	public String updateMember(HttpSession session, Member loginMember) { // 수정한채로 세션에 담아놓기 
		
		//휴면 상태 풀어주는 작업도 해야하고 휴면이 아닌 다른 회원이여도 수정 하는 작업은 해줘야 한다. 
		
		System.out.println(loginMember); // 확인용 
		
		int result = service.updateMember(loginMember); // 수정한 페이지에 있는 정보들 갖고오기 
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "정보를 수정했습니다."); 
			session.setAttribute("loginMember",loginMember); // DB에서 정보 수정이 다 됐으면 session에 유지 
			
			return "redirect:/"; 
			
		} else {
			session.setAttribute("alertMsg", "정보 수정 실패했습니다."); 
			return "member/mypage"; // 수정이 안됐으면 그대로 	
		}
		
		
	}
	
	
	// 로그아웃 처리
	@RequestMapping("/logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginMember"); //로그아웃 할땐 로그인한 멤버 정보를 없애기 
		
		session.setAttribute("alertMsg","로그아웃 되었습니다.");
		
		return "redirect:/"; 
		
	}
	
	//회원 가입 
	@RequestMapping("/enrollForm.me") // 회원 가입 페이지 누를때 작동 
	public String enrollForm() {
		
		return "member/memberEnrollForm"; // 회원 가입 페이지로 이동
	}
	
	@PostMapping("/insert.me") // 회원 가입할땐 폼 태그를 이용해서 데이터를 받고 넣어야하니까 PostMapping.  
	public String insertMember(HttpSession session, Member member) { // 폼태그에서 입력한 값 바인딩 
		
		//데이터베이스에 있는 아이디를 중복 체크를 해줘야한다. (이건 따로 메소드를 만들어서 비동기식 처리) 
		
		//어차피 폼 태그에서 submit 버튼을 누르기 전에 아이디 및 비밀번호를 중복체크 하고 넘어온다.
		
		//넘어오면 이때 데이터베이스에 비밀번호를 암호화
		member.setMemPwd(bcrypt.encode(member.getMemPwd())); 
		
		int result = service.insertMember(member); // 회원 가입 처리 
		
		if(result > 0) {
			session.setAttribute("alertMsg", "회원 가입 성공!"); // 재요청이 되니까 모델에 있는 값은 사라진다. 
			return "redirect:/"; // 회원 가입이 끝나면 메인 페이지로 이동.
		} else {
			session.setAttribute("alertMsg", "회원 가입 실패! 다시 작성해주세요."); 
		}
		
		return "member/memberEnrollForm"; // 실패하면 그대로 
	
	}
	
	//회원 중복체크 
	@RequestMapping(value="/idcheck.me", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String idcheck(String inputId) {
		
		String memberId = service.selectMember2(inputId); // 중복체크 할때 입력한 멤버 아이디로 데이터베이스에서 조회 
		
		if(memberId!=null) {
			return "NNNNN";
		} 
		
		return "NNNNY"; 
		
	}
	
	//회원탈퇴
	@RequestMapping("/delete.me")
	public String deleteMember(HttpSession session, String memPwd) {
		
		 int result = 0; 
		
	     Member loginMember = (Member) session.getAttribute("loginMember");
	     
	     if(bcrypt.matches(memPwd, loginMember.getMemPwd())) { // 사용자가 입력한 평문과 암호화된 비밀번호가 일치한다면 삭제처리 
	    	 result = service.deleteMember(loginMember); // 삭제 처리 
	     }
	     
	     if(result > 0) {
	    	 session.removeAttribute("loginMember");  // 제거를 해야 탈퇴 순간 로그아웃 처리까지 가능. 
	    	 session.setAttribute("alertMsg","회원 탈퇴를 처리하였습니다.");
	    	 return "redirect:/"; 
	     } else {
	    	 session.setAttribute("alertMsg","회원 탈퇴 처리를 못했습니다."); 
	    	 
	    	 
	     }
	     
	     return "member/mypage"; // 실패 했으니까 마이페이지로 
	     
	     
		
	}
	
	
	
	
	
	
	

}
