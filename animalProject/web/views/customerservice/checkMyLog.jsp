<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>이용내역/예약 확인</title>
	<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/doggybeta/resources/css/checkMyLog.css">
</head>

<body>
	<%@ include file="..//common/menu.jsp" %>
	<form id="bklist-form" action="/doggybeta/bklist" method="POST">
		<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
	</form>
	<div class="wrap_content">
		<!-- section1 - 변경 버튼's -->
		<div class="section1">
			<div>
				<input type="radio" name="item" value="booking" checked> 예약내역 &nbsp;&nbsp;&nbsp;
				<input type="radio" name="item" value="payment" > 결제내역 &nbsp;&nbsp;&nbsp;
			</div>
		</div>
		<div class="section2">section2 - 페이지 내용 헤더</div>
		<div class="section3">section3 - 알람 정보</div>
		<!-- section4 - 예약/결제내역/내정보 수정 등의 메인 섹션 -->
		<div class="section4">
			<table id="reserv_table">
				<tr>
					<th>예약번호</th>
					<th>내용</th>
					<th>펫시터</th>
					<th>이용날짜</th>
					<th>진행상황</th>
				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
				</tr>
			</table>
		</div>
		<div class="section5">section5 - 페이징 변경 섹션</div>
	</div>

	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	<script src="/doggybeta/resources/js/checkMyLog.js"></script>
</body>

</html>