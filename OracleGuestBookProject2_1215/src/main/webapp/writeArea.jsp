<%@page import="kr.ezen.guest.service.GuestBookService"%>
<%@page import="kr.ezen.guest.vo.GuestBookVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글깨짐 방지
	request.setCharacterEncoding("UTF-8");
	// post만 받기
	if(!request.getMethod().equalsIgnoreCase("post")){
		// 누군가가 이 파일을 직접 실행하면 안된다. 그걸 막아야한다.
		// 저장 수정 삭제 처리를 하지 않고 목록보기로 그냥 보내버리자.
		response.sendRedirect("index.jsp");
		return;
	}
	String mode = request.getParameter("mode");
	GuestBookVO vo = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 영역</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700;800;900&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    *{padding: 0;margin: 0; box-sizing: border-box;}
    
    :focus{outline: 0}
    body{color: #333; background: #fff; font-family: 'Noto Sans KR', sans-serif; margin: auto; width: 500px;}
    ul{list-style: none;}
    #wrap {width: 500px; margin-top: 50px; border: 2px solid green; padding: 20px; border-radius: 10px;}
    #head-title {text-align: center; margin-bottom: 20px;}
    #formOk{width: 100%;}
    #formOk ul{display: flex;}
    .tag{width: 100px;}
    #content{
      resize: none;
    }
    .ipt{width: 380px;height: 30px; margin-bottom: 10px; border: 2px solid #333; border-radius: 5px;}
    .ipt:focus{border: 2px solid green;}
    .area{height: 150px;}
    .btns {
      text-align: right;
    }
    .btns>input{
      border: 2px solid green; background: #fff;padding: 5px 10px; border-radius: 15px;
      cursor: pointer; transition: 0.3s;
    }
    .btns>input:hover{
      background: green; color: #fff;
      cursor: pointer;
    }
  </style>
  <script>
  	$(function(){
  		// 폼검증
  		$("#formOk").submit(function(){
  			let value = $("#name").val();
  			if(value==null || value.trim().length()==0) {
  				alert("이름은 반드시 입력해야 합니다.")
  				$("#name").val("");
  				$("#name").focus();
  				return false;
  			}
  			value = $("#password").val();
  			if(value==null || value.trim().length()==0) {
  				alert("비밀번호는 반드시 입력해야 합니다.")
  				$("#password").val("");
  				$("#password").focus();
  				return false;
  			}
  			value = $("#title").val();
  			if(value==null || value.trim().length()==0) {
  				alert("제목은 반드시 입력해야 합니다.")
  				$("#title").val("");
  				$("#title").focus();
  				return false;
  			}
  			value = $("#content").val();
  			if(value==null || value.trim().length()==0) {
  				alert("내용은 반드시 입력해야 합니다.")
  				$("#content").val("");
  				$("#content").focus();
  				return false;
  			}
  			return true;
  		})
  	})
  </script>
</head>
<body>
  <div id="wrap">
    <h1 id="head-title">글쓰기영역</h1>
		<form action="updateOk.jsp" method="post" id="formOk">
			<input type="hidden" name="mode" id="mode" value="<%=mode %>" />
			<%if(mode.equals("insert")) { %>
			<div>
				<input type="hidden" name="idx" id="idx" value="0"/>
				<ul>
					<li class="tag"> 이름 : </li>
					<li>
						<input class="ipt" type="text" name="name" id="name" placeholder="이름을 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 비밀번호 : </li>
					<li>
				  		<input class="ipt" type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 제목 : </li>
					<li>
				  		<input class="ipt" type="text" name="title" id="title" placeholder="제목을 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 내용 : </li>
					<li>
				  		<textarea class="ipt area" rows="5" cols="10" name="content" id="content" placeholder="내용을 입력하세요." required="required"></textarea>
					</li>
				</ul>
				<div class="btns">
					<input type="submit" name="submitBtn" id="submitBtn" value="저 장 하 기">
					<input type="button" name="resetBtn" id="resetBtn" value="취 소 하 기" onclick="location.href='main.jsp'">
				</div>
			</div>
			<%} else if(mode.equals("update")){ 
				int idx = Integer.parseInt(request.getParameter("idx"));
				vo = GuestBookService.getInstance().selectByIdx(idx);
			%>
			<div>
				<input type="hidden" name="idx" id="idx" value="<%=vo.getIdx()%>"/>
				<ul>
					<li class="tag"> 이름 : </li>
					<li>
						<input class="ipt" type="text" name="name" id="name" value="<%=vo.getName() %>" disabled="disabled" required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 비밀번호 : </li>
					<li>
				  		<input class="ipt" type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 제목 : </li>
					<li>
				  		<input class="ipt" type="text" name="title" id="title" placeholder="제목을 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 내용 : </li>
					<li>
				  		<textarea class="ipt area" rows="5" cols="10" name="content" id="content" placeholder="내용을 입력하세요." required="required"></textarea>
					</li>
				</ul>
				<div class="btns">
					<input type="submit" name="submitBtn" id="submitBtn" value="저 장 하 기">
					<input type="button" name="resetBtn" id="resetBtn" value="취 소 하 기" onclick="location.href='main.jsp'">
				</div>
			</div>
			<%} else {
				int idx = Integer.parseInt(request.getParameter("idx"));
				vo = GuestBookService.getInstance().selectByIdx(idx);
				%>
			<div>
				<input type="hidden" name="idx" id="idx" value="<%=vo.getIdx()%>"/>
				<ul>
					<li class="tag"> 이름 : </li>
					<li>
						<input class="ipt" type="text" name="name" id="name" value="<%=vo.getName() %>" disabled="disabled" required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 비밀번호 : </li>
					<li>
				  		<input class="ipt" type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 제목 : </li>
					<li>
				  		<input class="ipt" type="text" name="title" id="title" value="<%=vo.getTitle() %>" disabled="disabled" required="required">
					</li>
				</ul>
				<ul>
					<li class="tag"> 내용 : </li>
					<li>
				  		<textarea class="ipt area" rows="5" cols="10" name="content" id="content" disabled="disabled" required="required"><%=vo.getContent() %></textarea>
					</li>
				</ul>
				<div class="btns">
					<input type="submit" name="submitBtn" id="submitBtn" value="저 장 하 기">
					<input type="button" name="resetBtn" id="resetBtn" value="취 소 하 기" onclick="location.href='main.jsp'">
				</div>
			</div>	
			<%} %>
		</form>
	</div>
</body>
</html>