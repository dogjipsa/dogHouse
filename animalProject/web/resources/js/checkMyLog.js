const items = document.querySelectorAll('input[name="item"]');
const userid = document.querySelector('input[name="userid"]');
const bkTable = document.querySelector('#reserv_table');
const hostMain = document.querySelector('.host_main');
const addPetMain = document.querySelector('#add_pet');
const pagination = document.querySelector('.section5 .pagination');
let chosenPage = 1;

// section1 버튼 클릭 시 main 내용 변경 이벤트 처리
for (let i = 0; i < items.length; i++) {
    items[i].addEventListener('change', function () {
        while(pagination.firstChild){
            pagination.removeChild(pagination.firstChild);
        }
        if (items[i].value === 'booking') {
            bkTable.style.display = 'table';
            hostMain.style.display = 'none';
            addPetMain.style.display = 'none';
            requestBkAjax();
        }
        if (items[i].value === 'host') {
            bkTable.style.display = 'none';
            addPetMain.style.display = 'none';
            hostMain.style.display = 'grid';
            requestHostAjax();
        }
        if(items[i].value === 'addpet'){
            bkTable.style.display = 'none';
            hostMain.style.display = 'none';
            addPetMain.style.display = 'grid';

        }
    });
}
// 
const pSubmitBtn = document.querySelector('#p-submit');
const petRegForm = document.getElementById('pet_reg_form');
pSubmitBtn.addEventListener('click', function(e){
    e.preventDefault();
    const petData = new FormData(petRegForm);

    console.log(petData);
    const xhr = new XMLHttpRequest();
    xhr.open('POST','/doggybeta/addpet');
    xhr.setRequestHeader('Content-Type', 'multipart/form-data');
    xhr.send(petData);
});

// 펫 추가 입력 폼 자바스크립트
let current_fs, next_fs, previous_fs;
document.getElementById('puppybirth').valueAsDate = new Date();
const nextBtns = document.querySelectorAll('.next');
for(let i = 0; i < nextBtns.length; i++){
    nextBtns[i].addEventListener('click',function(){
        
        current_fs = nextBtns[i].parentNode;
        next_fs = nextBtns[i].parentNode.nextElementSibling;
        
        document.querySelectorAll('#progressbar li')[indexOf(next_fs)].setAttribute('class','active');
        next_fs.style.display ='block';
        current_fs.style.display = 'none';
    });
}
const prevBtns = document.querySelectorAll('.previous');
for(let i = 0; i < prevBtns.length; i++){
    prevBtns[i].addEventListener('click', function(){
        current_fs = prevBtns[i].parentNode;
        previous_fs = current_fs.previousElementSibling;
        document.querySelectorAll('#progressbar li')[indexOf(current_fs)].classList.remove('active');
        current_fs.style.display = 'none';
        previous_fs.style.display = 'block';

    });
}
const realPetpic = document.querySelector('#petpic');
const petpicBtn = document.getElementById('petpic-btn');
const petImagePreview = document.getElementById('pet-img-preview');
petpicBtn.addEventListener('click',()=>{
    realPetpic.click();
});

realPetpic.addEventListener('change', (e)=>{
    const petpicFile = e.target.files[0];
    if(petpicFile){
        const reader = new FileReader();
        reader.onload = (r)=>{
            petImagePreview.setAttribute('src',r.target.result);
        }
        reader.readAsDataURL(petpicFile);
    }
});

// 성별 라디오 버튼 커스터 마이징
const genderRadios = document.querySelectorAll('.radio-box .gender');
genderRadios[0].style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue'; // default checked
for(let i = 0; i < genderRadios.length; i++){
    genderRadios[i].addEventListener('click', function(e){
        for(let j = 0; j < genderRadios.length; j++){
            genderRadios[j].style.boxShadow = 'none';
        }
        e.target.style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue';
    });
}
// 애완견 크기 버튼 커스터 마이징
const sizeRadios = document.querySelectorAll('.radio-box .size');
sizeRadios[0].style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue'; // default checked
for(let i = 0; i < sizeRadios.length; i++){
    sizeRadios[i].addEventListener('click', function(e){
        for(let j = 0; j < sizeRadios.length; j++){
            sizeRadios[j].style.boxShadow = 'none';
        }
        e.target.style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue';
    });
}

