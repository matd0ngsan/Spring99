package util_DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.springframework.stereotype.Repository;

import vo.SurveyVO;

@Repository
public class SurveyDAO {
	
	private Connection cn = DBConnection.getConnection(); 
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	private String sql;
	
	public int insert(SurveyVO vo) {
		
		sql = "insert into stamp(id, formtext, date) values(?, ?, default)" ;
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, vo.getId());
			pst.setString(2, vo.getFormtext());
			return pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("** Board insert Exception => "+e.toString());
			return 0;
		}
	}

}
