<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.*, java.util.*"%>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
	ArrayList<SitterImage> imglist = (ArrayList<SitterImage>)request.getAttribute("imglist");
	System.out.println("뷰 리스트 확인 : " + imglist);
	String service = (String)request.getAttribute("service");
	String petSitterId = (String)request.getAttribute("petSitterId");
	HashMap<String, SitterImage> map = (HashMap<String, SitterImage>)request.getAttribute("map");
	System.out.println("map jsp 확인 : " + map);
	System.out.println("list jsp 확인 : " + list);
	ArrayList<String> address = (ArrayList<String>)request.getAttribute("address");
	int count = 0;
	if(list != null){
		 count = (int)request.getAttribute("count");
	}
	String imgFile = (String)request.getAttribute("imgFile");
	
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
	 
		$.ajax({
			type : 'post',
			cache: false,
			datatype: 'json',
			data : {petuserid : $("#petuserid").val()},
			url : '/doggybeta/fpinfo',
			success:function(data){
				console.log(data);	
				console.log(data.img);
				$("#pet").html($("#pet").text() 
						+ "<table id='petinfotable'>"
						+ "<tr><th>강아지이름</th><td>" + decodeURIComponent(data.petname) + "</td></tr>"  
						+ "<tr><th>강아지나이</th><td>" + data.petage + "살</td></tr>"
						+ "<tr><th>강아지 크기</th><td>" + decodeURIComponent(data.petsize) + "</td></tr>"
						+ "<tr><th>견종</th><td>" + decodeURIComponent(data.breads) + "</td></tr>"
						+ "<tr><th>성별</th><td>" + data.gender + "</td></tr>"
						+ "<tr><th>중성화여부</th><td>" + data.yesorno + "</td></tr></table>"
						+ "<img src='/doggybeta/files/pet/" + decodeURIComponent(data.img) + "'>" )

			}  //success
			
			});
		 
 });	

function categoryChange(e) {
	  var detail_name1 = ['전체', '강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구'];
	  var detail_name2 = ['전체', '고양','과천','광명','광주','구리','군포','김포','남양주','동두천','부천', '성남', '수원','시흥','안산','안양','오산','용인','의왕','의정부','이천','파주','평택','하남','화성','가평','양주','양평','여주','연천','포천'];
	  var target = document.getElementById("detail");
	   console.log("detail : " + detail);
	  console.log("target : " + target); 
	  if(e.value == "서울") {
		  var d = detail_name1;
		  if(detail_name1 == "전체"){
			  d == null;
		  }
	  }
	  else if(e.value == "경기") {
		  var d = detail_name2;
		  if(detail_name2 == "전체"){
			  d == null;
			  }
		  }

	 
	  target.options.length = 0;
	 
	  for (x in d) {
	    var opt = document.createElement("option");
	    opt.value = d[x];
	    opt.innerHTML = d[x];
	    target.appendChild(opt);
	  } 
	}
					
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
	width: 600px;
				
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
#searchpettable tr{
padding: 10px 10px;
margin: 10px 10px;
}

#petinfotable{
border : 1px solid #2ec4b6;
background: #fff;
padding: 10px 10px;
margin: 10px 10px;
border-radius: 10px;
display: inline-block;
position: absolute;
left: 650px;
}
 #detail table{`
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
<input type="hidden" id="petuserid" name="petuserid" value="<%=loginUser.getUserId() %>">
<p id="pet">

</p>

<form name="petinfo" method="post" action="/doggybeta/fplist">
	<!-- 조건 검색 테이블  -->	
		
 <div id="bringpetinfo">		
