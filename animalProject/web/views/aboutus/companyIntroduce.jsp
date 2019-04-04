<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>

<!-- css -->
<!-- 변경확인용 주석2  -->
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet" type="text/css">
<style>
#wrap {
	font-family: 'Sunflower', 'sans-serif';
} 
.hero-image {
  background-color : #d2dee1;
  height: 50%;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover; 
  position: relative;
  top : 200px; 
 
}

.hero-text {
  text-align: center;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: black;
  font-size: 15pt;
}

.hero-text button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 10px 25px;
  color: black;
  background-color: #ddd;
  text-align: center;
  cursor: pointer;
}

.hero-text button:hover {
  background-color: #555;
  color: white;
}
.serviceorder .ordertop{
	position: relative;
	top: 400px;
	display:flex;
    flex-direction:row;
    text-align:center;
    align-items: center;
	justify-content: center;

}
.serviceorder .ordertop .order{
    margin: 20px 20px;
    padding: 30px 30px;
    font-size: 13pt;
}
.serviceorder .ordertop .order img{
	margin: 10px 10px;
}
.serviceorder .orderline {
  height: 20px;
  position: relative;
  top: 400px;
  border-top: 4px solid #2ec4b6;
  margin: 50px
}
</style>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
   <div id="wrap">
        <div id="content">
        
        

<div class="hero-image">
  <div class="hero-text">
    <h1 style="font-size:50px">We are DogHouse</h1>
    <p>도그하우스는 1:1 매칭 서비스를 통해 반려인과 반려견에게 양질의 펫시팅 서비스를 제공합니다.</p>
    <button onclick="location.href='/doggybeta/views/member/termsOfService.jsp'">회원가입하기</button>
  </div>
</div>



<div class="serviceorder">
<div class="orderline">

</div>
<div class="ordertop">
<div class="order">
   	<img src="/doggybeta/resources/images/search.png" style="width: 70px;">
   	<br>조건에 맞는 펫시터를 검색하세요.
  </div>
    <div class="order">
    <img src="/doggybeta/resources/images/conversation.png" style="width: 70px;">
    <br>어떤 서비스를 요청할 지 결정하세요.
  </div>
    <div class="order">
    <img src="/doggybeta/resources/images/dogicon.png" style="width: 70px;">
    <br>결제 완료 후 당신의 반려견을 맡겨보세요.
  </div>
    <div class="order">
    <img src="/doggybeta/resources/images/rating.png" style="width: 70px;">
    <br>후기는 펫시터 결정에 큰 도움이 됩니다.
  </div>
</div>
  
</div>

</div>
</div>
</body>
</html>
   
