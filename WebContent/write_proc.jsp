<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("euc-kr"); // 한글이 깨져서 나오는 것을 방지, 한글을 사용할 때 사용 
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = (String) session.getAttribute("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		String sql = "insert into article values (null, ?, ?, 0, ?)"; // ? 개수를 중심으로 셈을 한다.
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setString(2, content);
		stmt.setString(3, id);	
		int result = stmt.executeUpdate(); // 성공이면 1 이상, 실패면 0
		if(result > 0){ // member에 있는 것이 article에 들어간다.
			out.println("작성완료");
		}
		else{
			out.println("작성실패");
		}
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}	
%>