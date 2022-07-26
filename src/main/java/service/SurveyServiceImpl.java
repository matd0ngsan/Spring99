package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.SurveyMapper;
import vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService{
	
	@Autowired 
	SurveyMapper mapper;
	
	@Override
	public int insert(SurveyVO vo) {
		return mapper.insert(vo);
	}
}
