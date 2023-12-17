<%@page import="kr.ezen.guest.service.GuestBookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글깨짐 방지
	request.setCharacterEncoding("UTF-8");
	// post만 받기
	if(!request.getMethod().equalsIgnoreCase("post")){
		// 누군가가 이 파일을 직접 실행하면 안된다. 그걸 막아야한다.
		// 저장 수정 삭제 처리를 하지 않고 목록보기로 그냥 보내버리자.
		response.sendRedirect("index.jsp");
		return;
	}
	// 이제 데이터를 받아보자!.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="vo" class="kr.ezen.guest.vo.GuestBookVO"></jsp:useBean>
	<jsp:setProperty property="*" name="vo"/>
	
	<%--
		글번호, 이름, 비번, 내용은 받았지만 IP와 날짜는 받지 않았다.
		날짜는 자동으로 DB에서 입력하므로 xx
		ip는 수동으로 넣어줘야한다.
	 --%>
	 <jsp:setProperty property="ip" name="vo" value="<%=request.getRemoteAddr() %>"/>
	 <!-- 모든 데이터를 받았다. -->
	 <!-- 모드에 맞게끔 처리해보자! -->
	 <%
	 	String mode = request.getParameter("mode");
	 	switch(mode) {
	 		case "insert": {
	 			if(GuestBookService.getInstance().insert(vo)>0) {
	 				out.println("<script>alert('저장성공')</script>");
	 			} else {
	 				out.println("<script>alert('저장실패')</script>");	 				
	 			}
	 			break;	 			
	 		}
	 		case "update": {
	 			if(GuestBookService.getInstance().update(vo)>0) {
	 				out.println("<script>alert('수정성공')</script>");
	 			} else {
	 				out.println("<script>alert('수정실패')</script>");	 				
	 			}
	 			break;	 			
	 		}
	 		case "delete": {
	 			if(GuestBookService.getInstance().delete(vo)>0) {
	 				out.println("<script>alert('삭제성공')</script>");
	 			} else {
	 				out.println("<script>alert('삭제실패')</script>");	 				
	 			}
	 			break;	 			
	 		}
	 	}
	 %>
	 <script type="text/javascript">
	 	location.href = 'main.jsp';
	 </script>
</body>
</html>