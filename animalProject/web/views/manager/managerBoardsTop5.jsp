<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		url: '/doggybeta/mfreetop',
		type: 'post',
		cache: false,
		datatype: 'json',
		success: function(data) {
			console.log('성공!');
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			$.each(data.freeboardlist, function(i) {
				var items = [];
				items.push('<td>자유</td>');
				items.push('<td>' + json.freeboardlist[i].fnum + '</td>');
				/* + "</td><td><a href='/first/bdetail?bnum=" + json.list[i].bnum + "&page=1'>"  */
				/* + decodeURIComponent(json.freeboardlist[index].ftitle).replace(/\+/gi, " ") */
				items.push("<td>"
						+ decodeURIComponent(json.freeboardlist[i].ftitle).replace(/\+/gi, " ") + '</td>');
				items.push('<td>' + json.freeboardlist[i].frcount + '</td>');
				$('<tr/>', {
					html: items
				}).appendTo('tbody');
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
<table class='tfree' style="text-align:center; border:1px solid #dddddd"> 
	<thead>
		<tr>
			<th style="background-color: #eeeeee; text-align: center;">분류</th>
			<th style="background-color: #eeeeee; text-align: center;">글번호</th>
			<th style="background-color: #eeeeee; text-align: center;">제목</th>
			<th style="background-color: #eeeeee; text-align: center;">조회수</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</div>
</body>
</html>