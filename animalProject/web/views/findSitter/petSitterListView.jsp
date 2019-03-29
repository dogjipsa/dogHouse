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
	$.ajax({
		url : "/doggybeta/finding",
		data : {userid : $("#userid").val()}, //dao로 넘길 값
		type : "post",
		dataType : "json",
		success : function(data){
			console.log("성공");
			console.log(data);
			//$("#userpwd").val(data.pwd); //db에서 받아서 json에 넘긴 password
			
		}
	}); //ajax 종료
});

/* $(function(){
	$("#search").click(function(){

		$.ajax({
			type : 'post',
			cache: false,
			datatype: 'json',
			data : {userid : $("#userid").val(), 
				service : $("select[name=service]").val(), 
				jido : $("#jido").val() },
			url : '/doggybeta/fplist',
			success:function(data){
				console.log(data.list);
				 $.each(data.list, function(index){
					var items = [];			
					items.push('<td>' + '펫시터 검색' + '</td>');
					items.push('<td>' + decodeURIComponent(data.list[index].address) + '</td>');
					items.push('<td>' + data.list[index].price +'</td>');
					items.push('<td>' + decodeURIComponent(data.list[index].sitterName) + '</td>');
					items.push('<td>' + '<img src=/doggybeta/files/profile/' + data.list[index].petsitterImg + '>' + '</td>');
				 	items.push('<td>' + '<img src=/doggybeta/files/profile/' + data.list[index].houseImg + '>' + '</td>');

					$('<tr/>', {html : items}).appendTo('tbody');
				}); //each
				
			}  //success
			
			});
		});
	}); */
	
function categoryChange(e) {
	  var detail_name1 = ['강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구'];
	  var detail_name2 = ['고양','과천','광명','광주','구리','군포','김포','남양주','동두천','부천', '성남', '수원','시흥','안산','안양','오산','용인','의왕','의정부','이천','파주','평택','하남','화성','가평','양주','양평','여주','연천','포천'];
	  var target = document.getElementById("detail");
	 
	  if(e.value == "서울") var d = detail_name1;
	  else if(e.value == "경기") var d = detail_name2;

	 
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
<input type="hidden" id="userid" name="userid" value="<%=loginUser.getUserId() %>">

<form name="petinfo" method="post" action="/doggybeta/fplist">
	<!-- 조건 검색 테이블  -->	
		
 <div id="bringpetinfo">		
		<%=loginUser.getUserName() %> 님 안녕하세요!
	

</div>
 
			<table id=searchpettable>
				<tr>
					<th width="100">서비스</th>
					<th width="200">주소</th>
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
					</select>
					<select id="detail" style="width:80px; height:30px;">
					<option>-선택-</option>
					</select>
					</td>

				  	 <%--     <% if(list != null){for(SearchingInfo SI : list){ %>
				 	  
					<td><%= SI.getPetBreads() %></td>
					<td><%= SI.getPetSize() %></td>
					<td><%= SI.getAge() %> 살</td>
					<%} }%> --%>  
				</tr>
			</table>
			<br>

<input type="submit" value="펫시터 찾기">
</form>
<br><br>
<!-- 조건에 대한 결과 -->
<div id="detailmain" style="width:1400px" >
<div id="petinfo"  style="float: left; width: 50%">
상단 : 검색 결과 건수 조회
<hr>
<br>

	<div id="detail" style="overflow-x: hidden; overflow-y:scroll; height:550px;">
		<%if(list != null) {for(SearchingInfo SI : list){%>
		<div id="detailtable" style="float:left; width: 50%;">
		
		<table style="border: 1px solid #d2dee1; width: 300px; height: 300px" onclick="">			
		
		<tr>
		<td>	
			<div style="position: relative;">
         <% if(SI.getPuserHouseReImage() != null){ %>
         <img src="/doggybeta/files/profile/<%= SI.getPuserHouseReImage() %>" height="150px;" width="100%;">
         <%}else{ %>
         등록된 사진이 없습니다.
         <%} %>
         </div>
         <div style="position: relative; top: -40px;">
         <% if(SI.getPuserReFile() != null) {%>
         <img src="/doggybeta/files/profile/<%= SI.getPuserReFile() %>" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
         <%}else{ %>
         등록된 사진이 없습니다.
         <%} %>
         </div>	
         </td>
         </tr>
         <tr><td><%=SI.getPuserAddress() %></td></tr>
         <tr><td>가격 : <%=SI.getPrice() %>/1일</td></tr>
		</table>
		
		</div>
	<%} }else{ %>
<%} %>	
		</div>
		
		
	</div> -->
	<!-- detailinfo닫기 -->

</div>
</div>

<%-- <div style="float:left; width:50%;">
지도출력
<hr>
<br>
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
</div> --%>
</div> 
</div>
		
<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	
</body>
</html>