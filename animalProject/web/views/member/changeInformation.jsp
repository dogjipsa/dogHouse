<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp" %>
<%
	String addr = (String)request.getAttribute("addr");
	String extra = (String)request.getAttribute("extra");
	String daddr = (String)request.getAttribute("daddr");
	String postcode = (String)request.getAttribute("postcode");
	System.out.println("jsp 주소값 : " + addr);
	System.out.println("jsp 주소값 : " + daddr);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9810167e43ee638a44b19264113db0d&libraries=services"></script>
<script src="/doggybeta/resources/js/addrUpdate.js"></script>
<script type="text/javascript">
function okbtn(){
  alert("회원 정보가 수정되었습니다. 다시 로그인 해주세요.");

}
$(function(){
   //암호와 아이디는 동일하면 안 된다.
   $("#userpwd").blur(function(){
      console.log("포커스 사라짐");
      var pwd1 = $("#userid").val();
      var pwd2 = $("#userpwd").val();
      
      if(pwd1 == pwd2){
         alert("ID와 암호는 반드시 달라야 합니다.\n" + "다시 입력하십시요.");
         $("#userid").select();
      }
   });
});

$(function(){
   $('#email').blur(function(){
      console.log("포커스 사라짐");
      var email = $('#email').val();
      var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
      
      if(regEmail.test(email)==false){
         alert("이메일 형식이 올바르지 않습니다.");      
         return false;
      }
      
   })
})
$(function(){
       $("#phone").on('keydown', function(e){
          // 숫자만 입력받기
       var trans_num = $('#phone').val().replace(/-/gi,'');
      var k = e.keyCode;
               
      if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687) || k==32 || k==229 || (k>=45032 && k<=55203)))
      {
            e.preventDefault();
      }
      //function(e) 시작
       }).on('blur', function() { // 포커스를 잃었을때 
           if($('#phone').val() == '') return;
           // 기존 번호에서 - 를 삭제
           var trans_num = $('#phone').val().replace(/-/gi,'');
         
           // 입력값이 있을때만 실행
           if(trans_num != null && trans_num != '') {
               // 총 핸드폰 자리수는 11글자이거나, 10자
               if(trans_num.length==11 || trans_num.length==10) {   
                   // 유효성 체크
                   var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                   if(regExp_ctn.test(trans_num)) {
                       // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿈
                       trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                       $('#phone').val(trans_num);
                   } else {
                       alert("유효하지 않은 전화번호 입니다.");
                       $('#phone').val("");
                       $('#phone').focus();
                       }
               } else {
                   alert("유효하지 않은 전화번호 입니다.");
                   $('#phone').val("");
                   $('#phone').focus();
               }
         }
     });  
       return false;
   }); //phone 유효성 함수 close

function deletebtn(){
   alert("확인");
   console.log("확인");
    if(confirm('정말로 탈퇴하시겠습니까?')) {
           $.ajax({
               url: '/doggybeta/delmember',
               type: "POST",
               data: {
                   userid : $("#userid").val()
               },
               success: function (data) {
                  if(data == "ok"){
                     alert("성공!");
                  location.href='/doggybeta/jipsalogout';
                  }
                  else alert("실패!");
               }
           });
       }
}

</script>
<style type="text/css">

/* 화면에 보여지는 글 목록 테이블 */

.board { 
   position: relative;
   left : 150px;
   border-collapse: collapse;   
   line-height: 1.5;
   table-layout:fixed; 
   
}

#title{
   text-align: left;
   font-weight: bold;
}

.board tr{ 
   padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
    }

/* list_table 에서 사용되는 tbody */
.board th{ 
   width: 180px;
    padding: 5px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;   
    
}
#write input[type="text"], select{
   border: none;
   width: 150px;
    padding: 10px;
    text-align: center;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.board #write:hover{
   background-color : #f3f6f7;
}
header{    
   padding: 2rem 0px;
}
#buttons{
   position: relative;
   display: inline;
   left : 200px;
   width: 100px;
   height: 40px;
}


</style>
</head>

<body>
<%@ include file="../common/menu.jsp"%>
   <div id="wrap">
        <div id="content" style="font-family:Sunflower;">
      


