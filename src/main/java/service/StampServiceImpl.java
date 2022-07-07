package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.StampMapper;
import vo.StampVO;

@Service
public class StampServiceImpl implements StampService {
	
	@Autowired 
	StampMapper mapper;
	
	@Override
	public List<StampVO> selectList(StampVO vo) {
		return mapper.selectList(vo);
	}
	
	@Override
	public List<StampVO> selectOne(StampVO vo) {
		return mapper.selectOne(vo);
	}
	
	@Override
	public int insert(StampVO vo) {
		return mapper.insert(vo);
	}
	
	@Override
	public int update(StampVO vo) {
		return mapper.update(vo);
	}
	
	@Override
	public int delete(StampVO vo) {
		return mapper.delete(vo);
	}
}
