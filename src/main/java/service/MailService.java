package service;

import java.util.List;

import vo.MailVO;

public interface MailService {
	
	List<MailVO> mailListRN(MailVO vo);
	List<MailVO> mailListR(MailVO vo); //selectList
	List<MailVO> mailListS(MailVO vo); //selectList
	MailVO selectOne(MailVO vo); //selectOne
	int countCheck(MailVO vo);

	int insert(MailVO vo);
	int update(MailVO vo);
	int delete(MailVO vo);

} //class