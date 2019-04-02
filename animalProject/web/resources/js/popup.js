function popupOpen(data){
    var url= "/doggybeta/views/review/reviewWriteForm.jsp?bookingNo="+data;    //팝업창 페이지 URL
    var winWidth = 700;
     var winHeight = 600;
     var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
    window.open(url,"",popupOption+",left=500, top=250");
 }