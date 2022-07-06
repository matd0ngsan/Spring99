package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.MailMapper;
import vo.MailVO;

@Service
public class MailServiceImpl implements MailService {
	
	@Autowired
	MailMapper mapper;
	// BoardDAO dao; 
	// => Mybatis 로 교체 (interface 방식)
	// => interface BoardMapper 를 통해서 
	//    BoardMapper.xml 의 SQL 구문 접근  
	
	@Override //Ajax_id_BoardList
	public List<MailVO> aidBList(MailVO vo) {
		return mapper.aidBList(vo);
	}
	
	@Override
	public List<MailVO> mailListR(MailVO vo) {
		return mapper.mailListR(vo);
	} //selectList
	
	@Override
	public List<MailVO> mailListS(MailVO vo) {
		return mapper.mailListS(vo);
	} //selectList
	
	@Override
	public MailVO selectOne(MailVO vo) {
		return mapper.selectOne(vo);
	} //selectOne
	
	@Override
	public int countUp(MailVO vo) {
		return mapper.countUp(vo);
	}
	
	@Override
	public int insert(MailVO vo) {
		return mapper.insert(vo);
	}
	@Override
	public int update(MailVO vo) {
		return mapper.update(vo);
	}
	@Override
	public int delete(MailVO vo) {
		return mapper.delete(vo);
	}
	
} //class
