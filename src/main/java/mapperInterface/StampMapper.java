package mapperInterface;

import java.util.List;

import vo.StampVO;

public interface StampMapper {
	
	List<StampVO> selectList(StampVO vo);
	List<StampVO> selectOne(StampVO vo);
	int insert(StampVO vo);
	int update(StampVO vo);
	int delete(StampVO vo);
	
}
