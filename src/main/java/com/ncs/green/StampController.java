package com.ncs.green;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.StampService;
import vo.StampVO;

@Controller
public class StampController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired 
	StampService service;
	
	@RequestMapping(value = "/slist", method=RequestMethod.GET)
	public ModelAndView slist(HttpServletRequest request, ModelAndView mv, StampVO vo) {
		
		HttpSession session = request.getSession(false);
		vo.setId((String)session.getAttribute("LoginID"));
		
		if ( vo!=null )
			mv.addObject("cherry", service.selectList(vo));
		else
			mv.addObject("message", " 자료 없음 ");
		
		mv.setViewName("stamp/stampList");
		return mv;
	}
	
	@RequestMapping(value = "/sselect", method=RequestMethod.GET)
	public ModelAndView sselect(HttpServletRequest request, ModelAndView mv, StampVO vo) {
		
		HttpSession session = request.getSession(false);
		vo.setId((String)session.getAttribute("LoginID"));
		
		if ( vo != null) {
			mv.addObject("cherry", service.selectOngoing(vo));
			
		}else {
			mv.addObject("message", " 자료 없음 ");
		}
		
		mv.setViewName("stamp/stampOne");
		return mv;
	}
	
	@RequestMapping(value = "/sinsert", method=RequestMethod.POST)
	public ModelAndView sinsert(HttpServletRequest request, ModelAndView mv, StampVO vo, RedirectAttributes rttr) throws IOException {
		
		HttpSession session = request.getSession(false);
		System.out.println("***** vo => "+vo);
		
		if (session!=null && session.getAttribute("LoginID")!=null) {
			
			String realPath = request.getRealPath("/");
			System.out.println("** realPath => "+realPath);
			// realPath : /usr/local/tomcat9/webapps/stamp/
			
			realPath = "/usr/local/tomcat9/webapps/resources/upimg/";
			
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			
			String file1 = "O.gif"; 
			String file3 = "X.png"; 
			
			MultipartFile upfilefO = vo.getUpfilefO();
			if ( upfilefO !=null && !upfilefO.isEmpty() ) {
				
				UUID uuid1 = UUID.randomUUID();
				String uploadFileName1 = uuid1.toString() + System.currentTimeMillis() + (int)(Math.random()*1000000);
				
				file1 = realPath + uploadFileName1; // 경로완성
				upfilefO.transferTo(new File(file1)); // Image저장
				
				//file2 = "http://3.37.115.214:8080/resources/upimg/" + uploadFileName1;
				vo.setUpfileO(uploadFileName1);
			} else vo.setUpfileO(file1);
			
			MultipartFile upfilefX = vo.getUpfilefX();
			if ( upfilefX !=null && !upfilefX.isEmpty() ) {
				
				UUID uuid3 = UUID.randomUUID();
				String uploadFileName3 = uuid3.toString() + System.currentTimeMillis() + (int)(Math.random()*1000000);
				
				file3 = realPath + uploadFileName3; // 경로완성
				upfilefX.transferTo(new File(file3)); // Image저장
				
				//file4 = "http://3.37.115.214:8080/resources/upimg/" + uploadFileName3;
			vo.setUpfileX(uploadFileName3);
			} else vo.setUpfileX(file3);
			
			if ( service.insert(vo) > 0 ) {
				rttr.addFlashAttribute("message", " 등록 성공 ");
				mv.setViewName("redirect:home");
				System.out.println(" 등록 성공 ");
				
			}else {
				mv.addObject("message", " 등록 실패 ");
				mv.setViewName("redirect:home");
				System.out.println(" 등록 실패 ");
			}
		}
		return mv;
	}
	
	@RequestMapping(value = "/supdate", method=RequestMethod.GET)
	public ModelAndView supdate(ModelAndView mv, StampVO vo, RedirectAttributes rttr) {
				
		if ( service.update(vo) > 0 ) {
			mv.setViewName("stamp/stampCnt");
		} else  {
			rttr.addFlashAttribute("message", " 수정 성공 ");
			mv.setViewName("redirect:home");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/sdelete", method=RequestMethod.GET)
	public  ModelAndView sdelete(ModelAndView mv, StampVO vo, RedirectAttributes rttr) {
		
		vo = service.selectOne(vo);
		String fileO = vo.getUpfileO();
		String fileX = vo.getUpfileX();
		
		String filePath = "/usr/local/tomcat9/webapps/resources/upimg/";
		
		if (!(fileO.equals("O.gif"))) {
			String fileOPath = filePath + fileO;
			File deleteFileO = new File(fileOPath);
			deleteFileO.delete();
			
		}
		
		if (!(fileX.equals("X.png"))) {
			String fileXPath = filePath + fileX;
			File deleteFileX = new File(fileXPath);
			deleteFileX.delete();
		}
		
		if ( service.delete(vo) > 0 ) {
			rttr.addFlashAttribute("message", " 삭제 성공 ");
			mv.setViewName("redirect:home");
			
		}else {
			rttr.addFlashAttribute("message", " 삭제 실패 ");
			mv.setViewName("redirect:home");
			
		}
		return mv;
		
	}
}
