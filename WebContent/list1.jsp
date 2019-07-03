<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<%
	String pageStr = request.getParameter("page"); // 사용자 변경을 위해 사용

	int pageNum = 0; // 계속 변경할 수 는 없다. 사용자 변경으로 바꾸어야 한다.
	try { // ?page=1 을 할 필요 없게 만든다.
		pageNum = Integer.parseInt(pageStr); // 사용자 변경을 위해 사용
	} catch (NumberFormatException e) {
		pageNum = 1;
	}
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum * 10;
	startRow = endRow - 9;
	int total = 0;

	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		String sql2 = "select count(*) from article"; // id를 기준으로 order를 이용해 정렬을 한다.
		PreparedStatement stmt2 = con.prepareStatement(sql2);

		ResultSet rs2 = stmt2.executeQuery();

		if (rs2.next()) {
			total = rs2.getInt("count(*)");
		}

		String sql = "select * from article order by id desc" + "    limit ?, 10";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, startRow - 1);
		ResultSet rs = stmt.executeQuery();

		//		<div class="card" style="width:400px">
		// 		  <img class="card-img-top" src="img_avatar1.png" alt="Card image">
		// 		  <div class="card-body">
		// 		    <h4 class="card-title">John Doe</h4>
		// 		    <p class="card-text">Some example text.</p>
		// 		    <a href="#" class="btn btn-primary">See Profile</a>
		// 		  </div>
		//		</div>
		while (rs.next()) {
			String id = rs.getString("id"); // article에 있는 id, title .. id2 를 뽑아낸다.
			String title = rs.getString("title");
			String content = rs.getString("content");
			String hit = rs.getString("hit");
			String id2 = rs.getString("id2");
			// 절대 경로   http://localhost/JspBoard/view.jsp?id=1 
			// 상대 경로   view.jsp?id=1  
			out.println("<a href = 'view.jsp?id=" + id + "'>" + id + "/" + title + "/" + id2 + "</a><br>");
%>
<!-- 목록 화면 꾸미기 부트 스트랩 4 cards 사용-->

<div class="card" style="width: 400px">
	<div class="card-body">
		<h4 class="card-title"><%=title%></h4>
		<p class="card-text"><%=content%></p>
		<a href="view.jsp?id=<%=id%>" class="btn btn-primary"> <%=id%>
		</a>
	</div>
</div>
<%
	}

		// pagenation 시작

		int startPage = 0;
		startPage = (pageNum - 1) / 10 * 10 + 1;

		int endPage = 0;
		endPage = startPage + 9;

		int totalPage = 0; // 전체 페이지 수
		if (total % 10 == 0) { // 10, 20, 30, ...
			totalPage = total / 10;
		} else {
			totalPage = total / 10 + 1;
		}
		if (endPage > totalPage)
			endPage = totalPage;
		//		<ul class="pagination">
		//		  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
		//		  <li class="page-item"><a class="page-link" href="#">1</a></li>
		//		  <li class="page-item active"><a class="page-link" href="#">2</a></li>
		//		  <li class="page-item"><a class="page-link" href="#">3</a></li>
		//		  <li class="page-item"><a class="page-link" href="#">Next</a></li>
		//		</ul>
		out.println("<ul class=\"pagination\">");
		for (int i = startPage; i <= endPage; i++) {
%>
<!-- 번호 창 꾸미기? Pagination -->

<li class="page-item"><a class="page-link"
	href="list.jsp?page=<%=i%>"> <%=i%>
</a></li>

<%
	}
		out.println("</ul>");
		//
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>