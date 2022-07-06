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
		
		if ( vo!=null )
			mv.addObject("banana", service.mailListR(vo));
			
		else
			mv.addObject("message", "~~ vo null: 개인정보 읽어오기 실패 !! ~~");

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
			mv.addObject("message", "~~ vo null: 개인정보 읽어오기 실패 !! ~~");

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
				rttr.addFlashAttribute("message", "새글 등록 성공");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 성공");
			} else {
				mv.addObject("message", "새글등록 실패 !! 다시 하세요");
				mv.setViewName("redirect:home");
				System.out.println("새글 등록 실패");
			}
		} else {
			
		}
			
		return mv;
		
	} //mpost

	//////////////////////////////////////////////////
	
	//** Ajax_id_BoardList
	@RequestMapping(value = "/aidblist", method=RequestMethod.GET)
	public ModelAndView aidblist(ModelAndView mv, MailVO vo) {
		mv.addObject("banana", service.aidBList(vo));
		mv.setViewName("axTest/axBoardList");
		return mv;
	} //aidblist
	
	
	//** Ajax_BoardList
	@RequestMapping(value = "/axblist", method=RequestMethod.GET)
	public ModelAndView axblist(ModelAndView mv, MailVO vo) {
		mv.addObject("banana", service.mailListR(vo));
		mv.setViewName("axTest/axBoardList");
		return mv;
	} //axblist
	
	
	//** 1. Board List
	@RequestMapping(value = "/blist", method=RequestMethod.GET)
	public ModelAndView blist(ModelAndView mv, MailVO vo) {
		// 1. 요청분석 & Service
		mv.addObject("banana", service.mailListR(vo));
		// 2. 결과 : view 처리
		mv.setViewName("board/boardList");
		return mv;
	} //blist

	//** 2. Board Detail
	@RequestMapping(value = "/bdetail", method=RequestMethod.GET)
	public ModelAndView bdetail(HttpServletRequest request, HttpServletResponse response,
								RedirectAttributes rttr, ModelAndView mv, MailVO vo) {
		// 1. 요청분석 & Service
		// => 조회수 증가 
		// => Cookie 를 이용해서 24시간 동안 동일한 글은 1회만 증가 가능 하도록 한다.
		//    단, 로그인 여부는 무관하게 상세글 보기가 가능 하므로 urser의 id 는 따지지 않는다.
		// => 크롬의 개발자 모드에서 Cookie 값 확인하면서 Test
		
		// 1.1) 쿠기 생성
		Cookie viewCookie = null;
		Cookie[] cookies = request.getCookies();
		
		// 1.2) 현재글의 조회수 증가 반영 확인
		// => 없을때만 증가
		if ( cookies!=null ) {
			for ( Cookie c:cookies ) {
				if (c.getName().equals("|"+vo.getSeq()+"|")) {   //  쿠키의 보관 값 -> (seq)
					// 일치하는 글번호 존재 -> 조회수 증가 X 
					viewCookie = c;
					break;
				}
			} //for
		} //if
		
		// => 그러므로 viewCookie 가 null 인경우에만  
		//    Cookie 보관, 조회수 증가 처리
		if ( viewCookie==null ) {
			// 조회수증가 처리 성공후 Cookie 처리
			if ( service.countUp(vo) > 0 ) {
				Cookie newCookie = new Cookie("|"+vo.getSeq()+"|","view") ;
				newCookie.setMaxAge(24*60*60);  // MaxAge 24시간 지정 -> 단위 초
				response.addCookie(newCookie);
			}else {
				System.out.println("** 조회수 증가가 정상적으로 처리되지 않음 **");
				mv.addObject("message", "~~ 조회수 증가가 정상적으로 처리되지 않음 ~~");
			}
		} // if
		
		vo=service.selectOne(vo);
		// => Mybatis 적용시에는 중간객체를 거쳐 전달되기때문에 vo에 결과를 담아야함.
		if ( vo != null) {
			// Detail 출력
			mv.addObject("apple", vo);
			mv.setViewName("board/boardDetail");
		}else {
			// 다시 List 로 -> bList 서블릿 으로
			rttr.addFlashAttribute("message", "~~ 글번호에 해당하는 글이 없습니다 ~~");
			mv.setViewName("redirect:blist");
		}
				
		// 2. 결과 : view 처리
		return mv;
	} //bdetail
	
	//** 3. Board Insert
	@RequestMapping(value = "/binsertf", method=RequestMethod.GET)
	public ModelAndView binsertf(ModelAndView mv) {
		mv.setViewName("board/insertForm");
		return mv;
	} //binsertf
	
	@RequestMapping(value = "/binsert", method=RequestMethod.POST)
	public ModelAndView binsert(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		// 1. 요청분석 & Service
		// => 글등록 성공: boardList , 실패: 다시 글등록 insertForm.jsp 
		if ( service.insert(vo) > 0 ) {
			// 성공
			rttr.addFlashAttribute("message", "~~ 새글 등록 성공 ~~");
			mv.setViewName("redirect:blist");
		}else {
			// 실패
			mv.addObject("message", "~~ 새글등록 실패 !! 다시 하세요 ~~");
			mv.setViewName("board/insertForm");
		}
		// 2. 결과 : view 처리
		return mv;
	} //binsert
	
	//** 3. Board Update
	@RequestMapping(value = "/bupdatef", method=RequestMethod.GET)
	public ModelAndView bupdatef(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		// 1. 요청분석 & Service
		
		vo=service.selectOne(vo);
		// => Mybatis 적용시에는 중간객체를 거쳐 전달되기때문에 vo에 결과를 담아야함.
		if ( vo != null ) {
			// 출력 -> updateForm.jsp
			mv.addObject("apple", vo);
			mv.setViewName("board/updateForm");
		} else  {
			// 메시지 보관, boardList.jsp 출력 (서블릿으로)
			rttr.addFlashAttribute("message", "~~ 글번호의 자료를 읽어오는데 실패 했습니다 ~~");
			mv.setViewName("redirect:blist");
		}
		// 2. 결과 : view 처리
		return mv;
	} //bupdatef
	
	@RequestMapping(value = "/bupdate", method=RequestMethod.POST)
	public ModelAndView bupdate(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		// 1. 요청분석 & Service
		if ( service.update(vo) > 0 ) {
			// 수정성공 -> 메시지 보관, boardList.jsp 출력 (서블릿으로) 
			rttr.addFlashAttribute("message", "~~ 글수정 성공 ~~");
			mv.setViewName("redirect:blist");
		} else  {
			// 수정실패 updateForm.jsp -> (서블릿으로) 
			rttr.addFlashAttribute("message", "~~ 글수정 실패 !! 다시 하세요 ~~");
			mv.setViewName("redirect:bupdatef?seq="+vo.getSeq());
		}
		// 2. 결과 : view 처리
		return mv;
	} //bupdate
	
	//** 4. Board Delete
	@RequestMapping(value = "/bdelete", method=RequestMethod.GET)
	public ModelAndView bdelete(ModelAndView mv, MailVO vo, RedirectAttributes rttr) {
		// 1. 요청분석 & Service
		if ( service.delete(vo) > 0 ) {
			// 삭제성공 -> 메시지 보관, boardList.jsp 출력 (서블릿으로) 
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 ~~");
			mv.setViewName("redirect:blist");
		}else {
			// 삭제실패 boardDetail.jsp -> (서블릿으로) 
			rttr.addFlashAttribute("message", "~~ 글삭제 실패 !! 다시 하세요 ~~");
			mv.setViewName("redirect:bdetail?seq="+vo.getSeq());
		}
		// 2. 결과 : view 처리
		return mv;
	} //bdelete
	
} //class
