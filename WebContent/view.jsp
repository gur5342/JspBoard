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
		
		String sql2 = "update article set hit=hit + 1 where id = ?"; // 조회수를 상승시킨다.
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.executeUpdate();
		
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
	<h1><%=title %> / <%=num %></h1>
	<p><%=content %></p>
	<p><%=hit %></p>
	<p><%=id2 %></p>
	<button type= "button" onclick="location='update.jsp?id=<%=id%>'">수정</button> 
	
	<!--  onclick을 이용해 원하는 위치로 이동하게끔, button을 이용해 수정 버튼을 만든다.  -->
	
	<button type= "button" onclick= "del()">삭제</button>
<%
	}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>

<script>
	function del(){
		var isOk = confirm("삭제 하시겠습니까?");
		if(isOk){ // 삭제
			location = 'delete_proc.jsp?id=<%=id%>';
		}
}
</script>
