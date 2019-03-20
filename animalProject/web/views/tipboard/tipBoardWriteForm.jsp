<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<%
	/* Member loginUser = (Member)session.getAttribute("loginUser"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<form action="/doggybeta/tinsert" method="post" enctype="multipart/form-data">
				<table align="center">
					<tr><td>제목</td><td><input type="text" name="ttitle"></td></tr>
					<tr><td>작성자</td><td><input type="text" name="twriter" readonly value="user01<%-- <%= loginUser.getUserId() %> --%>"></td></tr>
					<tr><td>첨부파일</td>
					<td><input type="file" name="tupfile"></td></tr>
					<tr><td>내용</td>
					<td><textarea cols="50" rows="7" name="tcontent"></textarea></td></tr>
					<tr><td colspan="2" align="center">
						<input type="submit" value="등록하기"> &nbsp; 
						<input type="reset" value="입력취소"> &nbsp; 
						<a href="/doggybeta/tlist?page=1">[목록]</a>
					</td></tr>
				</table>
			</form>
		
		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>