package com.ncs.green;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MemberService;
import vo.MemberVO;

// ** Bean 생성하는 @
// Java : @Component
// Spring 세분화 됨
// => @Controller,  @Service,  @Repository

@Controller
public class MemberController {
	@Autowired 
	// 자동주입 (injection)
	// => 조건: 주입받으려는 구현 클래스가 반드시 생성되어있어야함. 
	MemberService service;
	//MemberService service = new MemberServiceImpl();
	
	//** 0. stamp
	@RequestMapping(value = "/stamp", method=RequestMethod.GET)
	public ModelAndView stamp(ModelAndView mv, MemberVO vo) {
		// 1. 요청분석 & Service
		mv.addObject("apple", service.selectOne(vo));
		// 2. 결과 : view 처리
		mv.setViewName("stamp/stamp");
		return mv;
	} //stamp
	
	//** ID 중복 확인
	@RequestMapping(value = "/idDupCheck", method=RequestMethod.GET)
	public ModelAndView idDupCheck(ModelAndView mv, MemberVO vo) {
		// 입력한 newID 보관
		mv.addObject("newId", vo.getId());
		vo = service.selectOne(vo);
		if ( vo!=null ) { 
			// id 존재 -> 사용불가능
			mv.addObject("idUse", "F");
		}else {
			// id 존재하지 않음 -> 사용가능
			mv.addObject("idUse", "T");
		}
		mv.setViewName("member/idDupCheck");
		return mv;
	} //idDupCheck
	
	//** 1. Login
	@RequestMapping(value = "/loginf", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("member/loginForm");
		return mv;
	} //loginf
	
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, ModelAndView mv, MemberVO vo, RedirectAttributes rttr) throws NoSuchAlgorithmException {
		
		SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		byte[] bytes = new byte[16];
		random.nextBytes(bytes);
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		
		String pw = vo.getId() + vo.getPassword();
		
		md.update(pw.getBytes());
		String pass = String.format("%064x", new BigInteger(1, md.digest()));//입력한 비밀번호
		
		vo = service.selectOne(vo); //아이디로 검색한 DB
		
		if ( vo!=null ) {
			// id 성공 -> password 확인
			
			if ( pass.equals(vo.getPassword()) ) { //검색된비번, 입력한비번
				// Login 성공 -> Login정보(id,name) 보관 -> home
				// => session 객체 생성후 보관
				HttpSession session = request.getSession(true);
				session.setAttribute("LoginID",vo.getId()); 
				session.setAttribute("LoginName",vo.getName());
				// mv.addObject("message", " 로그인 성공 ");
				// => redirect 의 경우 메시지 출력안됨
				//    해결 : RedirectAttributes 
				// rttr.addFlashAttribute("message", "~~ Login 성공 ~~");
				mv.setViewName("redirect:home");
				// => 요청명 "home" 으로 sendRedirect
			}else {
				// password 오류 -> LoginForm
				rttr.addFlashAttribute("message", " password 를 확인해주세요 ");
				mv.setViewName("redirect:home");
			}
		}else {
			// id 오류 -> LoginForm
			rttr.addFlashAttribute("message", " id 를 확인해주세요 ");
			mv.setViewName("redirect:home");
		}
		// 3. 결과 : view 처리
		return mv;
		
	} //login
	
	@RequestMapping(value = "/logout") 
	public ModelAndView logout(HttpServletRequest request, ModelAndView mv, RedirectAttributes rttr) {
		// 1. Logout => session 무효화
		request.getSession().invalidate(); 
	
		// 2. 결과(View) 처리
		//mv.addObject("message", "~~ Logout 성공 ~~");
		rttr.addFlashAttribute("message", "~~ Logout 성공 ~~");
		mv.setViewName("redirect:home");
		return mv;
	} //logout
	
	//** 2. Join
	@RequestMapping(value = "/joinf", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView joinf(ModelAndView mv) {
		mv.setViewName("member/joinForm");
		return mv;
	} //joinf
	
	//@RequestMapping(value = "/join", method=RequestMethod.GET)
	// => 405: Request method 'POST' not supported
	@RequestMapping(value = "/join", method=RequestMethod.POST)
	public ModelAndView join(HttpServletRequest request, ModelAndView mv, MemberVO vo) throws IOException, NoSuchAlgorithmException {
		
		SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		byte[] bytes = new byte[16];
		random.nextBytes(bytes);
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		
		String pw = vo.getId() + vo.getPassword();
		
		md.update(pw.getBytes());
		String pass = String.format("%064x", new BigInteger(1, md.digest()));
		
		vo.setPassword(pass);
		
		System.out.println("***** vo => "+vo);
		
		// 2. Service
		if ( service.insert(vo) > 0 ) {
			// 입력성공 -> loginForm 으로 
			mv.addObject("message", " 회원가입 성공 ");
			mv.setViewName("home");
		}else {
			// 입력실패 -> 재시도 유도 joinForm 으로
			mv.addObject("message", " 회원가입 오류 ");
			mv.setViewName("home");
		}
		// 3. 결과 : view 처리
		return mv;
	} //join
	
} //class
