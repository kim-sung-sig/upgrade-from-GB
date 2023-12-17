<%@page import="kr.ezen.guest.vo.GuestBookVO"%>
<%@page import="kr.ezen.guest.service.GuestBookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int idx = -1;
try {
	idx = Integer.parseInt(request.getParameter("idx"));
} catch (Exception e) {
	e.printStackTrace();
	response.sendRedirect("main.jsp");
}

// 조회수를 증가시키자.
GuestBookService.getInstance().updateVcount(GuestBookService.getInstance().selectByIdx(idx));
GuestBookVO vo = GuestBookService.getInstance().selectByIdx(idx);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700;800;900&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
/* 간단한 스타일링을 위한 CSS */
body {
	font-family: Arial, sans-serif;
}

.container {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

h1 {
	text-align: center;
}

.post-info {
	margin-bottom: 10px;
}

.post-info span {
	margin-right: 20px;
}

#content {
	margin-top: 20px;
}

#buttons {
	margin-top: 20px;
	text-align: center;
	display: flex;
}

#edit-btn, #delete-btn,#home-btn {
	padding: 10px 20px;
	margin: 0 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#home-btn {
	background-color: silver;
	color: #fff;
}
#edit-btn {
	background-color: #3498db;
	color: #fff;
}

#delete-btn {
	background-color: #e74c3c;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container">
		<h1><%=vo.getTitle() %></h1>
		<div class="post-info">
			<span>작성자 : <%=vo.getName() %></span> <span>개시일 : <%=vo.getRegdate() %></span> <span>조회수 : <%=vo.getVcount() %></span>
		</div>
		<div id="content">
			<%=vo.getContent()%>
			<div id="buttons">
				<button id="home-btn" onclick="location.href ='main.jsp'">목록가기</button>
				<form action="writeArea.jsp" method="post" id="formOk">
					<input type="hidden" id="idx" name="idx" value="<%=vo.getIdx()%>"/>
					<input type="hidden" id="mode" name="mode" value="update">
					<button id="edit-btn">수정하기</button>
				</form>
				<form action="writeArea.jsp" method="post" id="deleteOK">
					<input type="hidden" id="idx" name="idx" value="<%=vo.getIdx()%>"/>
					<input type="hidden" id="mode" name="mode" value="delete">
					<button id="delete-btn" onclick="deleteOk()">삭제하기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>