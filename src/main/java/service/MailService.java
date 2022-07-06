package service;

import java.util.List;

import vo.MailVO;

public interface MailService {

	List<MailVO> aidBList(MailVO vo); //Ajax_id_BoardList
	
	List<MailVO> mailListR(MailVO vo); //selectList
	List<MailVO> mailListS(MailVO vo); //selectList
	MailVO selectOne(MailVO vo); //selectOne
	int countUp(MailVO vo);

	int insert(MailVO vo);
	int update(MailVO vo);
	int delete(MailVO vo);

} //class