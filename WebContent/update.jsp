<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = request.getParameter("id");
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		String sql = "select * from article where id = ?"; // id를 기준으로 order를 이용해 정렬을 한다.
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			String num = rs.getString("id"); // article에 있는 id, title .. id2 를 뽑아낸다.
			String title = rs.getString("title");
			String content = rs.getString("content");
			String hit = rs.getString("hit");
			String id2 = rs.getString("id2");
%>

	<form method = "post" action = "update_proc.jsp">
		제목 : <input type = "text" name = "title" value= "<%=title%>"><br> <!--  제목을 수정한다. -->
		내용 : <textarea name="content" > <%=content %></textarea><br> <!--  내용을 수정한다. -->
		<input type = "hidden" name="id" value = "<%=id %>">
		<input type = "submit" value = "수정완료"> 
	</form>
	
<%
	}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>