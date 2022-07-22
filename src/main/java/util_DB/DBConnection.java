package util_DB;

import java.sql.Connection;
import java.sql.DriverManager;

//** DB 연결
//=> Connection 클래스가 DB 연결및 연결정보를 관리함
//   즉, Connection 객체를 생성해야함
public class DBConnection {

	// ** Connection 객체 생성 
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://web-database.cgkipf2gxisq.ap-northeast-2.rds.amazonaws.com:3306/my?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true&allowMultiQueries=true";
			System.out.println("** JDBC Connection 요기까지 성공 **");
			return DriverManager.getConnection(url, "mng", "3ng1214!") ;
		} catch (Exception e) {
			System.out.println("** JDBC Connection 실패 => "+e);
			return null;
		} //try
	} //getConnection
	
} //class
