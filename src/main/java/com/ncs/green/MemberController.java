package com.ncs.green;

import java.io.File;
import java.io.IOException;

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
	
	//** Ajax Member Delete 
	@RequestMapping(value = "/axmdelete")
	public ModelAndView axmdelete(HttpServletRequest request, ModelAndView mv, MemberVO vo) {
		// 1. 요청분석 & Service
		HttpSession session = request.getSession(false); 
		if ( session!=null && ((String)session.getAttribute("LoginID")).equals("admin")) {
			// 삭제가능
			if ( service.delete(vo) > 0 ) {
				// 삭제성공   
				mv.addObject("code", "200");
			}else {
				// 삭제실패 -> 서버오류  
				mv.addObject("code", "201");
			}
		}else {
			// 삭제 불가능 -> 로그인 정보 없음  
			mv.addObject("code", "202");
		}
		// 2. 결과 view처리 : Java 객체 -> JSON 
		mv.setViewName("jsonView");
		return mv;
	} //axmdelete
	
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
	public ModelAndView login(HttpServletRequest request, ModelAndView mv, MemberVO vo, RedirectAttributes rttr) {
		// 1. 요청분석
		String password = vo.getPassword();
		
		// 2. Service
		vo = service.selectOne(vo);
		if ( vo!=null ) {
			// id 성공 -> password 확인
			if ( vo.getPassword().equals(password) ) {
				// Login 성공 -> Login정보(id,name) 보관 -> home
				// => session 객체 생성후 보관
				HttpSession session = request.getSession(true);
				session.setAttribute("LoginID",vo.getId()); 
				session.setAttribute("LoginName",vo.getName());
				// mv.addObject("message", "~~ Login 성공 ~~");
				// => redirect 의 경우 메시지 출력안됨
				//    해결 : RedirectAttributes 
				rttr.addFlashAttribute("message", "~~ Login 성공 ~~");
				mv.setViewName("redirect:home");
				// => 요청명 "home" 으로 sendRedirect
			}else {
				// password 오류 -> LoginForm
				mv.addObject("message", "~~ password 오류 !! 다시 하세요 ~~");
				mv.setViewName("member/loginForm");
			}
		}else {
			// id 오류 -> LoginForm
			mv.addObject("message", "~~ id 오류 !! 다시 하세요 ~~");
			mv.setViewName("member/loginForm");
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
	public ModelAndView join(HttpServletRequest request, 
							ModelAndView mv, MemberVO vo) throws IOException {
		
		System.out.println("***** vo => "+vo);
		
		// 2. Service
		if ( service.insert(vo) > 0 ) {
			// 입력성공 -> loginForm 으로 
			mv.addObject("message", "~~ 회원가입 완료 -> 로그인후 이용 하세요 ~~");
			mv.setViewName("home");
		}else {
			// 입력실패 -> 재시도 유도 joinForm 으로
			mv.addObject("message", "~~ 회원가입 오류 -> 다시 하세요 ~~");
			mv.setViewName("home");
		}
		// 3. 결과 : view 처리
		return mv;
	} //join
	
	//** 3. MemberList
	@RequestMapping(value = "/mlist")
	public ModelAndView mlist(ModelAndView mv) {
		// 1. 요청분석 & Service
		mv.addObject("banana", service.selectList());
		mv.setViewName("member/memberList");
		
		// 2. 결과 : view 처리
		return mv;
	} //mlist
	
	//** 4. MemberDetail
	@RequestMapping(value = "/mdetail")
	public ModelAndView mdetail(HttpServletRequest request, ModelAndView mv, MemberVO vo) {
		// 1. 요청분석 & Service
		
		HttpSession session = request.getSession(false);  
		if ( session!=null && session.getAttribute("LoginID")!=null ) {
			 
			vo.setId((String)session.getAttribute("LoginID"));
			vo = service.selectOne(vo);
			if ( vo!=null ) { 
				// => vo를 View가 출력 가능하도록 담고 View 지정
				request.setAttribute("apple", vo);
				// => Detail or Update 확인 
				if ( request.getParameter("jcode")!=null && request.getParameter("jcode").equals("U") )  
					 mv.setViewName("member/updateForm");
				else mv.setViewName("member/memberDetail");
				
			}else {
				// => user 정보 읽어오는데 실패 -> 재로그인 유도 ( loginForm.jsp ) 
				mv.addObject("message", "~~ vo null: 개인정보 읽어오기 실패 !! ~~");
				mv.setViewName("member/loginForm");
			} // vo
		}else {
			// 로그인정보가 없음을 알려준다 -> 재로그인 유도 ( loginForm.jsp )
			mv.addObject("message", "~~ session null: 로그인 정보가 없습니다 !! ~~");
			mv.setViewName("member/loginForm");
		} // session_if-else
		
		// 2. 결과 : view 처리
		return mv;
	} //mdetail
	
	//** 7. Member Update
	@RequestMapping(value = "/mupdate", method=RequestMethod.POST)
	public ModelAndView mupdate(HttpServletRequest request, 
							ModelAndView mv, MemberVO vo) throws IOException {
		
		
		// 2. Service
		mv.addObject("apple", vo);
		
		if ( service.update(vo) > 0 ) {
			// 수정성공 -> MyInfo 내정보 표시 , session에 보관중인 LoginName 변경
			request.getSession().setAttribute("LoginName", vo.getName());
			mv.addObject("message", " ~~ 정보 수정 성공 ~~");
			mv.setViewName("member/memberDetail");
		}else {
			// 수정실패 -> updateForm 으로
			mv.addObject("message", " ~~ 정보 수정 실패 -> 다시하세요 ~~");
			mv.setViewName("member/updateForm");
		}
		// 3. 결과 : view 처리
		return mv;
	} //mupdate
	
	//** 8. Member Delete 
	@RequestMapping(value = "/mdelete")
	public ModelAndView mdelete(HttpServletRequest request, ModelAndView mv, MemberVO vo, RedirectAttributes rttr) {
		// 1. 요청분석 & Service
		HttpSession session = request.getSession(false); 
		if ( session!=null && session.getAttribute("LoginID")!=null ) {
			// 삭제가능
			vo.setId((String)session.getAttribute("LoginID"));
			if ( service.delete(vo) > 0 ) {
				// 삭제성공 -> session 무효화 -> home.jsp
				rttr.addFlashAttribute("message", " ~~ 회원탈퇴 성공, 1개월 후 재가입 가능 ~~");
				session.invalidate();
			}else {
				// 삭제실패 -> 서버오류 -> home.jsp
				rttr.addFlashAttribute("message", " ~~ 회원 탈퇴 처리중 서버 문제발생 , 잠시후 다시 하세요 ~~");
			}
		}else {
			// 삭제 불가능 -> 로그인 정보 없음 -> home.jsp
			rttr.addFlashAttribute("message", " ~~ 회원 탈퇴를 처리할수 없습니다 : 로그인 정보 없음 ~~");
		}
		
		// 2. 결과 : view 처리
		mv.setViewName("redirect:home");
		return mv;
	} //mdelete
	
} //class
