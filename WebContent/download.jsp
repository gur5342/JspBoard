<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String fileName = "test.txt";  /// 1. 111.jpg를 화면에 띄우고 싶다면 
	String filePath = "c:/dev/" + fileName;
	InputStream is = null;
	OutputStream os = null;
	try {
		response.setContentType("application/octet-stream"); // 2. image/jpeg로 바꾸고
		response.setHeader("Content-Disposition", "attatchment; filename=" + fileName);  // 3. attachment를 삭제한다.

		/* 기존에 만들어져 있는 out 객체 초기화 */
		out.clear();
		out = pageContext.pushBody();
		byte[] b = new byte[1024];
		is = new FileInputStream(filePath);
		os = response.getOutputStream();

		int data = 0;
		while ((data = is.read(b)) != -1) {
			os.write(b);
		}
		os.flush();
	} catch (IOException e) {
		e.printStackTrace();
	} finally {
		if (os != null) {
			try {
				os.close();
			} catch (IOException e) {
			}
			;
		}
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
			}
			;
		}
	}
%>