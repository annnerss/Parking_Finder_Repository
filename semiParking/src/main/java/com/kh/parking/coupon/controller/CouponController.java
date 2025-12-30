package com.kh.parking.coupon.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.parking.coupon.model.service.CouponService;
import com.kh.parking.member.model.vo.Member;

@Controller
public class CouponController {
	
	@Autowired
	private CouponService service;
	
	//쿠폰페이지 이동
	@GetMapping("/couponPage.get")
	public String couponPage(HttpSession session) {
		Member loginMem = (Member) session.getAttribute("loginMember");
		if(loginMem == null) {
			return "redirect:/";
		}
		return "member/couponPage";
	}
	
	//쿠폰 등록
	@ResponseBody
	@PostMapping("/couponInsert.co")
	public String couponInsert (@RequestParam ("couponCode") String couponCode
				  			, HttpSession session) {
		
		Member loginMem = (Member)session.getAttribute("loginMember");
		if (loginMem != null) {
			
			couponCode = couponCode.toUpperCase();
			
			int result = service.couponInsert(loginMem.getMemId(), couponCode);
			
			if(result > 0) {	
				return "success";
			}else if (result == -1) {
				return "invalid";
			}else if(result == -2){
				return "duplicate";
			}else{
				return "fail";
			}
		}
		return "login";
	}
	
	//쿠폰 리스트 
//	@GetMapping("/couponList.co")
//	public String couponList(HttpSession session, Model model) {
//		
//		Member loginMem = (Member)session.getAttribute("loginMember");
//		
//		if(loginMem != null) {
//			
//			List<Map<String, Object>> list = service.couponList(loginMem.getMemId());
//			
//			model.addAttribute("list", list);
//			
//			return "coupon/couponList";
//		}
//		
//		return "redirect:/";
//	}
	
	//쿠폰 리스트 ajax
	@ResponseBody
	@GetMapping("/couponList.co")
	public List<Map<String, Object>> couponList(HttpSession session) {

	    Member loginMem = (Member) session.getAttribute("loginMember");

	    if (loginMem == null) {
	        return null; // 프론트에서 로그인 여부 처리
	    }

	    return service.couponList(loginMem.getMemId());
	}

	
	
}
