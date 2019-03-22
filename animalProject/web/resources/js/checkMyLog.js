const items = document.querySelectorAll('input[name="item"]');
const bkTable = document.querySelector('#reserv_table');
const userid = document.querySelector('input[name="userid"]');



// 
for(let i = 0; i < items.length; i++){
    items[i].addEventListener('change',function(){
        if(items[i].value === 'booking'){
            bkTable.style.display = 'table';
            requestBkAjax();
        }
    });
}

// 예약/결제 내역 Ajax
function requestBkAjax(){
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('#reserv_table > tbody'); 

    xhr.onload = function(){
        
        const json = JSON.parse(xhr.responseText);
        while(tbody.firstChild){
            tbody.removeChild(tbody.firstChild);
        }
        for(let i in json.list){
            const tr = document.createElement('tr');
            tbody.appendChild(tr);
            let pg = "";
            let kind = "";
            switch(json.list[i].progress){
                case '0': pg = "예약 신청"; break;
                case '1': pg = "예약 완료"; break;
                case '2': pg = "결제 대기"; break;
                case '3': pg = "결제 완료"; break;
            }
            switch(json.list[i].kind){
                case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
                case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
                case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
                case '3': kind = "펫시터 집에 맡기기 서비스"; break;
            }

            const tableForm = {
                'bookingNo' : json.list[i].bno,
                'content' : kind+ " / "+ decodeURIComponent(json.list[i].pname)
                +" / "+decodeURIComponent(json.list[i].addr).replace(/\+/gi," ")+" / "+json.list[i].price+"원",
                'hostId' : json.list[i].puserid,
                'date' : json.list[i].indate +" ~ "+json.list[i].outdate,
                'pg' : pg 
            }
            for(let j in tableForm){
                const td = document.createElement('td');
                td.textContent = tableForm[j];
                tr.appendChild(td);
            }
        }
    };

    const requestData = 'userid='+encodeURIComponent(userid.value);

    xhr.open('POST','/doggybeta/bklist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}


// 페이지 로드시 예약/결제 내역 출력
document.addEventListener('DOMContentLoaded', () =>{ requestBkAjax(); });

