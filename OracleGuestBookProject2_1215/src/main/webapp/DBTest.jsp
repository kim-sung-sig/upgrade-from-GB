<%@page import="kr.ezen.guest.vo.GuestBookVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.ezen.jdbc.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = JdbcUtil.getConnection();
	
	String sql = "select * from myguestbook";
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	GuestBookVO vo = null;
	if(rs.next()){
		vo = new GuestBookVO();
		vo.setIdx(rs.getInt("idx"));
		vo.setTitle(rs.getString("title"));
		vo.setName(rs.getString("name"));
		vo.setPassword(rs.getString("password"));
		vo.setRegdate(rs.getTimestamp("regdate"));
		vo.setIp(rs.getString("ip"));
	}
	out.println(vo);
	
	%>
</body>
</html>