<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage='memberError.jsp'%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>

<!-- css -->
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">

<style>
* {box-sizing: border-box}
body {font-family: Verdana, sans-serif; margin:0}
.mySlides {display: none}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  top: 100px;
  margin: auto;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .prev, .next,.text {font-size: 11px}
}
</style>
</head>
<body>
<%@ include file="..//views/common/menu.jsp" %>
   <div id="wrap">
        <div id="content">
         <!-- 내용작성  -->
<div class="slideshow-container" style="max-width:100%">

<div class="mySlides fade">
  <div class="numbertext">1 / 3</div>
  <img src="/doggybeta/resources/images/dogmk1.jpg" style="width:100%">
  <div class="text" style="color:#222;">
  도그 하우스는 100% 회원제 서비스입니다. 회원가입을 하고 펫시팅 서비스를 신청하세요.
  </div>
</div>

<div class="mySlides fade">
  <div class="numbertext">2 / 3</div>
  <img src="/doggybeta/resources/images/dogmk5.jpg" style="width:100%">
  <div class="text">누구나 펫시터가 될 수 있습니다. 회원가입을 하고 펫시터 신청을 해보세요.</div>
</div>

<div class="mySlides fade">
  <div class="numbertext">3 / 3</div>
  <img src="/doggybeta/resources/images/dogmk4.jpg" style="width:100%">
  <div class="text">당신이 선택한 펫시터의 평점을 확인하고 당신의 반려견에 좋은 추억을 선물하세요.</div>
</div>

<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>
<br>

<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span> 
</div>

<script>
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
</script>
      
      </div>
      <%-- <div id="footer"><%@ include file="..//views/common/footer.jsp"%></div> --%>
   </div>
</body>
</html>
</body>
</html>