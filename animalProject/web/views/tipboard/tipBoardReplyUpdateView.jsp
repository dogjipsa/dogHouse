<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage='tipBoardError.jsp'%>
<%@ page import="member.model.vo.Member, tipboard.model.vo.TipBoard, tipboardreply.model.vo.TipBoardReply" %>    
<%

	TipBoardReply tipReply = (TipBoardReply)request.getAttribute("tipReply");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"></script>
<style type="text/css">
.table{
	position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;
}
h2{
	position: relative;
	left: 700px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}

</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">

<%-- <input type="hidden" name="page" value="<%= currentPage %>"> --%>
<form action ="/doggybeta/trupdate" method="post">
<input type="hidden" name="tnum" value="<%= tipReply.getTipNo() %>">
<input type="hidden" name="trnum" value="<%= tipReply.getTipReplyNo() %>">
<table class="table" align="center">
<tr><th>작성자</th><td><input type="text" id="trwriter" name="trwriter" style="width:766px" readonly value="<%= tipReply.getUserId() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" id="trcontent" name="trcontent" style="width:766px"><%= tipReply.getTipReplyContent() %></textarea></td></tr>
<tr><th colspan="2">
<div align="center">
	<input type="submit" value="수정하기"> &nbsp;
	<a href="/doggybeta/fdetail">[목록]</a>
</div>
</th></tr>
</table>
</form>
<div id="footer" align="center"><%@ include file="..//common/footer.jsp"%></div>
</div>
</body>
</html>





