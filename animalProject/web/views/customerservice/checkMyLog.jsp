<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	<div class="wrap_content">
		<div class="section1">section1 - 변경 버튼's</div>
		<div class="section2">section2 - 페이지 내용 헤더</div>
		<div class="section3">section3 - 알람 정보</div>
		<!-- section4 - 예약/결제내역/내정보 수정 등의 메인 섹션 -->
		<div class="section4">
			<div class="reserv_log">
				<span>번호</span>
				<span>내용</span>
				<span>펫시터</span>
				<span>이용날짜</span>
				<span>진행상황</span></div>
			<div class="reserv_log reserv_log_head">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
			<div class="reserv_log">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
			<div class="reserv_log">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
			<div class="reserv_log">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
			<div class="reserv_log"
			><span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
			<div class="reserv_log">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
				<span></span></div>
		</div>
		<div class="section5">section5 - 페이징 변경 섹션</div>
	</div>

	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>

</html>