<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10X10 COMPANY</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/content.css" />
<!--[if lt IE 9]>
<script type="text/javascript" src="/lib/js/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
<script type="text/javascript" src="/lib/js/common.js"></script>
<script type="text/javascript" src="/lib/js/tenbytencommon.js?v=1.0"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=523d793577f1c5116aacc1452942a0e5&libraries=services"></script>
<script>
$(function(){
	//$(".intro").delay(300).animate({backgroundSize:'1985px'},1500);
	// history
	var historySwiper = new Swiper('.history .swiper-container',{
		slidesPerView:'auto',
		speed:700,
		pagination:'.history .pagination',
		paginationClickable:true,
		resizeReInit:true,
		calculateHeight:true
	})
	$('.history .btnPrev').on('click', function(e){
		e.preventDefault();
		historySwiper.swipePrev();
	})
	$('.history .btnNext').on('click', function(e){
		e.preventDefault();
		historySwiper.swipeNext();
	});

	var introH = $(".intro").height();
	$(".container").css('padding-top', introH);
	$(".intro").css('height', $(window).height());
	$(window).resize(function() {
		$(".container").css('padding-top', introH);
		$(".intro").css('height', $(window).height());
	});

	// animation */
	animation1()
	$(".intro .desc").css("cssText", "opacity:0;");
	function animation1() {
		$(".intro .desc").delay(1300).animate({"opacity":"1"},1500);
	}

	// 최초 지도 표시
	initialize();
});

$(window).scroll(function(event) {
	if($(window).scrollTop() + $(window).height()+200 > $(document).height()) {
		$(".main .intro").addClass('hideBg');
	} else {
		$(".main .intro").removeClass('hideBg');
	}
});

function initialize(rtaddr,nm,dttel,lyNum) {
	if(!rtaddr) rtaddr="서울시 종로구 대학로 12길 31 자유빌딩 5층";
	if(!nm)		nm="텐바이텐 본사";
	if(!lyNum)	lyNum="1";
	if(!dttel)	dttel="02-741-9010";

	if(rtaddr=="부산광역시 중구 광복로 79-1"){
		 $("#dtaddr").empty().html(rtaddr+" 롯데엘큐브 1층");
	}else{
		$("#dtaddr").empty().html(rtaddr);
	}
	$('#defmapaddr').val(rtaddr);

	$("#dttel").empty().html(dttel);
	$("#dttelm").empty().html(dttel);
	
	$("#mapView"+lyNum).empty();
	
	setTimeout(function() {
		var mapContainer = document.getElementById('mapView'+lyNum),
			mapOption = {
				center: new daum.maps.LatLng(37.582708, 127.003605), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};

		// 지도 생성
		var map = new daum.maps.Map(mapContainer, mapOption); 

		var geocoder = new daum.maps.services.Geocoder();	// 주소-좌표 변환 객체를 생성
		var addr=rtaddr;
		var lat="";
		var lng="";
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {
			if (status === daum.maps.services.Status.OK) {
				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
				var marker = new daum.maps.Marker({
					map: map,
					position: coords
				});

				// 인포윈도우로 장소에 대한 설명을 표시
				var infowindow = new daum.maps.InfoWindow({
					content: '<div style="width:150px;text-align:center;padding:6px 0;">'+nm+'</div>'
				});
				infowindow.open(map, marker);

				// 지도의 중심을 결과값으로 받은 위치로 이동
				map.setCenter(coords);
			} 
		});
	}, 200);
}

function geocodenew() {
	var address = "";
	var addrurl = "";
	address = $('#defmapaddr').val();
	addrurl = "http://map.daum.net/link/search/"+address;
	window.open(addrurl, "_blank");
}

function mobileoffmap(results) {

		if(results=='대학로점'){
			initialize('서울특별시 종로구 대학로12길 31 자유빌딩 1층','대학로점','02-741-9010','3');
		}
	
		if(results=='건대커먼그라운드점'){
			initialize('서울특별시 광진구 아차산로 200 커먼그라운드 SM동 2층','건대커먼그라운드점','02-2122-1254','3');
		}
	
		if(results=='고양스타필드점'){
			initialize('경기도 고양시 덕양구 고양대로 1972-8 스타필드고양점 2층','고양스타필드점','031-5173-2024','3');
		}
	
		if(results=='텐텐문방구'){
			initialize('서울특별시 종로구 동숭동 1-45 자유빌딩 2층','텐텐문방구','','3');
		}
	
		if(results=='텐바이텐제주점'){
			initialize('제주 제주시 신성로13길 14-1(이도이동 1층)','텐바이텐제주점','010-4785-1693','3');
		}
	
		if(results=='텐바이텐 신제주점'){
			initialize('제주특별자치도 제주시 연동7길 26 1층','텐바이텐 신제주점','064-755-1693','3');
		}
	
		if(results=='텐바이텐 서귀포점'){
			initialize('제주특별자치도 서귀포시 이중섭로 1(서귀동)번지','텐바이텐 서귀포점','064-763-1693','3');
		}
	
}

