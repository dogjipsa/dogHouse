<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/history.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<style>
* {
  box-sizing: border-box;
}

body {
  background-color: #474e5d;
  font-family: Helvetica, sans-serif;
}

/* The actual timeline (the vertical ruler) */
.timeline {
  position: relative;
  max-width: 700px;
  margin: 0 auto;
}

/* The actual timeline (the vertical ruler) */
.timeline::after {
  content: '';
  position: absolute;
  width: 6px;
  background-color: white;
  top: 0;
  bottom: 0;
  left: 50%;
  margin-left: -3px;
}

/* Container around content */
.container {
  padding: 10px 40px;
  position: relative;
  background-color: inherit;
  width: 50%;
}

/* The circles on the timeline */
.container::after {
  content: '';
  position: absolute;
  width: 25px;
  height: 25px;
  right: -17px;
  background-color: white;
  border: 4px solid #2ec4b6;
  top: 15px;
  border-radius: 50%;
  z-index: 1;
}

/* Place the container to the left */
.left {
  left: 0;
}

/* Place the container to the right */
.right {
  left: 50%;
}

/* Add arrows to the left container (pointing right) */
.left::before {
  content: " ";
  height: 0;
  position: absolute;
  top: 22px;
  width: 0;
  z-index: 1;
  right: 30px;
  border: medium solid white;
  border-width: 10px 0 10px 10px;
  border-color: transparent transparent transparent white;
}

/* Add arrows to the right container (pointing left) */
.right::before {
  content: " ";
  height: 0;
  position: absolute;
  top: 22px;
  width: 0;
  z-index: 1;
  left: 30px;
  border: medium solid white;
  border-width: 10px 10px 10px 0;
  border-color: transparent white transparent transparent;
}

/* Fix the circle for containers on the right side */
.right::after {
  left: -16px;
}

/* The actual content */
.content {
  padding: 20px 30px;
  background-color: white;
  position: relative;
  border-radius: 6px;
  font-family: 'Sunflower', 'sans-serif';
  font-size: 13pt;
  font-weight: 200;
}

/* Media queries - Responsive timeline on screens less than 600px wide */
@media screen and (max-width: 600px) {
  /* Place the timelime to the left */
  .timeline::after {
  left: 31px;
  }
  
  /* Full-width containers */
  .container {
  width: 100%;
  padding-left: 70px;
  padding-right: 25px;
  }
  
  /* Make sure that all arrows are pointing leftwards */
  .container::before {
  left: 60px;
  border: medium solid white;
  border-width: 10px 10px 10px 0;
  border-color: transparent white transparent transparent;
  }

  /* Make sure all circles are at the same spot */
  .left::after, .right::after {
  left: 15px;
  }
  
  /* Make all right containers behave like the left ones */
  .right {
  left: 0%;
  }
}
</style>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
   <div id="wrap">
        <div id="content">
<div class="timeline">
  <div class="container left">
    <div class="content">
      <h2>2019.04</h2>
      <p>도그하우스 웹 사이트가 런칭되었습니다. <br>대한민국 애견인에게 양질의 펫시터 매칭 서비스를 제공합니다.</p>
    </div>
  </div>
  <div class="container right">
    <div class="content">
      <h2>2019.02</h2>
      <p>도그하우스 사이트 설계 및 기능 구현</p>
    </div>
  </div>
  <div class="container left">
    <div class="content">
           <h2>2019.02</h2>
      <p>팀 도그집사 탄생!</p>
    </div>
  </div>
  <div class="container right" style="visibility:hidden;">
    <div class="content">
      <h2>2019.02</h2>
      <p>도그하우스 사이트 설계 및 기능 구현</p>
    </div>
  </div> 
  <div class="container left" style="visibility:hidden;">
    <div class="content">
           <h2>2019.02</h2>
      <p>팀 도그집사 탄생!</p>
    </div>
  </div>
</div>


</div>
<%-- <div id="footer"><%@ include file="..//common/footer.jsp"%></div> --%>   
</div>   
</body>
</html>