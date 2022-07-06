package com.ncs.green;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.StampService;
import vo.StampVO;

@Controller
public class StampController {
	
	@Autowired 
	StampService service;
	
	@RequestMapping(value = "/stamplist", method=RequestMethod.GET)
	public ModelAndView stamplist(HttpServletRequest request, ModelAndView mv, StampVO vo) {
		
		HttpSession session = request.getSession(false);
		vo.setId((String)session.getAttribute("LoginID"));
		
		if ( vo!=null )
			mv.addObject("cherry", service.selectList(vo));
		else
			mv.addObject("message", "~~ vo null: 개인정보 읽어오기 실패 !! ~~");
		
		mv.setViewName("stamp/stamp");
		return mv;
	}
	
	@RequestMapping(value = "/stampselect", method=RequestMethod.GET)
	public ModelAndView stampselect(HttpServletRequest request, RedirectAttributes rttr, ModelAndView mv, StampVO vo) {
		
		vo=service.selectOne(vo);
		if ( vo != null) {
			mv.addObject("cherry", vo);
			mv.setViewName("stamp/stamp");
			
		}else {
			rttr.addFlashAttribute("message", "~~ 글번호에 해당하는 글이 없습니다 ~~");
			mv.setViewName("redirect:home");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/sinsert", method=RequestMethod.POST)
	public ModelAndView stampinsert(HttpServletRequest request, ModelAndView mv, StampVO vo, RedirectAttributes rttr) {
		
		HttpSession session = request.getSession(false);
		System.out.println("***** vo => "+vo);
		
		if (session!=null && session.getAttribute("LoginID")!=null) {
			
			if ( service.insert(vo) > 0 ) {
				rttr.addFlashAttribute("message", "~~ 새글 등록 성공 ~~");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 성공");
				
			}else {
				mv.addObject("message", "~~ 새글등록 실패 !! 다시 하세요 ~~");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 실패");
				
			}
			
		}
		
		return mv;
		
	}
	
	@RequestMapping(value = "/supdate", method=RequestMethod.GET)
	public ModelAndView stampupdate(ModelAndView mv, StampVO vo, RedirectAttributes rttr) {
		
		if ( service.update(vo) > 0 ) {
			rttr.addFlashAttribute("message", "~~ 글수정 성공 ~~");
			mv.setViewName("redirect:home");
		} else  {
			rttr.addFlashAttribute("message", "~~ 글수정 실패 !! 다시 하세요 ~~");
			mv.setViewName("redirect:home");
			
		}
		return mv;
		
	}
	
	@RequestMapping(value = "/sdelete", method=RequestMethod.GET)
	public  ModelAndView stampdelete(ModelAndView mv, StampVO vo, RedirectAttributes rttr) {
		
		if ( service.delete(vo) > 0 ) {
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 ~~");
			mv.setViewName("redirect:home");
			
		}else {
			rttr.addFlashAttribute("message", "~~ 글삭제 실패 !! 다시 하세요 ~~");
			mv.setViewName("redirect:home");
			
		}
		return mv;
		
	}
}