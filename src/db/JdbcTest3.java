package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBManager;

public class JdbcTest3 {
	public static void main(String[] args) {
		try {
			DBManager db = DBManager.getInstance();
			Connection con = db.open();
			
			// 3. Query 실행 준비
			String sql = "insert into test (id, name) values ";
			sql += "    (null, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, "python");
			
			// 4. Query 실행
			stmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
