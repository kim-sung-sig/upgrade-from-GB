<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.ezen.guest.service.GuestBookService"%>
<%@page import="kr.ezen.guest.vo.GuestBookVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
List<GuestBookVO> list = GuestBookService.getInstance().selectList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 업데이트 방명록</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700;800;900&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
@charset "UTF-8";

* {
	padding: 0;
	margin: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
	color: inherit;
}

li {
	list-style: none;
}

ul {
	padding: 0;
	margin: 0
}

body {
	color: #333;
	background: #fff;
	font-family: 'Noto Sans KR', sans-serif;
}

#wrap {
	margin: auto;
	width: 80%;
}

#main_title {
	text-align: center;
	margin: 20px 0;
}

#mode {
	width: 100%;
	padding: 5px;
	border: 2px solid green;
	color: green;
	transition: 0.3s;
	display: block;
	text-align: center;
	border-radius: 10px;
	font-size: 20px;
	font-weight: 500;
	background: #fff;
	cursor: pointer;
}

#mode:hover {
	color: #fff;
	background: green;
}

#tableBox {
	width: 100%;
}

#table_head {
	color: #fff;
	display: flex;
	text-align: center;
	margin-top: 20px;
	padding: 10px 0px;
	font-size: 20px;
	font-weight: 500;
	background: green;
}

#head_idx {
	width: 5%;
}

#head_title {
	width: 70%;
}

#head_regdate {
	width: 10%;
}

#head_writer {
	width: 10%;
}

#head_count {
	width: 5%;
}

.table_content_default {
	text-align: center;
	border: 1px solid #333;
}

.table_content {
	cursor: pointer;
	transition: 0.3s;
}

.table_content:hover {
	background: red;
}

.table_content>ul {
	width: 100%;
	display: flex;
	height: 50px;
}

.line {
	height: 2px;
	border: none;
	background: #333;
}

.content_idx {
	width: 5%;
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
}

.content_title {
	width: 70%;
	display: flex;
	align-items: center;
	padding-left: 15px;
}

.content_regdate {
	width: 10%;
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
}

.content_writer {
	width: 10%;
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
}

.content_count {
	width: 5%;
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div id="wrap">
		<h1 id="main_title">허접한 게시판 ver 0.009</h1>
		<form action="writeArea.jsp" method="post">
			<button type="submit" id="mode" name="mode" value="insert" onclick="location.href='writeArea.jsp'">나도 글쓰기</button>
		</form>
		<div id="tableBox">
			<ul id="table_head">
				<li id="head_idx">NO</li>
				<li id="head_title">제목</li>
				<li id="head_regdate">게시일</li>
				<li id="head_writer">작성자</li>
				<li id="head_count">조회</li>
			</ul>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)");
			if (list == null) {
				out.println("<div class='table_content_default'>글이 존재하지 않습니다.</div>");
			} else {
				for (GuestBookVO vo : list) {
			%>
			<div class="table_content" onclick="location.href = 'viewByIdx.jsp?idx=<%=vo.getIdx()%>'">
				<ul>
					<li class="content_idx"><%=vo.getIdx()%></li>
					<li class="content_title"><%=vo.getTitle()%></li>
					<li class="content_regdate"><%=sdf.format(vo.getRegdate())%></li>
					<li class="content_writer"><%=vo.getName()%></li>
					<li class="content_count"><%=vo.getVcount() %></li>
				</ul>
				<hr class="line">
			</div>
			<%
				}
			}
			%>
		</div>
	</div>
</body>
</html>