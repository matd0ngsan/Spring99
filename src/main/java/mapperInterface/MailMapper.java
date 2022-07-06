package mapperInterface;

import java.util.List;

import vo.MailVO;

public interface MailMapper {
	
	List<MailVO> aidBList(MailVO vo); //Ajax_id_BoardList
	
	List<MailVO> mailListR(MailVO vo);
	List<MailVO> mailListS(MailVO vo);
	MailVO selectOne(MailVO vo);
	int countUp(MailVO vo);
	int insert(MailVO vo);
	int update(MailVO vo);
	int delete(MailVO vo);

} //interface
