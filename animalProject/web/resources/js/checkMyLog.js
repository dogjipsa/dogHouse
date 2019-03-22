const items = document.querySelectorAll('input[name="item"]');
const bkTable = document.querySelector('#reserv_table');
const userid = document.querySelector('input[name="userid"]');


for(let i = 0; i < items.length; i++){
    items[i].addEventListener('change',function(){
        if(items[i].value === 'booking'){
            bkTable.style.display = 'table';
            requestBkAjax();
        }
    });
}

function requestBkAjax(){
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('#reserv_table tbody');
    const tr = document.createElement('tr');
    const td = document.createElement('td');

    xhr.onload = function(){
        
        const json = JSON.parse(xhr.responseText);
        while(tbody.firstChild){
            tbody.removeChild(tbody.firstChild);
        }
        for(let i in json.list){
            console.log(json.list[i]);
            const bookingNo = json.list[i].bno;
            

        }
        
        
        
       
        
    };

    const requestData = 'userid='+encodeURIComponent(userid.value);

    xhr.open('POST','/doggybeta/bklist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}

document.addEventListener('DOMContentLoaded', () =>{ requestBkAjax(); });

