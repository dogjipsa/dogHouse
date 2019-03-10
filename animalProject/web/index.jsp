<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<meta name="description" content="">
<meta name="author" content="">
<!-- css -->
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="/doggybeta/resources/css/mainV2.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href=/doggybeta/resources/css/multiscroll.css" />
<script type="text/javascript"
	src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
</script>
<!-- javascript -->
<script type="text/javascript"
	src="/doggybeta/resources/js/multiscroll.js"></script>
	<style type="text/css">
	
	</style>
</head>
<!-- <div id="bgimage">
	<img src="/doggybeta/resources/images/backdog1.jpg" alt="" >
</div> -->
<body>
	<input type='checkbox' id='menu_state' checked />
	<nav>
	<%@ include file="../views/common/menu.jsp" %>
	</nav>
	<main>
	<div id='slide'>
		<input type='radio' name='pos' id='pos1' checked /> <input
			type='radio' name='pos' id='pos2' /> <input type='radio' name='pos'
			id='pos3' />
		<ul>
			<li></li>
			<li></li>
			<li></li>
		</ul>
		<p class='pos'>
			<label for='pos1'></label> <label for='pos2'></label> <label
				for='pos3'></label>
		</p>
	</div>
	</main>
	<button class='btn btn-1 btn-sign'>회원가입/로그인</button>
	<!-- <header></header> -->
	<!-- <section></section> -->
	<!-- <section>
	<p>
	과거에는 HTML에 디자인적 요소를 포함하여 작성하는 것이 일반적이었다. 다시 말해서 온갖 레이아웃, 디자인 정보를 HTML 안에 욱여넣다 보니 HTML의 본연의 목적인 구조화된 문서가 아닌 디자인을 위한 문서로 전락하고 말았다. 표를 작성해야 하는 <table> 태그가 레이아웃을 구성하는 용도로 쓰이는 등으로 인해 HTML 소스코드만 보면 이 문서가 어떤 문서인지 전문가조차 알기 힘든 상황이었다.[2]

이에 따라 W3C에서는 "디자인적 요소를 HTML과 완전히 분리시켜 구조화된 HTML을 만들어보자!" 라는 목적으로 CSS를 발표했다. 거기에 따라 bgcolor 등과 같이 HTML에서 디자인에 관련된 요소들은 전부 사용하지 말 것을 권고하고 있다. CSS 발표 이후로 HTML문서의 구조화를 도와주는 div, span, section 등의 새로운 태그가 도입되고 strike, font 등의 스타일 태그는 비권장 태그로 전환되다가 HTML5에서는 아예 삭제되었다. table은 표 형태의 데이터를 표현하는 용도에만 쓰도록 권고하면서 표의 구조화를 도와줄 thead, tbody태그가 새로 소개되었다.

구조화된 HTML은 HTML 태그를 본연의 용도에 맞게 사용하는 것이다. 
	</p>
	</section> -->
</body>
</html>