<input type="hidden" id="userid" name="userid" value="<%=loginUser.getUserId() %>">	
</div>
 
			<table id=searchpettable>
				<tr>
					<th width="100">서비스</th>
					<th width="200">주소</th>
					
				</tr>		
				<tr>

					<td>  
					<%if(service != null){ %>
					<%if(service.equals("1")) {%>
						<select name="service" style="width:180px; height:30px;">
						  <option>선택</option>
						  <option value="0">[당일]우리집으로 부르기</option>
						  <option value="1" selected>우리집으로 부르기</option>
						  <option value="2">[당일]펫시터 집에 맡기기</option>
						  <option value="3">펫시터 집에 맡기기</option>
						</select>
					<%}else if(service.equals("2")) {%>
					<select name="service" style="width:180px; height:30px;">
						<option>선택</option>
						  <option value="0">[당일]우리집으로 부르기</option>
						  <option value="1" >우리집으로 부르기</option>
						  <option value="2" selected>[당일]펫시터 집에 맡기기</option>
						  <option value="3">펫시터 집에 맡기기</option>
						</select>	
					<%}else if(service.equals("3")) {%>	
						<select name="service" style="width:180px; height:30px;">
						<option>선택</option>
						  <option value="0">[당일]우리집으로 부르기</option>
						  <option value="1" >우리집으로 부르기</option>
						  <option value="2" >[당일]펫시터 집에 맡기기</option>
						  <option value="3" selected>펫시터 집에 맡기기</option>
						</select>	
					<%}else if(service.equals("0")) {%>	
					<select name="service" style="width:180px; height:30px;">
					<option>선택</option>
					  <option value="0" selected>[당일]우리집으로 부르기</option>
					  <option value="1" >우리집으로 부르기</option>
					  <option value="2" >[당일]펫시터 집에 맡기기</option>
					  <option value="3" >펫시터 집에 맡기기</option>
					</select>
					<%}} else{%>
					<select name="service" style="width:180px; height:30px;">
					<option selected>선택</option>
						  <option value="0" >[당일]우리집으로 부르기</option>
						  <option value="1" >우리집으로 부르기</option>
						  <option value="2" >[당일]펫시터 집에 맡기기</option>
						  <option value="3">펫시터 집에 맡기기</option>
						</select>
					<%} %>					
					</td>
					<td>
					  <select name="jido" onChange="categoryChange(this)" style="width:80px; height:30px;">
						<option selected>-선택-</option>
						<option value='서울'>서울</option>
						<option value='경기'>경기</option>
						<option value='대구'>대구</option>
						<option value='인천'>인천</option>
						<option value='강원'>강원</option>
						<option value='충청'>충청</option>
						<option value='대전'>대전</option>
						<option value='울산'>울산</option>
						<option value='부산'>부산</option>
						<option value='경상'>경상</option>
						<option value='전라'>전라</option>
						<option value='제주'>제주</option>
					</select>
					<select name="detail" id="detail" style="width:80px; height:30px;">
					<option>-선택-</option>
					</select>
					</td>
					<td>
					<input type="submit" value="펫시터 찾기" style="width:80px; height:30px;">					
					</td>
				</tr>
			</table>
			<br>
</form>

<br><br>
<!-- 조건에 대한 결과 -->
<div id="detailmain" style="width:1300px" >
<div id="petinfo"  style="float: left; width: 50%">
검색 결과 : <%=count %> 건  

<hr>
<br>

	<div id="detail" style="overflow-x: hidden; overflow-y:scroll; height:550px;">	
		<%if(list != null) {for(Member m : list){%>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px; height: 350px" 
		onclick="location.href='/doggybeta/sitterdetail?petSitterId=<%=m.getUserId()%>&service=<%=service%>'">					
		<tr>
		<td>
		
			<div style="position: relative;">
		<%if(imglist.size() != 0) { %>
          <img src="/doggybeta/files/profile/<%=m.getTitleImg() %>" height="150px;" width="100%;">   
         <%}else{ %>
         <img src="/doggybeta/resources/imgaes/로고test2.png" height="150px;" width="100%;">
         <%} %>  
         </div>
         <div style="position: relative; top: -40px;">
         <% if(m.getUserrefile() != null) {%>
         <img src="/doggybeta/files/profile/<%= m.getUserrefile() %>" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
         <%}else{ %>
         	<img src="/doggybeta/resources/imgaes/로고test2.png" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
         <%} %>
         </div>	
         </td>
         </tr>
         <tr><td><%=m.getUserName() %>에게 서비스를 신청해보세요!</td></tr>
         <tr><td><%=m.getAddress() %></td></tr>
         <tr><td>가격 : <%=m.getPrice() %>/1일</td></tr>         
		</table>
		
		</div>
	<%}} else{ %>
	
<%} %>	
		</div>
		
		
	</div>
	<!-- detailinfo닫기 -->

</div>
<div style="float:left; width:40%;">
지도에서 주소를 확인 하세요.
<hr>
<br>
<div id="map"style="width:100%;height:350px;"></div>
</div>
<% if(list != null) {for(int i = 0; i < address.size(); i++){%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9810167e43ee638a44b19264113db0d&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();
var listData = [];
listData.unshift('<%= address.get(i)%>');
console.log(listData);
	

listData.forEach(function(addr, index){
	geocoder.addressSearch(listData, function(result, status){
		if (status === daum.maps.services.Status.OK){
			var coords = new daum.maps.LatLng(result[0].y, result[0].x);
			
			var marker = new daum.maps.Marker({
				map: map,
				position: coords
			}); //if문 닫기
			var infowindow = new daum.maps.InfoWindow({
				content: '<div style="width:150px;text-align:center;padding:6px 0;"><%= list.get(i).getUserName() %>님 거주지</div>'
				//disableAutoPan: true
			});
			infowindow.open(map, marker);
			map.setCenter(coords);
		}
	});	
});     
</script>
<%}} else{ } %>  
</div>

</div>
</div>

</div> 
</div>
		
<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	
</body>
</html>