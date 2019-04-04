<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, member.model.vo.SitterImage, java.util.ArrayList" %>
<%
	Member petSitter = (Member)request.getAttribute("petSitter");
	ArrayList<SitterImage> sitterFacilityImg = (ArrayList<SitterImage>)request.getAttribute("sitterFacilityImg");
	//String service = (String)request.getAttribute("service");
	String[] location = (petSitter.getAddress()).split(",");//상세주소가 다 나오지 않게 ,로 구분
	double starAvg = (Double)request.getAttribute("starAvg");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/doggybeta/resources/css/checkMyLog.css">

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
   word-break:break-all;
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

/* 평균 별점 css  */
span.star-prototype, span.star-prototype > * {
    height: 16px; 
    background: url('/doggybeta/resources/img/YsyS5y8.png') 0 -16px repeat-x;
    width: 80px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:80px; 
}


 .review_count_two  a:link {     color:   #ff923a; font-size: 14pt; text-decoration: none;}
 .review_count_two  a:visited {     color:   #ff923a; text-decoration: none;}
 .review_count_two  a:hover { color:   #ff923a; text-decoration: underline;} 
</style>

</head>
<body>
<div>
<%@ include file="..//common/menu.jsp" %>
<div id="wrap" >
<div id="content">
<div style="float:left; width:700px;"><!-- 가운데 영역, 영역구분을 위해  float처리  -->
<div class="container"><!-- 슬라이드쇼 https://www.w3schools.com/howto/howto_js_slideshow_gallery.asp 참고  -->
  <%for(int i=0; i<sitterFacilityImg.size(); i++){ %>
  <%-- <div class="mySlides">
    <div class="numbertext">1 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(0).getRenameFile() %>" style="width:100%;height:500px">
  </div>
  <div class="mySlides">
    <div class="numbertext">2 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(1).getRenameFile() %>" style="width:100%;height:500px">
  </div>

  <div class="mySlides">
    <div class="numbertext">3 / 3</div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(2).getRenameFile() %>" style="width:100%;height:500px">
  </div> --%>
  <div class="mySlides">
    <div class="numbertext">i / <%= sitterFacilityImg.size()%></div>
    <img src="/doggybeta/files/profile/<%=sitterFacilityImg.get(i).getRenameFile() %>" style="width:100%;height:500px">
  </div>
  <%} %>
  
  
    
  <a class="prev" onclick="plusSlides(-1)">❮</a>
  <a class="next" onclick="plusSlides(1)">❯</a>

  <div class="caption-container">
    <p id="caption"></p>
  </div>

  <div class="row">
  <% for(int i=0; i<sitterFacilityImg.size(); i++){ %>
    <%-- <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(0).getRenameFile() %>" style="width:100%" onclick="currentSlide(1)" alt="<%=petSitter.getUserName()%>님의 시설사진1">
    </div>
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(1).getRenameFile() %>" style="width:100%" onclick="currentSlide(2)" alt="<%=petSitter.getUserName()%>님의 시설사진2">
    </div>
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(2).getRenameFile() %>" style="width:100%" onclick="currentSlide(3)" alt="<%=petSitter.getUserName()%>님의 시설사진3">
    </div> --%>
    <div class="column">
      <img class="demo cursor" src="/doggybeta/files/profile/<%=sitterFacilityImg.get(i).getRenameFile() %>" style="width:100%" onclick="currentSlide(<%=i %>)" alt="<%=petSitter.getUserName()%>님의 시설사진<%=i%>">
    </div>
   <%} %>
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
<thead><tr><th>인적사항</th><th></th><th></th></tr></thead>
<tbody>
<tr>
<% if(petSitter.getUserrefile() != null){ %>
<td rowspan=3><img src="/doggybeta/files/profile/<%=petSitter.getUserrefile()%>" width=100%></td>
<% } %>
<td>이름 : <%=petSitter.getUserName() %></td><td></td>
</tr>
<tr><td>나이 : <%=String.valueOf((petSitter.getUserDate())).substring(0, 4) %> 년생</td><td></td></tr>
<tr><td>평점 :  <span class="star-prototype"><%= starAvg %></span> (<%=starAvg %>)<span id="review_count_two" class="review_count_two"></span></td><td></td></tr></tbody>
</table>
<script type="text/javascript">
/* 별점처리 jquery  */
 $(function(){
	 $.fn.generateStars = function() {
		    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
	 };

	 // 숫자 평점을 별로 변환하도록 호출하는 함수
	 $('.star-prototype').generateStars();
 });
 
 
</script>
<br>
<!-- 펫시터 조회  -->
<table class="board" >

<thead><tr><th>세부조건</th><th></th></tr></thead>
<tr><td>돌봄 가능한 강아지 크기&나이 :  </td><td></td></tr>
<tr><td>하루(1박) : <%=petSitter.getPrice() %> </td><td></td></tr>
<tr><td>당일(체크인/체크아웃 시간 내) : <%=(int)((petSitter.getPrice() * 0.8 *1000)) /1000%> </td><td></td></tr>
</table>
<br>
<table class="board">

<thead><tr><th>상세내용</th><th></th></tr></thead>
<tr><td><%=petSitter.getpContent() %>  </td><td></td></tr>
</table>
<br>
<table class="board">

</table>
</div>
<br>
<div align="center" ><!-- 지도 가운데 정렬을 위한 div  -->
<h4><%=location[0] %></h4>
<div id="map"style="width:400px;height:350px;"><%=petSitter.getAddress()%></div>
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
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=petSitter.getUserName()%>의 집</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});     
</script>

<br>
<br>
<style>
.listlink a:link {     color: #369; text-decoration: none;}
 .listlink a:visited {     color: #369; text-decoration: none;}
 .listlink a:hover { color: #369; text-decoration: underline; background:#e6e6e6;}

</style>
<div style="height:800px"><!-- 리뷰게시판  -->
<table class="board" id="reviewboard">
      <thead>
         <tr>
            <th width="120" colspan='2'>후기(<span id="reviewcount"></span>)</th>
            <!-- <th width="50"></th> -->
            <th width="350"></th>
            <th width="100"><div id="listlink" class="listlink"></div></th>
         </tr>   
      </thead>
      <tbody>
      	
      </tbody>
</table>


<script type="text/javascript">

/* 리뷰게시판 조회   */

function replaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}
 
$(function(){
	console.log($('#petSitterId').val());
		$.ajax({
			url: '/doggybeta/rlist',
			type: 'post',
			dataType: 'json',
			data : {petSitterId : $('#petSitterId').val(),
				    currentPage : $('#currentpage').val()},
			success: function(data){
					 console.log('성공!');
					 
					 var jsonStr = JSON.stringify(data);
					  var json = JSON.parse(jsonStr); 
					 for(var i in json.list){
						 
						 var content = decodeURIComponent(json.list[i].reviewcontent);
						 content = replaceAll(content,"+", " ")

						 $("#reviewboard").append("<tr><td><span class='my-rating'><input type='hidden' id='star' value="+json.list[i].point+"></span></td><td>"+json.list[i].userid+"</td><td>"+content+"</td><td>"+json.list[i].reviewdate+"</tr>");
						 $(".my-rating").starRating({
							 	readOnly: true,
							    starSize: 10,
							    initialRating: json.list[i].point	    
							});
						
						  /* if(json.list[i].point==1){
								$("#reviewboard").append("<tr><td>★</td><td>"+json.list[i].userid+"</td><td>"+decodeURIComponent(json.list[i].reviewcontent)+"</td><td>"+json.list[i].reviewdate+"</tr>");
					     }
						 if(json.list[i].point==2){
								$("#reviewboard").append("<tr><td>★★</td><td>"+json.list[i].userid+"</td><td>"+decodeURIComponent(json.list[i].reviewcontent)+"</td><td>"+json.list[i].reviewdate+"</tr>");
						 }
						 if(json.list[i].point==3){
							$("#reviewboard").append("<tr><td>★★★</td><td>"+json.list[i].userid+"</td><td>"+content+"</td><td>"+json.list[i].reviewdate+"</tr>");
						 }
						 if(json.list[i].point==4){
							 $("#reviewboard").append("<tr><td>★★★★</td><td>"+json.list[i].userid+"</td><td>"+content+"</td><td>"+json.list[i].reviewdate+"</tr>");
							 }
						 if(json.list[i].point==5){
							 $("#reviewboard").append("<tr><td>★★★★★</td><td>"+json.list[i].userid+"</td><td>"+decodeURIComponent(json.list[i].reviewcontent)+"</td><td>"+json.list[i].reviewdate+"</tr>");
							 } */
						<%-- <span class="star-prototype"><%= starAvg %></span> --%>
					 }
					
					 $("#reviewcount").append(data.listCount+"건");
					 if(data.listCount>10){
						 $("#listlink").html("<a href='#' onclick='popupOpen();'>더보기+</a>");
					 }
					 
					 
					 $("#review_count_two").html(" <a href='#reviewboard'>"+data.listCount+"건</a>");
					
			}
		});
	
});

function popupOpen(){
    var url= "/doggybeta/ralllist?puserid=<%=petSitter.getUserId()%>";    //팝업창 페이지 URL
    var winWidth = 700;
     var winHeight = 600;
     var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
    window.open(url,"",popupOption+",left=500, top=250");
 }
</script>


</div>


</div><!-- 가운데 영역  끝-->

<style>
input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  font-size:15px;
}

input[type=submit] {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size:30px;
}

input[type=submit]:hover {
  background-color: #45a049;
}


</style>

<!-- 예약페이지  -->
<div style="float:left;padding-top:100px;padding-left:30px;"><!-- 오른쪽 영역  --> 
<div id="rightpart" style="border-radius: 5px; background-color: #f2f2f2; padding: 20px;"><!-- 날짜 입력  -->
<form action="/doggybeta/bkinsert" type="post">

이용할 서비스(선택)
<select id="selectservice" onchange="priceCal()">
<!-- selected가 바뀔 때마다 서비스가 바뀌도록  -->
<option>펫시터 집에 맡기기</option>
<option>펫시터 우리집으로 부르기</option>
</select>
<br><br>
예약날짜(최대 2주) <br><input type="text" name="datetimes" onchange="priceCal()" id="datetimes" size="35" readonly/>
<!-- 날짜값이 바뀔 때마다 가격과 서비스가 바뀌도록  -->
<br><br>
이용할 서비스<input type="text" id="service" readonly>
<br><br>
나의 애완견
<select name="mypet" id="mypet" onclick="mypetCheck();">

</select>
<script type="text/javascript">
function mypetCheck(){
	if($("#mypet").val() == null){
		alert("등록된 펫이 없습니다. ");
		//alert($("#mypet").val());
		var submitAction = function(e) { //sumit클릭시 form action이 진행되지 않게 막음
			e.preventDefault();
		    e.stopPropagation();
		};
		$('form').bind('submit', submitAction);
	};
	
};
</script>

<br><br>
요청사항 <br><br><textarea  style="resize: none;" name="etc"  rows="4" cols="37" placeholder="펫시터에게 전할 말.."></textarea>
<%-- <input type="hidden" name="service" id="service" value="<%=service%>"> --%>
<input type="hidden" name="petSitterId" id="petSitterId" value="<%=petSitter.getUserId()%>">
<input type="hidden" name="userId" id="userId" value="<%=loginUser.getUserId()%>">
<input type="hidden" name="price" id="price" value="<%=petSitter.getPrice() %>">
<%-- <input type="hidden" name="petno" value="<%=request.getParameter("petno")%>"> --%>
<input type="hidden" name="servicekind" id="servicekind">
<br><br>
총 가격 : <input type="text" value=""  id="priceSum" name="priceSum" readonly>
<p id="pricesum"></p>
<br><br>
<input type="submit" value="예약하기" onclick="mypetCheck();">
<script>

$(function() {
  $('input[name="datetimes"]').daterangepicker({
    timePicker: true,
    timePicker24Hour: true,
    startDate: moment().startOf('day').add(1,'day'),
    minDate : moment().startOf('day').add(1,'day'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    maxDate: moment().startOf('day').add(14,'day'),
    locale: {
      format: 'YYYY/MM/DD HH:mm'
    }/* ,
    isInvalidDate: function(date) {
        if (date.format('YYYY-M-D') == '2019-04-06') {
            return true; 
        }
    } */
  
  });
});

  /* 가격계산, 서비스 출력 ajax  */
function priceCal(){
	 console.log($('input[name="datetimes"]').val());
	 console.log($('#datetimes').val());
	 console.log($('#price').val());
   	 $.ajax({
				url: '/doggybeta/priceCal',
				type: 'post',
				dataType: 'json',
				data: {datetimes: $('#datetimes').val(),
						price: $('#price').val(),
						selectservice: $("#selectservice").val()},
				success: function(data){
							$("#priceSum").val(data.pricesum+" 원");
							$("#service").val(data.service + data.dateStr);
							$("#pricesum").append(pricesum);
							$("#servicekind").val(data.servicekind);
						}
			});
  }
  
</script>
<script type="text/javascript">
$(function(){
	 $.ajax({
		 url: '/doggybeta/palllist',
			type: 'post',
			dataType: 'json',
			data : {userId : $('#userId').val()},
			success: function(data){
					 var jsonStr = JSON.stringify(data);
					 var json = JSON.parse(jsonStr); 
					 for(var i in json.list){
						 $("#mypet").append("<option>"+decodeURIComponent(json.list[i].pname)+"  "+decodeURIComponent(json.list[i].breeds)+"  "+decodeURIComponent(json.list[i].gender)+"</option>");
						 //$("#reviewboard").append("<tr><td><span class='star-prototype'>"+i+"</span></td><td>"+json.list[i].userid+"</td><td>"+decodeURIComponent(json.list[i].reviewcontent)+"</td><td>"+json.list[i].reviewdate+"</tr>");
					 }
			}
	 	});
 	});

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