<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, member.model.vo.SitterImage, java.util.ArrayList" %>
<%
	Member petSitter = (Member)request.getAttribute("petSitter");
	ArrayList<SitterImage> sitterFacilityImg = (ArrayList<SitterImage>)request.getAttribute("sitterFacilityImg");
	String service = (String)request.getAttribute("service");

	System.out.println("view에서 service 확인 : "+service);
	System.out.println("아이디 확인"+petSitter);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">

<!-- 시간(DateTimePicker) 위젯 링크들은 menu.jsp에 추가  -->

<style type="text/css">

/* 화면에 보여지는 글 목록 테이블 */
h2{
   position: relative;
   top: 20px;
   left : 200px;
   width: 70%;
   padding: 2rem 0px;
}
.board { 
   position: relative;
   left : 10px;
   top: 20px;
   width: 100%;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed; 
   
}
.button{
   position: relative;
   left : 200px;
   top: 50px;
}

/* list_table 에서 사용되는 thead */
.board thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}

/* list_table 에서 사용되는 tbody */
.board tbody td { 
	width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;   
    
}

.board tbody tr:hover{
	background-color : #f3f6f7;
}
header{
	text-align:center;	
	padding: 2rem 0px;
}

.board tbody td a{
	text-decoration: none;
	color: black;
}
.search{
	display: flex;
	justify-content: center;
}
.insert{
	padding: 0 2rem;
}
#wrap{
	left: 200px;
	border: 1px solid red;
	margin: 0 auto;
}

/*  슬라이드를 위한 스타일  */
body {
  font-family: Arial;
  margin: 0;
}

* {
  box-sizing: border-box;
}

img {
  vertical-align: middle;
}

/* Position the image container (needed to position the left and right arrows) */
.container {
  position: relative;
   top: 20px;
   left : 20px;/* 원래는 200  */
   width: 600px;
}

/* Hide the images by default */
.mySlides {
  display: none;
}

