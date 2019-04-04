<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="review.model.vo.Review, java.util.ArrayList" %>
<%
ArrayList<Review> list = (ArrayList<Review>) request.getAttribute("list");
int listCount = ((Integer) request.getAttribute("listCount")).intValue();
int startPage = ((Integer) request.getAttribute("startPage")).intValue();
int endPage = ((Integer) request.getAttribute("endPage")).intValue();
int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
String puserid = (String)(request.getAttribute("puserid"));
System.out.println("startpage"+startPage);
System.out.println("endPage"+endPage);
System.out.println("maxPage"+maxPage);
System.out.println("currentPage"+currentPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script src="/doggybeta/resources/js/jquery.star-rating-svg.js"></script>
<link rel="stylesheet" type="text/css" href="/doggybeta/resources/css/star-rating-svg.css">
<style>

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

/* list_table 에서 사용되는 thead */
.board thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}

/* list_table 에서 사용되는 tbody */
.board tbody td { 
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


</style>

</head>
<body>

<table class="board" id="reviewboard">
      <thead>
         <tr>
            <th width="120" colspan='2'>후기(<%=listCount %>건)</th>
            <!-- <th width="50"></th> -->
            <th width="350"></th>
            <th width="100"><div id="listlink" class="listlink"></div></th>
         </tr>   
      </thead>
      <tbody>
      			<%
					for (Review r : list) {
				%>
				<tr>
					<%-- <td align="center"><%=r.getPoint()%></td> --%>
					<td align="center"><div class="my-rating"><%-- <input type="hidden" class="star" value="<%=r.getPoint()%>"> --%></div></td>
					<script type="text/javascript">
					 $(".my-rating").starRating({
						 		readOnly: true,
							    starSize: 11,
							    initialRating: <%=r.getPoint()%>,						    
							    
					});
					
					 
					</script>
					<td align="center"><%=r.getUserId() %></td>
					<td align="center"><%=r.getReviewContent()%></td>
					<td align="center"><%=r.getReviewDate()%></td>
				</tr>
				<%
					} //for each
				%>
				
				
      </tbody>
</table>


<div class="rpage" style="text-align: center; position:relative; padding-top:30px;">
				<%
					if (currentPage <= 1) {
				%>
				◀◀&nbsp;
				<%
					} else {  
						%>
								<a href="/doggybeta/ralllist?page=<%=1%>&puserid=<%=puserid%>">◀◀</a>
				<%	}%>
				
				<%
					if ((currentPage - 10) <= startPage && (currentPage - 10) >= 1) {//조건식에 =을 붙여줘야 11,21,31....페이지 일 때 링크가 뜸
						%>
							<a href="/doggybeta/ralllist?page=<%=startPage - 1%>&puserid=<%=puserid%>">◀</a>
				<%
					} else {
				%>
				◀
				<%
					}
				%>
				<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
					<%
					for (int p = startPage; p <= endPage; p++) {
						if (p == currentPage) {	%>
							<font color="red" size="4"><b>[<%=p%>]
							</b></font>
							<%
						} else {%>
								<a href="/doggybeta/ralllist?page=<%=p%>&puserid=<%=puserid%>"><%=p%></a>
						<%}
					}
					
				%>&nbsp;
				<%
					if (endPage < maxPage) {
				%>
							<a href="/doggybeta/ralllist?page=<%=endPage + 1%>&puserid=<%=puserid%>">▶</a>
				<%
					} else {
				%>
				▶&nbsp;
				<%
					}
				%>
				<%
					if (currentPage >= maxPage) {
				%>
				▶▶
				<%
					} else {
				%>
						<a href="/doggybeta/ralllist?page=<%=maxPage%>&puserid=<%=puserid%>">▶▶</a>
				<%
					}
				%>

			</div>
</body>
</html>