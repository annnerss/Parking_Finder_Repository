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

//org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service; // 자동으로 빈 주입. 
	
	@Autowired
	private BCryptPasswordEncoder bcrypt; // 암호화하는 빈 주입. 
	
	//일단 
	@RequestMapping("/login.me")
	public String loginMember(Member member, HttpSession session) { 
		// 매개변수에서 session은 jsp파일이나 웹브라우저에서 다 공유 가능하기도하고 로그인 정보는 홈페이지에 있는 내내 필요해서 매개변수로!
		
		// 여기서는 휴면 계정인지 파악을 해야한다. 그래서 컨트롤러에 휴면 계정인지 파악하는 로직 및 로그인 로직을 각각 구현 해야 한다.
		
		// 일단 우선순위는 로그인 로직부터
		Member loginMember = service.selectMember(member); // 아이디와 비밀번호로 데이터베이스에 접근 후, 조회
		
		System.out.println(loginMember);
		System.out.println("아이디 : " + member.getMemId());
		System.out.println("비밀번호 : " + member.getMemPwd());
		
		if(loginMember!=null && bcrypt.matches(member.getMemPwd(), loginMember.getMemPwd())) {
			session.setAttribute("alertMsg", "로그인 완료!");
			session.setAttribute("loginMember", loginMember); // 세션에 로그인 정보 담기 
		} else {
			session.setAttribute("alertMsg", "로그인 실패!");
		}
		
		return "redirect:/"; // 메인 페이지로 재요청. 

	}
	
	@RequestMapping("/logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginMember"); 
		
		session.setAttribute("alertMsg","로그아웃 되었습니다.");
		
		return "redirect:/"; 
		
	}
	
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
	
	
	
	

}