// 인덱스 리턴 메소드
function indexOf(node){
    const children = node.parentNode.childNodes;
    let num = 0;
    for(let i = 0; i < children.length; i++){
        if(children[i] === node) return num;
        if(children[i].nodeType === 1 && children[i].nodeName === node.nodeName) num++;
    }
    return -1;
}

// 호스트 서비스 버튼 클릭 시 나에게 온 예약 출력 Ajax
function requestHostAjax() {
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('.host_table table tbody');
    xhr.onload = function () {
        if (xhr.responseText) {
            const json = JSON.parse(xhr.responseText);
            console.log(json);
            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (let i in json.list) {
                const tr = document.createElement('tr');
                tbody.appendChild(tr);
                let pg = "";
                let kind = "";
                switch (json.list[i].pg) {
                    case '0': pg = "예약 신청"; break;
                    case '1': pg = "예약 완료"; break;
                    case '2': pg = "결제 대기"; break;
                    case '3': pg = "결제 완료"; break;
                }
                switch (json.list[i].kind) {
                    case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
                    case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
                    case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
                    case '3': kind = "펫시터 집에 맡기기 서비스"; break;
                }
                const tableForm = {
                    'bno': json.list[i].bno,
                    'kind': kind,
                    'name': decodeURIComponent(json.list[i].username),
                    'etc': decodeURIComponent(json.list[i].etc).replace(/\+/gi," "),
                    'date': json.list[i].indate +' ~ '+ json.list[i].outdate,
                    'price': json.list[i].price+'원',
                    'progress': pg,
                    'address': decodeURIComponent(json.list[i].addr).replace(/\+/gi," "),
                    'pno': json.list[i].pno
                }
                for (let j in tableForm) {
                    if(j === 'address'){
                        const hInput = document.createElement('input');
                        hInput.setAttribute("type","hidden");
                        hInput.setAttribute("name","addr");
                        hInput.setAttribute("value",tableForm[j]);
                        tr.appendChild(hInput);
                    } else if(j === 'pno'){
                        const hInput = document.createElement('input');
                        hInput.setAttribute("type","hidden");
                        hInput.setAttribute("name","pno");
                        hInput.setAttribute("value",tableForm[j]);
                        tr.appendChild(hInput);
                        
                    } else {
                        const td = document.createElement('td');
                        td.textContent = tableForm[j];
                        tr.appendChild(td);
                    }
                }

                tr.addEventListener('click', function(){
                    initMap(tableForm.address.split(",")[0], tableForm.name);
                    document.querySelector('#addr_text').textContent = tableForm.address;
                    const miniInfo = document.querySelector('.host_side2');
                    while(miniInfo.firstChild){
                        miniInfo.removeChild(miniInfo.firstChild);
                    }

                });
            }
            const startPage = json.plist.start;
            const endPage = json.plist.end;
            const currentPage = json.plist.page;
            const totalPage = json.plist.totalpage;

            while(pagination.firstChild){
                pagination.removeChild(pagination.firstChild);
            }

            const pageBox = document.createElement('div');
            pageBox.setAttribute('class','pagebox');
            
            if(startPage > 1){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                pageBox.textContent = '처음';
                pagination.appendChild(pageBox);
                page.onclick = () =>{
                    chosenPage = 1;
                    requestHostAjax();
                }
            }
            if(currentPage > 1){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                pageBox.textContent = '이전';
                pagination.appendChild(pageBox);
                pageBox.onclick = ()=>{
                    chosenPage = currentPage -1;
                    requestHostAjax();
                }
            }
            for(let i = startPage; i <= endPage; i++){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                if(i === currentPage){
                    pageBox.textContent = i;
                    pageBox.style.color = 'dodgerblue';
                    pagination.appendChild(pageBox);
                } else {
                    pageBox.textContent = i;
                    pagination.appendChild(pageBox);
                }
                pageBox.onclick = ()=>{
                    chosenPage = i;
                    requestHostAjax();
                }
            }

            if(currentPage < totalPage){
                const pageBox = document.createElement('div');
                    pageBox.setAttribute('class','pagebox');
                    pageBox.textContent = '다음';
                    pagination.appendChild(pageBox);
                    pageBox.onclick = () => {
                        chosenPage = currentPage+1;
                        requestHostAjax();
                    }
            }
            if(endPage < totalPage){
                const pageBox = document.createElement('div');
                    pageBox.setAttribute('class','pagebox');
                    pageBox.textContent = '끝';
                    pagination.appendChild(pageBox);
                    pageBox.onclick = () =>{
                        chosenPage = endPage;
                        requestHostAjax();
                    }
            }

        }
    }
    const requestData = 'userid=' + encodeURIComponent(userid.value)+'&page='+encodeURIComponent(chosenPage);

    xhr.open("POST", "/doggybeta/hservice");
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}
// 예약/결제 내역 Ajax
function requestBkAjax() {
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('#reserv_table > tbody');

    xhr.onload = function () {
        if (xhr.responseText) {

            const json = JSON.parse(xhr.responseText);
            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (let i in json.list) {
                const tr = document.createElement('tr');
                tbody.appendChild(tr);
                let pg = "";
                let kind = "";
                switch (json.list[i].progress) {
                    case '0': pg = "예약 신청"; break;
                    case '1': pg = "예약 완료"; break;
                    case '2': pg = "결제 대기"; break;
                    case '3': pg = "결제 완료"; break;
                }
                switch (json.list[i].kind) {
                    case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
                    case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
                    case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
                    case '3': kind = "펫시터 집에 맡기기 서비스"; break;
                }

                const tableForm = {
                    'bookingNo': json.list[i].bno,
                    'kind': kind,
                    'pname': decodeURIComponent(json.list[i].pname),
                    'addr': decodeURIComponent(json.list[i].addr).replace(/\+/gi, " "),
                    'price': json.list[i].price + "원",
                    'hostId': json.list[i].puserid,
                    'date': json.list[i].indate + " ~ " + json.list[i].outdate,
                    'pg': pg
                }
                for (let j in tableForm) {
                    const td = document.createElement('td');
                    td.textContent = tableForm[j];
                    tr.appendChild(td);
                }
            }
            
            const startPage = json.plist.start;
            const endPage = json.plist.end;
            const currentPage = json.plist.page;
            const totalPage = json.plist.totalpage;

            while(pagination.firstChild){
                pagination.removeChild(pagination.firstChild);
            }
            
            const pageBox = document.createElement('div');
            pageBox.setAttribute('class','pagebox');
            
            if(startPage > 1){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                pageBox.textContent = '처음';
                pagination.appendChild(pageBox);
                page.onclick = () =>{
                    chosenPage = 1;
                    requestBkAjax();
                }
            }
            if(currentPage > 1){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                pageBox.textContent = '이전';
                pagination.appendChild(pageBox);
                pageBox.onclick = ()=>{
                    chosenPage = currentPage -1;
                    requestBkAjax();
                }

            }
            for(let i = startPage; i <= endPage; i++){
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class','pagebox');
                if(i === currentPage){
                    pageBox.textContent = i;
                    pageBox.style.color = 'dodgerblue';
                    pagination.appendChild(pageBox);
                } else {
                    pageBox.textContent = i;
                    pagination.appendChild(pageBox);
                }
                pageBox.onclick = ()=>{
                    chosenPage = i;
                    requestBkAjax();
                }
            }

            if(currentPage < totalPage){
                const pageBox = document.createElement('div');
                    pageBox.setAttribute('class','pagebox');
                    pageBox.textContent = '다음';
                    pagination.appendChild(pageBox);
                    pageBox.onclick = () => {
                        chosenPage = currentPage+1;
                        requestBkAjax();
                    }
            }
            if(endPage < totalPage){
                const pageBox = document.createElement('div');
                    pageBox.setAttribute('class','pagebox');
                    pageBox.textContent = '끝';
                    pagination.appendChild(pageBox);
                    pageBox.onclick = () =>{
                        chosenPage = endPage;
                        requestBkAjax();
                    }
            }
        }
    };
    
    const requestData = 'userid=' + encodeURIComponent(userid.value)+'&page='+encodeURIComponent(chosenPage);

    xhr.open('POST', '/doggybeta/bklist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}

// 페이지 로드시 예약/결제 내역 출력
document.addEventListener('DOMContentLoaded', () => { requestBkAjax(); });

