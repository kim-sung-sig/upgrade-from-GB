<%@page import="com.google.gson.Gson"%>
<%@page import="kr.ezen.guest.service.GuestBookService"%>
<%@page import="kr.ezen.guest.vo.GuestBookVO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int idx = -1;
	try{
		idx = Integer.parseInt(request.getParameter("idx"));		
	} catch(Exception e) {
		e.printStackTrace();
		response.sendRedirect("main.jsp");
	}
	GuestBookVO vo = GuestBookService.getInstance().selectByIdx(idx);
	Gson gson = new Gson();
	out.println(gson.toJson(vo));
%>