/* Add a pointer when hovering over the thumbnail images */
.cursor {
  cursor: pointer;
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 40%;
  width: auto;
  padding: 16px;
  margin-top: -50px;
  color: white;
  font-weight: bold;
  font-size: 20px;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover,
.next:hover {
  background-color: rgba(0, 0, 0, 0.8);
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* Container for image text */
.caption-container {
  text-align: center;
  background-color: #222;
  padding: 2px 16px;
  color: white;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Six columns side by side */
.column {
  float: left;
  width: 16.66%;
}

/* Add a transparency effect for thumnbail images */
.demo {
  opacity: 0.6;
}

.active,
.demo:hover {
  opacity: 1;
}
</style>

</head>
<body>
<div>
<%@ include file="..//common/menu.jsp" %>
<div id="wrap" >
<div id="content">
<div style="float:left; width:700px;"><!-- 가운데 영역, 영역구분을 위해  float처리  -->
<div class="container"><!-- 슬라이드쇼 https://www.w3schools.com/howto/howto_js_slideshow_gallery.asp 참고  -->
  <div class="mySlides">
    <div class="numbertext">1 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(0).getRenameFile() %>" style="width:100%">
  </div>
  <div class="mySlides">
    <div class="numbertext">2 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(1).getRenameFile() %>" style="width:100%">
  </div>

  <div class="mySlides">
    <div class="numbertext">3 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(2).getRenameFile() %>" style="width:100%">
  </div>
  
  
    
  <a class="prev" onclick="plusSlides(-1)">❮</a>
  <a class="next" onclick="plusSlides(1)">❯</a>

  <div class="caption-container">
    <p id="caption"></p>
  </div>

  <div class="row">
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(0).getRenameFile() %>" style="width:100%" onclick="currentSlide(1)" alt="<%=petSitter.getUserName()%>님의 시설사진1">
    </div>
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(1).getRenameFile() %>" style="width:100%" onclick="currentSlide(2)" alt="<%=petSitter.getUserName()%>님의 시설사진2">
    </div>
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(2).getRenameFile() %>" style="width:100%" onclick="currentSlide(3)" alt="<%=petSitter.getUserName()%>님의 시설사진3">
    </div>
   
  </div>
 
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
  var dots = document.getElementsByClassName("demo");
  var captionText = document.getElementById("caption");
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
  captionText.innerHTML = dots[slideIndex-1].alt;
}
</script>

<div style="height:800px; width:700px">
<table class="board" >
<thead><tr><th>인적사항</th></tr></thead>
<tbody><tr><td rowspan=3><img src="/doggybeta/files/profile/<%=petSitter.getUserrefile()%>" width=100%></td><td>이름 : <%=petSitter.getUserName() %></td></tr>
<tr><td>나이 : <%=petSitter.getUserDate() %></td><td></td></tr>
<tr><td>평점 : </td><td></td></tr></tbody>
</table>
<br>
<!-- 펫시터 조회  -->
<table class="board" >

<thead><tr><th>세부조건</th></tr></thead>
<tr><td>돌봄 가능한 강아지 크기&나이 :  </td><td></td></tr>
<tr><td>하루(1박) : <%=petSitter.getPrice() %> </td><td></td></tr>
<tr><td>당일(체크인/체크아웃 시간 내) : <%=(int)((petSitter.getPrice() * 0.8 *1000)) /1000%> </td><td></td></tr>
</table>
<br>
<table class="board">

<thead><tr><th>상세내용</th></tr></thead>
<tr><td>내용 받아와야 함.(오라클에 컬럼 추가 요망)  </td><td></td></tr>
</table>
<br>
<table class="board">
<thead><tr><th>돌봄환경</th></tr></thead>
<tr><td>정기예약 :   </td><td></td></tr>
</table>
</div>
<br>
<div align="center" ><!-- 지도 가운데 정렬을 위한 div  -->
<div id="map"style="width:40%;height:350px;"><%=petSitter.getAddress()%></div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9810167e43ee638a44b19264113db0d&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다

geocoder.addressSearch('<%=petSitter.getAddress()%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});     
</script>

<div style="height:800px"><!-- 리뷰게시판  -->
<table class="board">
      <thead>
         <tr>
            <th width="50">작성자</th>
            <th width="70">별점</th>
            <th width="300">내용</th>
            <th width="130">작성일</th>
         </tr>   
      </thead>
      <tbody>
      	<tr>
      	<td>아이디</td>
      	<td>별점</td>
      	<td>내용</td>
      	<td>날짜</td>
      	</tr>
      </tbody>
      <%-- <tbody>      
       <%   for(Notice notice : list){ %>
   <tr>
   <td><%= notice.getNoticeNo() %></td>
   
   <td>
   <%if(loginUser != null){ %>
   <a href="/doggybeta/ndetail?no=<%= notice.getNoticeNo()%>"><%= notice.getNoticeTitle() %></a>
   <% }else{ %>
   <%= notice.getNoticeTitle() %>
   <% } %>
   </td>
   <td><%= notice.getManagerId() %></td>
   <td><%= notice.getNoticeDate() %></td>
   <td><%= notice.getNoticeViews() %></td>
   <td>
   <%if(notice.getNoticeOriginFile() != null) {%>
   <img src="/doggybeta/resources/images/paw.png" width="20px;" align="center;">
   <% }else{ %>
   &nbsp;
   <%} %>
   </td>
   </tr>   
   <% } %>     
   </tbody>    --%>
</table>
페이징처리
</div>

</div><!-- 가운데 영역  끝-->
<div style="float:left;padding-top:100px"><!-- 오른쪽 영역  --> 
<div><!-- 날짜 입력  -->
<form action="/doggybeta/bkinsert" type="post">
<input type="text" name="datetimes" onchange="priceCal()" id="datetimes" size="35"/>
<br><br>
<textarea name="etc"></textarea>
<input type="hidden" name="service" value="<%=service%>">
<input type="hidden" name="petSitterId" value="<%=petSitter.getUserId()%>">
<input type="hidden" name="userId" value="<%=loginUser.getUserId()%>">
<input type="hidden" name="price" id="price" value="<%=petSitter.getPrice() %>">
<br><br>
총 가격 : <input type="text" value=""  id="priceSum" name="priceSum" readonly> 원
<br><br>
<input type="submit" value="예약하기">

<script>
$(function() {
  $('input[name="datetimes"]').daterangepicker({
    timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale: {
      format: 'YYYY/MM/DD HH:mm'
    }

  });
 
  /* 가격계산 ajax  */
});
function priceCal(){
	 console.log($('input[name="datetimes"]').val());
	 console.log($('#datetimes').val());
	 console.log($('#price').val());
   	 $.ajax({
				url: '/doggybeta/priceCal',
				type: 'post',
				dataType: 'json',
				data: {datetimes: $('#datetimes').val(),
						price: $('#price').val()},
				success: function(data){
							$("#priceSum").val(data.pricesum);
						}
				
				
			});
  }
</script>
</form>
</div>
</div>
</div><!-- content 끝  -->
</div>
		
<%-- <div id="footer"><%@ include file="..//common/footer.jsp"%></div> --%>
</div>
</body>
</html>