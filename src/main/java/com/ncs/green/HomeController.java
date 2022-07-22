package com.ncs.green;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.StampService;
import vo.StampVO;
import service.MailService;
import vo.MailVO;
import service.MemberService;
import vo.MemberVO;

@Controller
public class HomeController {
	@Autowired
	StampService service1;
	@Autowired
	MailService service2 ;
	@Autowired
	MemberService service3;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	} //home
	
	//** AjaxTest mainForm
	@RequestMapping(value = "/axtest", method=RequestMethod.GET)
	public ModelAndView axtest(ModelAndView mv) {
		mv.setViewName("axTest/axTestForm");
		return mv;
	} //axtest
	
	@RequestMapping(value = "/memberDelete", method=RequestMethod.GET)
	public ModelAndView memberDelete(ModelAndView mv) {
		
		mv.setViewName("member/memberDelete");
		return mv;
	}
	
	@RequestMapping(value = "/goodbye", method=RequestMethod.GET)
	public ModelAndView goodbye(HttpServletRequest request, ModelAndView mv, StampVO vo1, MailVO vo2, MemberVO vo3, RedirectAttributes rttr) {
		
		//아이디 받아서
		HttpSession session = request.getSession(false);
		
		vo1.setId((String)session.getAttribute("LoginID"));
		vo2.setFromId((String)session.getAttribute("LoginID"));
		vo2.setToId((String)session.getAttribute("LoginID"));
		vo3.setId((String)session.getAttribute("LoginID"));
		
		if (service1.deleteStampAll(vo1) > 0) {
			logger.info("도장판 삭제");
		} else {
			logger.info("삭제할 도장판 없음");
		}
		
		if (service2.deleteMailAllS(vo2) > 0) {
			logger.info("보낸 편지 삭제");
		} else {
			logger.info("삭제할 편지 없음");
		}
		
		if (service2.deleteMailAllR(vo2) > 0) {
			logger.info("받은 편지 삭제");
		} else {
			logger.info("삭제할 편지 없음");
		}
		
		//멤버 탈퇴
		if ( service3.delete(vo3) > 0 ) {
			request.getSession().invalidate(); 
			rttr.addFlashAttribute("message", " 탈퇴 성공 ");
			
		}else {
			rttr.addFlashAttribute("message", " 탈퇴 실패 ");
		}
		
		mv.setViewName("redirect:home");
		return mv;
		
	}
	
	//memberdelete
} //class