</script>
</head>
<body>
<div class="wrap main">
	
<div class="headWrap">
	<div class="header">
		<h1><a href="/"><img src="http://fiximage.10x10.co.kr/company/common/logo_10x10.png" alt="10X10" /></a></h1>
		<button class="btnNav"><i></i><i></i><i></i></button>
		<div class="gnb">
			<ul>
				<li  class='current'><a href="/"><span>텐바이텐 소개</span></a></li>
				<li ><a href="/Business/Index/"><span>사업영역</span></a></li>
				<li ><a href="/Recruit/Index/"><span>인재 채용<em class="icoNew">N</em></span></a></li>
			</ul>
		</div>
	</div>
</div>
	<div class="container">
		<h2 class="hidden">텐바이텐 소개</h2>
		<!-- INTRO -->
		<div class="intro">
			<div class="title desktop-only">
				<h3><em class="letter1">색다른 즐거움을 전하는</em><br /><em class="letter2">감성 기업</em></h3>
				<p class="desc">텐바이텐은 디자인을 좋아하는 고객에게 색다른 즐거움을 선물함으로써<br />그들의 일상이 따뜻하고 행복한 경험으로 채워지기를 꿈꿉니다.</p>
			</div>
			<div class="title mobile-only">
				<h3><em class="letter1">색다른</em><br /><em class="letter2">즐거움을 전하는</em><br /><em class="letter3">감성 기업</em></h3>
				<p class="desc">텐바이텐은 디자인을 좋아하는 고객에게<br />색다른 즐거움을 선물함으로써 그들의 일상이<br />따뜻하고 행복한 경험으로 채워지기를 꿈꿉니다.</p>
			</div>
			<a href="#contents" class="btnGo"><img src="http://fiximage.10x10.co.kr/company/main/btn_bottom_m.png" alt="" /></a>
		</div>
		<!--// INTRO -->

		<div id="contents" class="contents">
			<!-- 10x10 DNA -->
			<div class="section dna">
				<h3>10X10 DNA</h3>
				<ul>
					<li class="d01">
						<i class="icon"><img src="http://fiximage.10x10.co.kr/company/main/ico_dna_01.gif" alt="" /></i>
						<strong><em>D</em>ifferent Contents</strong>
						<p>다르게 보고, <br />제안하고, 도전하자</p>
					</li>
					<li class="d02">
						<i class="icon"><img src="http://fiximage.10x10.co.kr/company/main/ico_dna_02.gif" alt="" /></i>
						<strong><em>N</em>ew Trend</strong>
						<p>트렌드와 라이프스타일의 <br />전문가가 되자</p>
					</li>
					<li class="d03">
						<i class="icon"><img src="http://fiximage.10x10.co.kr/company/main/ico_dna_03.gif" alt="" /></i>
						<strong><em>A</em>ttractive Emotion</strong>
						<p>즐겁고 신나는 <br />감성놀이터를 만들자</p>
					</li>
				</ul>
			</div>
			<!--// 10x10 DNA -->

			<!-- 10x10 STORY -->
			<div class="section story">
				<h3>10X10 STORY</h3>
				<div class="desktop-only txt">
					<p>2001년, 건축학을 전공한 대학 동기 다섯 명이 모여 '텐바이텐'을 만들었습니다.<br />디자인 쇼핑몰이라는 개념이 생소하던 시절, 다양한 취향을 만족시킬 수 있는 독특한 상품들을<br />보편화하고 싶다는 바람으로 시작하게 되었습니다. '디자인 감성채널'이라는 카피에 걸맞게,<br />고객의 감성을 충족시키기 위하여 언제나 노력하고 있으며 고객과의 공감을 가장 중요하게 생각합니다.<br />&quot;You're already different&quot;라는 슬로건처럼, 단지 우리만 특별한 것이 아닌 텐바이텐을<br />이용하는 모든 고객이 자부심을 가질 수 있도록 하는 게 목표이며,<br />늘 새로운 것을 시도하고, 신뢰받는 기업이 되고자 합니다.</p>
				</div>
				<div class="mobile-only txt">
					<p>2001년, 건축학을 전공한 대학 동기<br />다섯 명이 모여 '텐바이텐'을 만들었습니다.<br />디자인 쇼핑몰이라는 개념이 생소하던 시절,<br />다양한 취향을 만족시킬 수 있는 독특한 상품들을<br />보편화하고 싶다는 바람으로 시작하게 되었습니다.</p>
					<p>&quot;You're already different&quot;라는 슬로건처럼,<br />단지 우리만 특별한 것이 아닌 텐바이텐을 이용하는<br />모든 고객이 자부심을 가질 수 있도록 하는 게 목표이며,<br />늘 새로운 것을 시도하고, 신뢰받는 기업이 되고자 합니다.</p>
				</div>
				<div class="bg"><img src="http://fiximage.10x10.co.kr/company/main/bg_story_m.jpg" alt="" /></div>
			</div>
			<!--// 10x10 STORY -->

			<!-- HISTORY -->
			<div class="section history">
				<h3>HISTORY</h3>
				<p class="desc">우리는 꾸준히 성장하고 있습니다</p>
				<div class="swiper">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div id="history1" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_06.jpg" alt="" />
									<p class="year"><span>2016~</span></p>
								</div>
								<dl>
									<dt>2017.12</dt>
									<dd>i-AWARDKOREA 11년 연속 대상</dd>
									<dt>2017.08</dt>
									<dd>고양스타필드점 매장 오픈</dd>
									<!--
									<dt>2017.06</dt>
									<dd>DDP점 매장 오픈</dd>
									-->
									<dt>2017.05 </dt>
									<dd>부산광복엘큐브점 매장 오픈</dd>
									<dt>2017.04</dt>
									<dd>건대커먼그라운드점 매장 오픈</dd>
									<dt>2016.11</dt>
									<dd>일산, 서귀포점 매장 오픈</dd>
									<!--
									<dt>2016.09</dt>
									<dd>더핑거스  확장 리뉴얼 오픈<br />(www.thefingers.co.kr)</dd>
									-->
								</dl>
							</div>
							<div id="history2" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_05.jpg" alt="" />
									<p class="year"><span>2015~2013</span></p>
								</div>
								<dl>
									<!-- 20180808 중문몰 서비스 종료
									<dt>2015.11</dt>
									<dd>텐바이텐 중문몰 오픈<br />(www.10x10shop.com)</dd>
									-->
									<dt>2015.02</dt>
									<dd>신제주점  매장 오픈</dd>
									<dt>2014.04</dt>
									<dd>텐바이텐 모바일 앱 출시</dd>
									<dt>2013.10</dt>
									<dd>GS그룹 계열사로 편입</dd>
									<dt>2013.08</dt>
									<dd>최은희 대표이사 취임</dd>
								</dl>
							</div>
							<div id="history3" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_04.jpg" alt="" />
									<p class="year"><span>2012~2010</span></p>
								</div>
								<dl>
									<dt>2012.05</dt>
									<dd>제주점  매장 오픈</dd>
									<!--
									<dt>2011.12</dt>
									<dd>김포롯데점 매장 오픈</dd>
									-->
									<dt>2010.05</dt>
									<dd>㈜산돌커뮤니케이션, ㈜산톨티움과 업무제휴 MOU 체결</dd>
									<dt>2010.02</dt>
									<dd>텐바이텐 모바일웹 오픈 (m.10x10.co.kr)</dd>
								</dl>
							</div>
							<div id="history4" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_03.jpg" alt="" />
									<p class="year"><span>2009~2007</span></p>
								</div>
								<dl>
									<dt>2008.01</dt>
									<dd>MBC 무한도전 달력 온라인 독점 판매</dd>
									<dt>2007.09</dt>
									<dd>ITHINKSO 브랜드 런칭</dd>
								</dl>
							</div>
							<div id="history5" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_02.jpg" alt="" />
									<p class="year"><span>2006~2004</span></p>
								</div>
								<dl>
									<dt>2006.10</dt>
									<dd>격월지 히치하이커 발간</dd>
									<dt>2006.04</dt>
									<dd>핑거스아카데미 서비스 개시</dd>
									<dt>2004.06</dt>
									<dd>전문몰 위탁 판매제휴 운영 시작 (야후, 네이트 등)</dd>
								</dl>
							</div>
							<div id="history6" class="swiper-slide">
								<div class="thumbnail">
									<img src="http://fiximage.10x10.co.kr/company/main/img_history_01.jpg" alt="" />
									<p class="year"><span>2003~2001</span></p>
								</div>
								<dl>
									<dt>2003.09</dt>
									<dd>1호 매장 대학로점 오픈</dd>
									<dt>2003.01</dt>
									<dd>㈜텐바이텐으로 사명 변경</dd>
									<dt>2001.10</dt>
									<dd>디자인 전문 쇼핑몰 텐바이텐 서비스 개시(www.10x10.co.kr)</dd>
									<dt>2001.08</dt>
									<dd>㈜큐브커뮤니모우션 설립, 전자 상 거래 사업 진출</dd>
								</dl>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
					<button id="historybtn1" class="slideNav btnPrev">이전</button>
					<button id="historybtn2" class="slideNav btnNext">다음</button>
				</div>
				<a href="/tenbyten_kor_20171025.pdf" class="btn btnB btnBlk btnDownload desktop-only">회사 소개서 다운받기<i></i></a>
			</div>
			<!--// HISTORY -->

			<!-- 10X10 FONT -->
			<div class="section font">
				<h3>10X10 FONT</h3>
				<p class="desc">텐바이텐과 ㈜산돌커뮤니케이션이 <br />오랜 연구 끝에 완성한 10X10폰트를 소개합니다</p>
				<div class="preview"><img src="http://fiximage.10x10.co.kr/company/main/txt_font_m.png" alt="폰트 예시 이미지" /></div>
				<div class="btnGroup desktop-only">
					<a href="javascript:fileDownload(1795);" class="btn btnB btnBdr btnDownload">TTF 윈도우용 다운로드 <i></i></a>
					<a href="javascript:fileDownload(1796);" class="btn btnB btnBdr btnDownload">OTF 맥용 다운로드 <i></i></a>
				</div>
				<p class="caution desktop-only"><span>!</span>10X10폰트는 기업의 영리적, 상업적 목적으로 사용이 불가합니다. 이 점 양해 부탁드립니다.</p>
				<p class="caution mobile-only"><span>!</span>10x10폰트는 PC에서 다운받으실 수 있습니다.</p>
			</div>
			<!--// 10X10 FONT -->

			<!-- LOCATION -->
			<div class="section location">
				<div class="cont">
					<h3>LOCATIONS</h3>
					<div class="tab">
						<ul class="tabNav">
							<li name="shop01" onclick="initialize('서울시 종로구 대학로 12길 31 자유빌딩 1층','텐바이텐 본사','','1');" class="current">텐바이텐 본사</li>
							<li name="shop02" onclick="initialize('서울시 도봉구 도봉로180길 31','물류센터','','2');">물류센터</li>
							<li name="shop03" onclick="initialize('서울시 종로구 대학로 12길 31 자유빌딩 1층','대학로점','','3');">오프라인 매장</li>
						</ul>
						<div class="tabContainer">
							<!-- 텐바이텐 본사 -->
							<div id="shop01" class="tabCont">
								<input type="hidden" name="defmapaddr" value="서울시 종로구 대학로 12길 31 자유빌딩 5층" id="defmapaddr">
								<div class="map" id="mapView1"></div>
								<div class="shopInfo">
									<dl class="address">
										<dt>주소<span></span></dt>
										<dd>
											<p>서울시 종로구 대학로 12길 31 자유빌딩 5층 (주)텐바이텐</p>
											<a href="" onclick="geocodenew(); return false;" class="btn btnMap">지도 바로가기<span></span></a>
										</dd>
									</dl>
									<dl class="cs">
										<dt>고객센터<span></span></dt>
										<dd>
											<p class="tel">
												<em class="desktop-only">1644-6030 <span>(평일 : 9시 ~ 6시 / 토, 일, 공휴일 휴무)</span></em>
												<em class="mobile-only"><a href="tel:16446030" >1644-6030</a> <span>(평일 : 9시 ~ 6시 / 토, 일, 공휴일 휴무)</span></em>
											</p>
											<a href="mailto:customer@10x10.co.kr">customer@10x10.co.kr</a>
										</dd>
									</dl>
								</div>
							</div>

							<!-- 물류센터 -->
							<div id="shop02" class="tabCont">
								<div class="map" id="mapView2"></div>
								<div class="shopInfo">
									<dl class="address">
										<dt>주소<span></span></dt>
										<dd>
											<p>서울시 도봉구 도봉로180길 31 여인닷컴 3층</p>
											<a href="" onclick="geocodenew(); return false;" class="btn btnMap">지도 바로가기<span></span></a>
										</dd>
									</dl>
								</div>
							</div>

							<!-- 오프라인 매장 -->
							<div id="shop03" class="tabCont">
								<div class="map" id="mapView3"></div>
								<div class="shopInfo">
									<div class="selectbox desktop-only" style="width:228px;">
										<p>대학로점</p>
										
										<ul>
											
											<li onclick="initialize('서울특별시 종로구 대학로12길 31 자유빌딩 1층','대학로점','02-741-9010','3');">대학로점</li>
											
											<li onclick="initialize('서울특별시 광진구 아차산로 200 커먼그라운드 SM동 2층','건대커먼그라운드점','02-2122-1254','3');">건대커먼그라운드점</li>
											
											<li onclick="initialize('경기도 고양시 덕양구 고양대로 1972-8 스타필드고양점 2층','고양스타필드점','031-5173-2024','3');">고양스타필드점</li>
											
											<li onclick="initialize('서울특별시 종로구 동숭동 1-45 자유빌딩 2층','텐텐문방구','','3');">텐텐문방구</li>
											
											<li onclick="initialize('제주 제주시 신성로13길 14-1(이도이동 1층)','텐바이텐제주점','010-4785-1693','3');">텐바이텐제주점</li>
											
											<li onclick="initialize('제주특별자치도 제주시 연동7길 26 1층','텐바이텐 신제주점','064-755-1693','3');">텐바이텐 신제주점</li>
											
											<li onclick="initialize('제주특별자치도 서귀포시 이중섭로 1(서귀동)번지','텐바이텐 서귀포점','064-763-1693','3');">텐바이텐 서귀포점</li>
											
										</ul>
										
									</div>
									<select class="mobile-only" onchange="mobileoffmap(this.value);">
										
										<option value="대학로점">대학로점</option>
										
										<option value="건대커먼그라운드점">건대커먼그라운드점</option>
										
										<option value="고양스타필드점">고양스타필드점</option>
										
										<option value="텐텐문방구">텐텐문방구</option>
										
										<option value="텐바이텐제주점">텐바이텐제주점</option>
										
										<option value="텐바이텐 신제주점">텐바이텐 신제주점</option>
										
										<option value="텐바이텐 서귀포점">텐바이텐 서귀포점</option>
										
									</select>
									<dl class="address">
										<dt>주소<span></span></dt>
										<dd>
											<p id="dtaddr">서울시 종로구 대학로 12길 31 자유빌딩 5층 (주)텐바이텐</p>
											<a href="" onclick="geocodenew(); return false;" class="btn btnMap">지도 바로가기<span></span></a>
										</dd>
									</dl>
									<dl class="cs">
										<dt>매장 문의<span></span></dt>
										<dd>
											<p class="tel">
												<em  id="dttel" class="desktop-only">02-741-9010</em>
												<em id="dttelm" class="mobile-only"><a href="tel:16446030" >02-741-9010</a></em>
											</p>
										</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--// LOCATION -->

		</div>
	</div>
	<div class="footerWrap">
	<div class="footer">
		<p class="copyright">COPYRIGHT© 10x10.co.kr ALL RIGHTS RESERVED.</p>
		<div class="footLink">
			<ul class="share">
				<li class="facebook"><a href="https://www.facebook.com/your10x10" target="_blank">페이스북으로 이동</a></li>
				<li class="instagram"><a href="https://instagram.com/your10x10" target="_blank">인스타그램으로 이동</a></li>
				<li class="pinterest"><a href="https://www.pinterest.com/your10x10" target="_blank">핀터레스트로 이동</a></li>
			</ul>
			<ul class="familysite">
				<li><a href="http://www.10x10.co.kr" target="_blank">텐바이텐</a></li>
				<!-- 2018.8.5 서비스 종료
				<li><a href="http://www.10x10shop.com/" target="_blank">텐바이텐 CHINA</a></li>
				<!-- 2017.10.1 서비스 종료
				<li><a href="http://www.thefingers.co.kr/" target="_blank">더핑거스</a></li>
				-->
			</ul>
		</div>
	</div>
</div>
<p id="btnGotop" class="btnGotop"><span></span>TOP</p>
	<div id="layerMask" class="layerMask"></div>
	<div class="btmBg"></div>
</div>

</body>
</html>