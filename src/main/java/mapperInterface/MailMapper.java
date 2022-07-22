package mapperInterface;

import java.util.List;

import vo.MailVO;

public interface MailMapper {
	
	List<MailVO> mailListRN(MailVO vo);
	List<MailVO> mailListR(MailVO vo);
	List<MailVO> mailListS(MailVO vo);
	MailVO selectOne(MailVO vo);
	int countCheck(MailVO vo);
	int insert(MailVO vo);
	int update(MailVO vo);
	int delete(MailVO vo);
	int deleteMailAllS(MailVO vo);
	int deleteMailAllR(MailVO vo);

} //interface
