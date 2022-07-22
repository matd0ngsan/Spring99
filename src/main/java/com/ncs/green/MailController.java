package com.ncs.green;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MailService;
import vo.MailVO;

@Controller
public class MailController {
	@Autowired
	MailService service ;
	// BoardService service = new BoardServiceImpl() ;
	
	//** 1. mail List R
	@RequestMapping(value = "/mlistR", method=RequestMethod.GET)
	public ModelAndView mlistR(HttpServletRequest request, ModelAndView mv, MailVO vo) {
		// 1. 요청분석 & Service
		HttpSession session = request.getSession(false);
		
		vo.setToId((String)session.getAttribute("LoginID"));
		
		if ( vo!=null ) {
			mv.addObject("banana", service.mailListR(vo));
			mv.addObject("banana2", service.mailListRN(vo));
		} else
			mv.addObject("message", " 자료 없음 ");

		mv.setViewName("stamp/mailListR");
		return mv;
	} //mlistR
	
	//** 2. mail List S
	@RequestMapping(value = "/mlistS", method=RequestMethod.GET)
	public ModelAndView mlistS(HttpServletRequest request, ModelAndView mv, MailVO vo) {
		// 1. 요청분석 & Service
		HttpSession session = request.getSession(false);
		
		vo.setFromId((String)session.getAttribute("LoginID"));
		
		if ( vo!=null ) 
			mv.addObject("banana", service.mailListS(vo));
		else 
			mv.addObject("message", " 자료 없음 ");

		mv.setViewName("stamp/mailListS");
		return mv;
	} //mlistR
	
	//** 3. mail post
	
	@RequestMapping(value = "/mpostf", method=RequestMethod.GET)
	public ModelAndView mpostf(ModelAndView mv) {
		
		mv.setViewName("stamp/mailPost");
		return mv;
	} 
	
	@RequestMapping(value = "/mpost", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView mpost(HttpServletRequest request, ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		
		HttpSession session = request.getSession(false);
		System.out.println("***** vo => "+vo);
		
		if (session!=null && session.getAttribute("LoginID")!=null) {
			if ( service.insert(vo) > 0 ) {
				rttr.addFlashAttribute("message", " 등록 성공 ");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 성공");
			} else {
				mv.addObject("message", " 등록 실패 ");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 실패");
			}
		} else {
			
		}
			
		return mv;
		
	} //mpost
	
	
	@RequestMapping(value = "/ccheck", method=RequestMethod.GET)
	public ModelAndView ccheck(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		
		if ( service.countCheck(vo) > 0 ) {
			mv.setViewName("redirect:home");
		} else  {
			rttr.addFlashAttribute("message", " 오류 발생 ");
			mv.setViewName("redirect:home");
		}
		
		return mv;
	} 
	//ccheck
	
	@RequestMapping(value = "/mdelete", method=RequestMethod.GET)
	public  ModelAndView mdelete(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		
		if ( service.delete(vo) > 0 ) {
			rttr.addFlashAttribute("message", " 삭제 성공 ");
			mv.setViewName("redirect:home");
			
		}else {
			rttr.addFlashAttribute("message", " 삭제 실패 ");
			mv.setViewName("redirect:home");
			
		}
		return mv;
		
	}//mdelete
	
	
	@RequestMapping(value = "/gohome", method=RequestMethod.GET)
	public ModelAndView gohome(HttpServletRequest request, ModelAndView mv, MailVO vo, RedirectAttributes rttr) {

		HttpSession session = request.getSession(false);
		
		vo.setToId((String)session.getAttribute("LoginID"));
		
		if ( service.countCheck(vo) > 0 ) {
			rttr.addFlashAttribute("message", " 새 메시지 열람 가능 ");
			mv.setViewName("redirect:home");
			
		} else {
			mv.setViewName("redirect:home");
		}
		
		return mv;
	} //gohome
	

	//////////////////////////////////////////////////
	
} //class
