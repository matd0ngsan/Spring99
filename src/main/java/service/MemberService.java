package service;

import java.util.List;

import vo.MemberVO;

public interface MemberService {

	List<MemberVO> selectList();

	MemberVO selectOne(MemberVO vo);

	int insert(MemberVO vo);

	int update(MemberVO vo);

	int delete(MemberVO vo);

} //class