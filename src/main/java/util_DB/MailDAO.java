package util_DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import vo.MailVO;

// ** JDBC 처리
// => C R U D 

@Repository
public class MailDAO {
	private Connection cn = DBConnection.getConnection(); 
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	private String sql ;
	
	//받은+열람 못한 편지
	public List<MailVO> mailListRN(MailVO vo) {
		sql="select seq, date from mail where toId=? and ccheck=0 order by seq desc" ;
		List<MailVO> list = new ArrayList<MailVO>();
		try {
			pst = cn.prepareStatement(sql);
			pst.setString(1, vo.getToId());
			st = cn.createStatement();
			rs = st.executeQuery(sql);
			// 출력 record 가 있는지 확인
			if (rs.next()) {
				// ResultSet 의 Data -> list 에 담기
				do {
					MailVO vo1 = new MailVO();
					vo1.setSeq(rs.getInt(1));
					vo1.setDate(rs.getString(2));
					list.add(vo1);
				}while(rs.next());
			}else {
				System.out.println("** 출력할 자료가 1개도 없습니다. **");
				list = null;
			}
		} catch (Exception e) {
			System.out.println("** selectList Exception => "+e.toString());
			list = null;
		}
		return list;
	} 
	
	//받은+열람한 편지
	public List<MailVO> mailListR(MailVO vo) {
		sql="select * from mail where toId=? and ccheck=1 order by seq desc" ;
		List<MailVO> list = new ArrayList<MailVO>();
		try {
			pst = cn.prepareStatement(sql);
			pst.setString(1, vo.getToId());
			st = cn.createStatement();
			rs = st.executeQuery(sql);
			// 출력 record 가 있는지 확인
			if (rs.next()) {
				// ResultSet 의 Data -> list 에 담기
				do {
					MailVO vo1 = new MailVO();
					vo1.setSeq(rs.getInt(1));
					vo1.setToId(rs.getString(2));
					vo1.setFromId(rs.getString(3));
					vo1.setMsg(rs.getString(4));
					vo1.setCcheck(rs.getInt(5));
					vo1.setDate(rs.getString(6));
					list.add(vo1);
				}while(rs.next());
			}else {
				System.out.println("** 출력할 자료가 1개도 없습니다. **");
				list = null;
			}
		} catch (Exception e) {
			System.out.println("** selectList Exception => "+e.toString());
			list = null;
		}
		return list;
	} 
	
	//보낸 편지
	public List<MailVO> mailListS(MailVO vo) {
		sql="select * from mail where fromId=? order by seq desc" ;
		List<MailVO> list = new ArrayList<MailVO>();
		try {
			pst = cn.prepareStatement(sql);
			pst.setString(1, vo.getFromId());
			st = cn.createStatement();
			rs = st.executeQuery(sql);
			// 출력 record 가 있는지 확인
			if (rs.next()) {
				// ResultSet 의 Data -> list 에 담기
				do {
					MailVO vo2 = new MailVO();
					vo2.setSeq(rs.getInt(1));
					vo2.setToId(rs.getString(2));
					vo2.setFromId(rs.getString(3));
					vo2.setMsg(rs.getString(4));
					vo2.setCcheck(rs.getInt(5));
					vo2.setDate(rs.getString(6));
					vo2.setToName(rs.getString(7));
					list.add(vo2);
				}while(rs.next());
			}else {
				System.out.println("** 출력할 자료가 1개도 없습니다. **");
				list = null;
			}
		} catch (Exception e) {
			System.out.println("** selectList Exception => "+e.toString());
			list = null;
		}
		return list;
	} //selectList
	
	
	public MailVO selectOne(MailVO vo) {
		sql = "select * from mail where seq=?";
		try {
			pst = cn.prepareStatement(sql);
			pst.setInt(1, vo.getSeq());
			rs = pst.executeQuery();
			if (rs.next()) {
				vo.setSeq(rs.getInt(1));
				vo.setToId(rs.getString(2));
				vo.setFromId(rs.getString(3));
				vo.setMsg(rs.getString(4));
				vo.setCcheck(rs.getInt(5));
				vo.setDate(rs.getString(6));
			}else {
				System.out.println("** 글번호에 해당하는 글이 없습니다 **");
				vo=null;
			}
		} catch (Exception e) {
			System.out.println("** selectOne Exception => "+e.toString());
			vo=null;
		}
		return vo;
	} //selectOne

	// 
	public int countCheck(MailVO vo) {
		// 조회수 증가 Sql 처리
		sql="update mail set ccheck=1 where seq=(select min(seq) from (select seq from mail where toId=? and ccheck=0) tmp)" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getToId());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** countUp Exception => "+e.toString());
			return 0;
		}
	} //countUp
	
	public int insert(MailVO vo) {
		sql = "insert into mail(toId,fromId,msg,ccheck,date,toName) values(?,?,?,0,default,(select name from member where id=?))" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getToId());
			pst.setString(2, vo.getFromId());
			pst.setString(3, vo.getMsg());
			pst.setString(4, vo.getToId());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** Board insert Exception => "+e.toString());
			return 0;
		}
	} //insert
	
	public int update(MailVO vo) {
		sql = "update mail set msg=? where seq=?" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getMsg());
			pst.setInt(2, vo.getSeq());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** Board update Exception => "+e.toString());
			return 0;
		}
	} //update
	
	public int delete(MailVO vo) {
		sql = "delete from mail where seq=?" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setInt(1, vo.getSeq());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** Board delete Exception => "+e.toString());
			return 0;
		}
	} //delete
	
	public int deleteMailAllS(MailVO vo) {
		sql = "update mail set fromId = replace(fromId, ?, null)" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getFromId());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** Board delete Exception => "+e.toString());
			return 0;
		}
	} //deleteMailAll
	
	public int deleteMailAllR(MailVO vo) {
		sql = "update mail set toId = replace(toId, ?, null)" ;
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getToId());
			return pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("** Board delete Exception => "+e.toString());
			return 0;
		}
	} //deleteMailAll
	
	
} //class