<header>
<h2 style="padding-botom:0px; text-align:center;"><%= loginUser.getUserId() %> 님, 회원 정보 상세보기</h5>
</header>
<br>
<!-- 수정용 폼 태그 -->
<form method="post" action="/doggybeta/changeinfo">
   <table class="board">
         <tr>
            <th id="title">ID</th>
            <th id="write">
            <% if(loginUser.getNaverCode() != null) { %>
            <input type="text" readonly name="userid" id="userid" value="<%=loginUser.getEmail() %>">
            <%}else{ %>
            <input type="text"  readonly name="userid" id="userid" value="<%=loginUser.getUserId() %>">
            <%} %>
            </th>
         </tr>   
         <tr>
            <th id="title">이름</th>
            <th id="write"><input type="text" name="username" readonly value="<%=loginUser.getUserName() %>"></th>
         </tr> 
         <tr>
            <th id="title">비밀번호</th>
            <th id="write"><input type="password" name="userpwd" id="userpwd"value="<%= loginUser.getUserPwd() %>"></th>
         </tr>
         <tr>
            <th id="title">휴대폰번호</th>
            <th id="write"><input type="text" name="phone" id="phone" value="<%=loginUser.getPhone() %>"></th>
         </tr> 
         <tr>
            <th id="title">생년월일</th>
            <th id="write"><input type="text" name="birth" readonly value="<%=loginUser.getUserDate() %>"></th>
         </tr> 
         <tr>
            <th id="title">이메일</th>
            <th id="write">
             <% if(loginUser.getNaverCode() != null) { %>          
            <input type="text" name="email"  readonly value="<%=loginUser.getEmail() %>">
            <%}else{ %>
            <input type="text" name="email" id="email" value="<%=loginUser.getEmail() %>">
            <%} %>
            </th>
         </tr> 
         <tr>
            <th id="title">주소</th>
            <th id="write">
            
            <div id="addrUpdate">
            <%if(loginUser.getAddress() == null) {%>
         <input name="postcode" id="info_postcode" class="ps_input" placeholder="우편번호" required>
         <input type="button" onclick="info_execDaumPostcode()" id="post-search" value="우편번호 찾기">
         <input name="addr" id="info_address" class="ps_input input_addr" placeholder="주소" required>
         <input name="daddr" id="info_detailAddress" class="ps_input" placeholder="상세주소" required>
         <input name="extra" id="info_extraAddress" class="ps_input" placeholder="참고항목" readonly>
         <%}else{ %>
         <%=loginUser.getAddress() %>
         <input name="postcode" id="info_postcode" class="ps_input" placeholder="우편번호" >
         <input type="button" onclick="info_execDaumPostcode()" id="post-search" value="주소 다시 등록하기" style="width:180px;">
         <input name="addr" id="info_address" class="ps_input input_addr" placeholder="주소" >
         <input name="daddr" id="info_detailAddress" class="ps_input" placeholder="상세주소" >
         <input name="extra" id="info_extraAddress" class="ps_input" placeholder="참고항목" >
         <%} %>
            </div>
         
            </th>
         </tr> 
         <tr>
            <th id="title">직업</th>
            <th id="write">
            <select name="job">
               <%if(loginUser.getJob().equals("0")) {%>
               <OPTION VALUE=0 selected>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
               <%}else if(loginUser.getJob().equals("1")){%>
               <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 selected>직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else if(loginUser.getJob().equals("2")){%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2 selected>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else if(loginUser.getJob().equals("3")){%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3 selected>프리랜서</OPTION>
              <OPTION VALUE=4>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else if(loginUser.getJob().equals("4")){%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4 selected>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else if(loginUser.getJob().equals("5")){%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4 selected>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else if(loginUser.getJob().equals("6")){%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4 selected>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%}else{%>
              <OPTION VALUE=0>직업을 선택하세요.</OPTION>
               <OPTION VALUE=1 >직장인</OPTION>
               <OPTION VALUE=2>사업</OPTION>
              <OPTION VALUE=3>프리랜서</OPTION>
              <OPTION VALUE=4 selected>학생</OPTION>
              <OPTION VALUE=5>주부</OPTION>
              <OPTION VALUE=6>기타</OPTION>
              <OPTION VALUE=7>무직</OPTION>
              <%} %>
            </select>
            </th>
         </tr> 
     
</table>
<br>         
<!-- 테이블 종료 -->
<div id="buttons">
<input type="submit" value="정보수정하기" onclick="okbtn();">
<input type="button" id="deletebtn" value="탈퇴하기">
<input type="submit" value="메인으로" onclick="location.href='/doggybeta/jipsalogout'">
</div>
</form>


</div>
</div>

</body>
</html>