<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/doggybeta/resources/css/manager/managerLoginMenu.css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	$.ajax({
		url: '/doggybeta/mantbtop',
		type: 'post',
		cache: false,
		datatype: 'json',
		success: function(data) {
			console.log('성공!');
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			$.each(data.tipboardlist, function(i) {
				var items = [];
				items.push('<td style="width: 100px;">팁</td>');
				items.push('<td style="width: 100px;">' + json.tipboardlist[i].tnum + '</td>');
				items.push("<td style='width: 300px'><a href='/doggybeta/mantbdetail?fnum="+ json.tipboardlist[i].tnum +"&page=1'>" 
						+ decodeURIComponent(json.tipboardlist[i].ttitle).replace(/\+/gi, " ") + '</td>');
				items.push('<td style="width: 100px;">' + json.tipboardlist[i].trcount + '</td>');
				$('<tr/>', {
					html: items
				}).appendTo('#toptb');
			}); //each
		},//success
		error : function(data) {
			alert('에러!');
		}
	});//ajax
	return false;
});
</script>
</head>
<body>
<div>
<h3 id='tbh'>팁 게시판 최신글</h3>
<table class='tfree' style="text-align:center; border:1px solid #dddddd">
	<thead> 
		<tr>
			<th style="background-color: #eeeeee; text-align: center;">분류</th>
			<th style="background-color: #eeeeee; text-align: center;">글번호</th>
			<th style="background-color: #eeeeee; text-align: center;">제목</th>
			<th style="background-color: #eeeeee; text-align: center;">조회수</th>
		</tr>
	</thead>
	<tbody id='toptb'>
	</tbody>
</table>
</div>
</body>
</html>