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
	href="/doggybeta/resources/css/multiscroll.css" />
	
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}
</style>
	
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
	
	<%@ include file="../views/common/menu.jsp" %>
<div style="max-width:100%;margin-left:20%;">
<div class="w3-container">
  <h2>Slideshow Indicators</h2>
  <p>An example of using buttons to indicate how many slides there are in the slideshow, and which slide the user is currently viewing.</p>
</div>

<div class="w3-content w3-display-container" style="max-width:70%; ">
  <img class="mySlides" src="/doggybeta/resources/images/backdog1.jpg" style="width:100%;">
  <img class="mySlides" src="/doggybeta/resources/images/dog2.jpg" style="width:100%">
  <img class="mySlides" src="/doggybeta/resources/images/backdog1.jpg" style="width:100%">
  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
  </div>
</div>
</div>
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>
	
	<!-- <header></header> -->
	<!-- <section></section> -->
	<!-- <section>
	<p>
	
	</p>
	</section> -->
	
	
	
<%@ include file="views/common/footer.jsp" %>
</body>
</html>