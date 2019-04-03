<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script language="javascript">  
 
    function closeWindow() {  
            setTimeout(function() {  
        window.close();  
            }, 50);  
        }  
  
    // 창이 열린 후 3초후에 닫기  
    window.onload = closeWindow();  
</script>  
</head>
<body>
<a href="#" onClick="javascript:closeWindow();">3초후에 닫기</a>   
</body>
</html>