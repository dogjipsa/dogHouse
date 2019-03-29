<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.*, java.util.*"%>
<%
	ArrayList<SearchingInfo> list = (ArrayList<SearchingInfo>)request.getAttribute("list");
	
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>



<script>
$(function(){
	$("#search").click(function(){
		var service = $("select[name=service]").val();
		var userid = $("#userid").val();
		var jido = $("#jido").val();
		console.log(service);
		
		$.ajax({
			type : 'post',
			data : {userid : userid, service : service, jido : jido },
			url : '/doggybeta/fplist',
			sucess:function(data){
				alert("성공!");
				$("#jido").val(data.jido);
				
			}
		});
	});
	
});
					
</script>
<script type="text/javascript">

$(function(){

    $("#date").datepicker({
    	dateFormat: 'yy-mm-dd'
    });

});

</script>

<style type="text/css">
body{
	width: 1500px;
}
.checked {
  color: orange;
}
#searchpettable{
	background-color: #f3f6f7;
	padding: 30px 30px;
	margin: 10px 10px;
	height: auto;
	width: 800px;
				
}
input[type=button]{
	background-color: #2ec4b6;
	width:100px; height:30px;
	border: none;
	border-radius: 12px;
	color: white;
 	text-align: center;
}

table td{
text-align: center;
}
 #detail table{
	margin: 8px;
} 

#detailtable:hover{
	background-color: rgba(210, 222, 225, 0.5);
}
#bringpetinfo{
	position: relative;
	text-align: center;
}
</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>

<div id="wrap" >
<div id="content">

날짜 선택 : <input type="text" id="date">

<form name="petinfo" method="post" action="/doggybeta/finding">
	<!-- 조건 검색 테이블  -->	
		<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
<div id="bringpetinfo">		
		<%=loginUser.getUserName() %> 님 안녕하세요!
<input type="submit" value="우리 강아지 정보 가져오기">

</div>
</form> 
			<table id=searchpettable>
				<tr>
					<th width="100">서비스</th>
					<th width="200">날짜</th>
					<th width="100">견종</th>
					<th width="100">반려견크기</th>
					<th width="100">반려견나이</th>
				</tr>		
				<tr>
			
					<td>  
						<select name="service" style="width:180px; height:30px;">
						  <option value="0">[당일]우리집으로 부르기</option>
						  <option value="1">우리집으로 부르기</option>
						  <option value="2">[당일]펫시터 집에 맡기기</option>
						  <option value="3">펫시터 집에 맡기기</option>
						</select>
					</td>
					<td>
					주소 입력 : <input type="text" id="jido">
					</td>
					<td>
				
					<p style="width:180px; height:30px;">
	
					</p>
					</td>

				  	    <% if(list != null){for(SearchingInfo SI : list){ %>
				 	  
					<td><%= SI.getPetBreads() %></td>
					<td><%= SI.getPetSize() %></td>
					<td><%= SI.getAge() %> 살</td>
					<%} }%> 
				</tr>
			</table>
			<br>

<input type="submit" value="펫시터 찾기" id="search">

<br><br>
<!-- 조건에 대한 결과 -->
<div id="detailmain" style="width:1400px" >
<div id="petinfo"  style="float: left; width: 50%">
상단 : 검색 결과 건수 조회
<hr>
<br>
	<div id="detail" style="overflow-x: hidden; overflow-y:scroll; height:550px;">
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>		
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>	
					
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>
		
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>	
					
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		
	</div>
	<!-- detailinfo닫기 -->

</div>
</div>

<!-- <div style="float:left; width:50%;">
지도출력
<hr>
<br>
<div id="map" style="width:100%;height:550px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61e779cba5e3e9729c7fb3b2830dba72"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = { 
        center: new daum.maps.LatLng(37.499274, 127.032963), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(true);  

</script>
</div> -->
</div> 
</div>
		
<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	
</body>
</html>