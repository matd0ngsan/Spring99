package util_DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import vo.MailVO;
import vo.StampVO;

@Repository
public class StampDAO {
	
	private Connection cn = DBConnection.getConnection(); 
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	private String sql;
	
	public List<StampVO> selectList(StampVO vo) {
		
		sql= "select * from stamp where id=? AND cnt=10 order by seq desc" ;
		List<StampVO> list = new ArrayList<StampVO>();
		
		try {
			pst = cn.prepareStatement(sql);
			pst.setString(1, vo.getId());
			st = cn.createStatement();
			rs = st.executeQuery(sql);
			
			if(rs.next()) {
				do {
					StampVO vo1 = new StampVO();
					vo1.setSeq(rs.getInt(1));
					vo1.setId(rs.getString(2));
					vo1.setTitle(rs.getString(3));
					vo1.setCnt(rs.getInt(4));
					list.add(vo1);
					
				} while(rs.next());
			} else {
				System.out.println("** 출력할 자료가 1개도 없습니다. **");
				list = null;
			}
		} catch (Exception e) {
			System.out.println("** stampList Exception => "+e.toString());
			list = null;
		}
		
		return list;
	}//selectList
	
	public List<StampVO> selectOne(StampVO vo) {
		sql = "select * from stamp where id=? AND cnt<10";
		List<StampVO> list = new ArrayList<StampVO>();
		
		try {
			
			pst = cn.prepareStatement(sql);
			pst.setString(1, vo.getId());
			st = cn.createStatement();
			rs = st.executeQuery(sql);
			
			if (rs.next()) {
				do {
					StampVO vo2 = new StampVO();
					vo2.setSeq(rs.getInt(1));
					vo2.setId(rs.getString(2));
					vo2.setTitle(rs.getString(3));
					vo2.setCnt(rs.getInt(4));
					list.add(vo2);
					
				} while(rs.next());
			} else {
				System.out.println("** 현재 진행중인 도전이 없습니다 **");
				vo=null;
			}
			
		} catch (Exception e) {
			System.out.println("** stampOne Exception => "+e.toString());
			vo=null;
		}
		
		return list;
	}//selectOne
	
	public int insert(StampVO vo) {
		sql = "insert into stamp(id, title, cnt) values(?, ?, default)" ;
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getId());
			pst.setString(2, vo.getTitle());
			return pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("** Board insert Exception => "+e.toString());
			return 0;
		}
	}//insert
	
	public int update(StampVO vo) {
		sql="update stamp set cnt=cnt+1 where seq=?" ;
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setInt(1, vo.getSeq());
			pst.setString(2, vo.getId());
			return pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("** Board update Exception => "+e.toString());
			return 0;
		}
	}//update
	
	public int delete(StampVO vo) {
		sql = "delete from stamp where seq=?" ;
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setInt(1, vo.getSeq());
			return pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("** Board delete Exception => "+e.toString());
			return 0;
		}
		
	}//delete
	
	public int deleteStampAll(StampVO vo) {
		sql = "delete from stamp where id=?" ;
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getId());
			return pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("** Board delete Exception => "+e.toString());
			return 0;
		}
		
	}//deleteStampAll
}
