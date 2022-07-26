package com.ncs.green;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.SurveyService;
import vo.SurveyVO;

@Controller
public class SurveyController {
	
	@Autowired 
	SurveyService service;
	
	@RequestMapping(value = "/srpostf", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView srpostf(ModelAndView mv) {
		mv.setViewName("member/surveyform");
		return mv;
	}
	
	@RequestMapping(value = "/srpost", method = RequestMethod.POST)
	public ModelAndView srpost(HttpServletRequest request, ModelAndView mv, SurveyVO vo, RedirectAttributes rttr) {
		
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
	}
}
