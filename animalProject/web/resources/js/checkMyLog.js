const items = document.querySelectorAll('input[name="item"]');
const userid = document.querySelector('.section1 input[name="userid"]');
const bkTable = document.querySelector('#reserv_table');
const hostMain = document.querySelector('.host_main');
const addPetMain = document.querySelector('#add_pet');
const pagination = document.querySelector('.section5 .pagination');
let chosenPage = 1;

// section1 버튼 클릭 시 main 내용 변경 이벤트 처리
for (let i = 0; i < items.length; i++) {
    items[i].addEventListener('change', function () {
        while (pagination.firstChild) {
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
        if (items[i].value === 'addpet') {
            bkTable.style.display = 'none';
            hostMain.style.display = 'none';
            addPetMain.style.display = 'grid';
            requestPetListAjax();
        }
    });
}
// 나의 펫 리스트 출력 Ajax
function requestPetListAjax() {
    const xhr = new XMLHttpRequest();

    xhr.onload = () => {
        const petList = document.querySelector('.pet_list');
        while (petList.firstChild) {
            petList.removeChild(petList.firstChild);
        }
        if (xhr.responseText) {
            const json = JSON.parse(xhr.responseText);

            for (let i in json.list) {
                const petInfo = {
                    'pno': json.list[i].pno,
                    'pname': decodeURIComponent(json.list[i].pname),
                    'breeds': decodeURIComponent(json.list[i].breeds),
                    'birth': json.list[i].birth,
                    'size': decodeURIComponent(json.list[i].size),
                    'gender': json.list[i].gender,
                    'neutral': json.list[i].neutral,
                    'etc': json.list[i].etc.replace(/\+/gi, " "),
                    'userid': json.list[i].userid,
                    'origin': json.list[i].origin,
                    'rename': json.list[i].rename
                }
                const tabBtn = document.createElement('button');
                tabBtn.classList.add('tabs__button');
                tabBtn.textContent = petInfo.pname;
                petList.appendChild(tabBtn);

                const petUpForm = document.querySelector('#pet_up_form');

                tabBtn.addEventListener('click', function () {
                    const btns = document.querySelectorAll('.pet_list .tabs__button');
                    for (let i = 0; i < btns.length; i++) {
                        btns[i].style.borderRight = "none";
                        btns[i].style.fontWeight = "100";
                    }
                    tabBtn.style.borderRight = "4px solid #27AE60";
                    tabBtn.style.fontWeight = "bold";
                    petUpForm.reset();
                    document.querySelector('#pet_up_form input[name="userid"]').value = petInfo.userid;
                    document.querySelector('#pet_up_form input[name="pno"]').value = petInfo.pno;
                    document.querySelector('#pet_up_form input[name="pname"]').value = petInfo.pname;
                    document.querySelector('#pet_up_form input[name="breeds"]').value = petInfo.breeds;
                    const genders = document.querySelectorAll('#pet_up_form input[name="gender"]');
                    const sizes = document.querySelectorAll('#pet_up_form input[name="size"]');
                    for (let i = 0; i < genders.length; i++) {
                        if (genders[i].value === petInfo.gender || genders[i].value === petInfo.neutral)
                            genders[i].click();
                    }
                    for (let i = 0; i < sizes.length; i++) {
                        if (sizes[i].value === petInfo.size)
                            sizes[i].click();
                    }
                    document.querySelector('#pet_up_form input[name="birth"]').value = petInfo.birth;
                    document.querySelector('#pet_up_form input[name="origin"]').value = petInfo.origin;
                    document.querySelector('#pet_up_form textarea').value = petInfo.etc;
                    document.querySelector('#pet_up_form .pet__img__update').setAttribute('src', '/doggybeta/files/pet/' + petInfo.rename);
                });

            }
            if (petList.firstChild)
                petList.firstChild.click();

            // 펫 리스트 페이징 처리
            const startPage = json.plist.start;
            const endPage = json.plist.end;
            const currentPage = json.plist.page;
            const totalPage = json.plist.totalpage;
            const listPagination = document.querySelector('.pet_list_pagination');

            while (listPagination.firstChild) {
                listPagination.removeChild(listPagination.firstChild);
            }

            const pageBox = document.createElement('div');
            pageBox.setAttribute('class', 'pagebox');

            if (startPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<<';
                listPagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = 1;
                    requestPetListAjax();
                }
            }
            if (currentPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<';
                listPagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage - 1;
                    requestPetListAjax();
                }
            }
            for (let i = startPage; i <= endPage; i++) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                if (i === currentPage) {
                    pageBox.textContent = i;
                    pageBox.style.color = 'dodgerblue';
                    listPagination.appendChild(pageBox);
                } else {
                    pageBox.textContent = i;
                    listPagination.appendChild(pageBox);
                }
                pageBox.onclick = () => {
                    chosenPage = i;
                    requestPetListAjax();
                }
            }

            if (currentPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>';
                listPagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage + 1;
                    requestPetListAjax();
                }
            }
            if (endPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>>';
                listPagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = totalPage;
                    requestPetListAjax();
                }
            }
        }
    }
    const requestData = 'userid=' + encodeURIComponent(userid.value) + '&page=' + encodeURIComponent(chosenPage);
    xhr.open('POST', '/doggybeta/gplist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}
const petUpForm = document.querySelector('#pet_up_form');
// 펫 정보 삭제 Ajax
const pDelButton = document.querySelector('#pet_del__btn');
pDelButton.addEventListener('click', function (e) {
    e.preventDefault();
    const xhr = new XMLHttpRequest();
    xhr.onload = () => {
        const popup = document.querySelector('.modal-content');
        popup.style.display = "block";

        // 클로징 처리
        const mCloses = document.querySelectorAll('.m-close');
        for (let i = 0; i < mCloses.length; i++) {
            mCloses[i].addEventListener('click', () => {
                popup.style.display = "none"; // 팝업 내리기
                petUpForm.reset(); // 인풋 클리어                
            });
        }
        const modalText = document.getElementById('modal-text');
        if (xhr.responseText === 'ok') {
            modalText.textContent = "강아지를 성공적으로 삭제했습니다!";
            requestPetListAjax();
        } else {
            modalText.textContent = "강아지 삭제에 실패했습니다. 관리자에게 문의하세요";
        }
    }
    const pno = 'pno=' + encodeURIComponent(petUpForm.querySelector('input[name="pno"]').value);
    xhr.open('GET', '/doggybeta/pdels?' + pno);
    xhr.send();
});

// 펫 정보 수정 Ajax
const pUpButton = document.querySelector('#pet_up__btn');
pUpButton.addEventListener('click', (e) => {
    e.preventDefault();
    const petData = new FormData(petUpForm);
    if (petUpForm.querySelector('input[name="ppic"]').result === undefined) {
        petData.append('ppic2', document.querySelector('#pet_up_form input[name="origin"]'));
    }
    const xhr = new XMLHttpRequest();
    xhr.onload = () => {
        const popup = document.querySelector('.modal-content');
        popup.style.display = "block";

        // 클로징 처리
        const mCloses = document.querySelectorAll('.m-close');
        for (let i = 0; i < mCloses.length; i++) {
            mCloses[i].addEventListener('click', () => {
                popup.style.display = "none"; // 팝업 내리기
                petUpForm.reset(); // 인풋 클리어                
            });
        }
        modalText = document.getElementById('modal-text');
        if (xhr.responseText === 'ok') {
            modalText.textContent = "강아지를 성공적으로 수정했습니다!";
            requestPetListAjax();
        } else {
            modalText.textContent = "강아지 수정에 실패했습니다. 관리자에게 문의하세요";
        }
    }
    xhr.open('POST', '/doggybeta/pups');
    xhr.send(petData);
});

// 업데이트 섹션 이미지 프리뷰
const upPicFile = document.querySelector('#pet_up_form #up_ppic');
upPicFile.addEventListener('change', (e) => {
    const img = e.target.files[0];
    if (img) {
        const reader = new FileReader();
        reader.onload = (r) => {
            document.querySelector('#pet_up_form .pet__img__update').setAttribute('src', r.target.result);
        }
        reader.readAsDataURL(img);
    }
})
// 펫 추가 Ajax
const pSubmitBtn = document.querySelector('#p-submit');
const petRegForm = document.getElementById('pet_reg_form');
pSubmitBtn.addEventListener('click', function (e) {
    e.preventDefault();
    const petData = new FormData(petRegForm);
    const xhr = new XMLHttpRequest();

    xhr.onload = () => {
        const popup = document.querySelector('.modal-content');
        popup.style.display = "block";

        // 클로징 처리
        const mCloses = document.querySelectorAll('.m-close');
        for (let i = 0; i < mCloses.length; i++) {
            mCloses[i].addEventListener('click', () => {
                popup.style.display = "none"; // 팝업 내리기
                petRegForm.reset(); // 인풋 클리어
                petImagePreview.setAttribute('src', '/doggybeta/resources/images/default.jpg'); // 이미지 프리뷰 클리어
                document.querySelector('fieldset').style = "block"; // page 1로 이동
                document.querySelectorAll('fieldset')[2].style.display = "none"; // 현재 페이지 숨기기
                document.querySelectorAll('#progressbar li')[1].classList.remove('active');
                document.querySelectorAll('#progressbar li')[2].classList.remove('active');
            });
        }
        modalText = document.getElementById('modal-text');
        if (xhr.responseText === 'ok') {
            modalText.textContent = "강아지를 성공적으로 추가했습니다!";
            requestPetListAjax();
        } else {
            modalText.textContent = "강아지 등록에 실패했습니다. 관리자에게 문의하세요";
        }

    }
    xhr.open('POST', '/doggybeta/addpet');
    xhr.send(petData);
});

// 펫 추가 입력 폼 자바스크립트
let current_fs, next_fs, previous_fs;
document.getElementById('puppybirth').valueAsDate = new Date();
const nextBtns = document.querySelectorAll('.next');
for (let i = 0; i < nextBtns.length; i++) {
    nextBtns[i].addEventListener('click', function () {
        current_fs = nextBtns[i].parentNode;
        next_fs = nextBtns[i].parentNode.nextElementSibling;
        const currentInputs = current_fs.querySelectorAll('input');
        for (let i = 0; i < currentInputs.length; i++) {
            if (currentInputs[i].value === "") {
                currentInputs[i].style.boxShadow = '0 0 0 2px white, 0 0 0 3px red';
                currentInputs[i].addEventListener('click', function () {
                    currentInputs[i].style.boxShadow = 'none';
                })
                return false;
            }
            currentInputs[i].style.boxShadow = 'none';
        }
        document.querySelectorAll('#progressbar li')[indexOf(next_fs)].setAttribute('class', 'active');
        next_fs.style.display = 'block';
        current_fs.style.display = 'none';
    });
}
const prevBtns = document.querySelectorAll('.previous');
for (let i = 0; i < prevBtns.length; i++) {
    prevBtns[i].addEventListener('click', function () {
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
petpicBtn.addEventListener('click', (e) => {
    e.preventDefault();
    realPetpic.click();
});

realPetpic.addEventListener('change', (e) => {
    const petpicFile = e.target.files[0];
    if (petpicFile) {
        const reader = new FileReader();
        reader.onload = (r) => {
            petImagePreview.setAttribute('src', r.target.result);
        }
        reader.readAsDataURL(petpicFile);
    }
});

// 성별 라디오 버튼 커스터 마이징
const genderRadios = document.querySelectorAll('.radio-box .gender');
genderRadios[0].style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue'; // default checked
for (let i = 0; i < genderRadios.length; i++) {
    genderRadios[i].addEventListener('click', function (e) {
        for (let j = 0; j < genderRadios.length; j++) {
            genderRadios[j].style.boxShadow = 'none';
        }
        e.target.style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue';
    });
}
// 애완견 크기 버튼 커스터 마이징
const sizeRadios = document.querySelectorAll('.radio-box .size');
sizeRadios[0].style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue'; // default checked
for (let i = 0; i < sizeRadios.length; i++) {
    sizeRadios[i].addEventListener('click', function (e) {
        for (let j = 0; j < sizeRadios.length; j++) {
            sizeRadios[j].style.boxShadow = 'none';
        }
        e.target.style.boxShadow = '0 0 0 2px white, 0 0 0 3px dodgerblue';
    });
}

// 인덱스 리턴 메소드
function indexOf(node) {
    const children = node.parentNode.childNodes;
    let num = 0;
    for (let i = 0; i < children.length; i++) {
        if (children[i] === node) return num;
        if (children[i].nodeType === 1 && children[i].nodeName === node.nodeName) num++;
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
            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (let i in json.list) {
                const tr = document.createElement('tr');
                tbody.appendChild(tr);
                let pg = "";
                let kind = "";
                switch (json.list[i].pg) {

                    case '1': pg = "예약 승인"; break;
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
                    'etc': decodeURIComponent(json.list[i].etc).replace(/\+/gi, " "),
                    'date': json.list[i].indate + ' ~ ' + json.list[i].outdate,
                    'price': numberWithCommas(json.list[i].price) + '원',
                    'address': decodeURIComponent(json.list[i].addr).replace(/\+/gi, " "),
                }
                for (let j in tableForm) {
                    if (j === 'address') {
                        const hInput = document.createElement('input');
                        hInput.setAttribute("type", "hidden");
                        hInput.setAttribute("name", "addr");
                        hInput.setAttribute("value", tableForm[j]);
                        tr.appendChild(hInput);
                    } else {
                        const td = document.createElement('td');
                        td.textContent = tableForm[j];
                        tr.appendChild(td);
                    }
                }

                if (json.list[i].pg !== '1') {
                    const td = document.createElement('td');
                    td.textContent = pg;
                    tr.appendChild(td);
                } else {
                    const td = document.createElement('td');
                    const button = document.createElement('button');
                    button.textContent = "예약 승인";
                    button.addEventListener('click', function () {
                        const xhr = new XMLHttpRequest();
                        xhr.onload = () => {
                            const popup = document.querySelector('.modal-content');
                            popup.style.display = "block";

                            // 클로징 처리
                            const mCloses = document.querySelectorAll('.m-close');
                            for (let i = 0; i < mCloses.length; i++) {
                                mCloses[i].addEventListener('click', () => {
                                    popup.style.display = "none"; // 팝업 내리기
                                    petUpForm.reset(); // 인풋 클리어                
                                });
                            }
                            modalText = document.getElementById('modal-text');
                            if (xhr.responseText === 'ok') {
                                modalText.textContent = "예약 승인이 완료되었습니다!";
                                requestHostAjax();
                            } else {
                                modalText.textContent = "예약 승인을 실패했습니다. 관리자에게 문의하세요";
                            }
                        }
                        const requestData = 'bno=' + encodeURIComponent(tableForm.bno);
                        xhr.open('POST', '/doggybeta/buphost');
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.send(requestData);
                    });
                    tr.appendChild(td).appendChild(button);
                }

                tr.addEventListener('click', function () {
                    initMap(tableForm.address.split(",")[0], tableForm.name);
                    document.querySelector('#addr_text').textContent = tableForm.address;
                    initSubInfo(json.list[i].userid, json.list[i].pno);
                });
            }
            const startPage = json.plist.start;
            const endPage = json.plist.end;
            const currentPage = json.plist.page;
            const totalPage = json.plist.totalpage;

            while (pagination.firstChild) {
                pagination.removeChild(pagination.firstChild);
            }

            const pageBox = document.createElement('div');
            pageBox.setAttribute('class', 'pagebox');

            if (startPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<<';
                pagination.appendChild(pageBox);
                page.onclick = () => {
                    chosenPage = 1;
                    requestHostAjax();
                }
            }
            if (currentPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage - 1;
                    requestHostAjax();
                }
            }
            for (let i = startPage; i <= endPage; i++) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                if (i === currentPage) {
                    pageBox.textContent = i;
                    pageBox.style.color = 'dodgerblue';
                    pagination.appendChild(pageBox);
                } else {
                    pageBox.textContent = i;
                    pagination.appendChild(pageBox);
                }
                pageBox.onclick = () => {
                    chosenPage = i;
                    requestHostAjax();
                }
            }

            if (currentPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage + 1;
                    requestHostAjax();
                }
            }
            if (endPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>>';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = totalPage;
                    requestHostAjax();
                }
            }

        }
        if (tbody.firstChild)
            tbody.firstChild.click();
    }
    const requestData = 'userid=' + encodeURIComponent(userid.value) + '&page=' + encodeURIComponent(chosenPage);

    xhr.open("POST", "/doggybeta/hservice");
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}
// 서브 인포메이션 출력 Ajax
function initSubInfo(userid, pno) {
    const miniInfoForm = document.querySelector('.host_side2 .showbox');
    miniInfoForm.reset();
    const showboxImage = document.querySelector('#showbox_img');
    showboxImage.setAttribute('src','/doggybeta/resources/images/default.jpg');
    const xhr = new XMLHttpRequest();

    xhr.onload = ()=>{
        if(xhr.responseText){
            const json = JSON.parse(xhr.responseText);
            
            if(json.img){
                showboxImage.setAttribute('src','/doggybeta/files/pet/'+json.img);
            }
            document.querySelector('.showbox_info input[name="pname"]').value = decodeURIComponent(json.pname);
            document.querySelector('.showbox_info input[name="age"]').value = json.age+"살";
            document.querySelector('.showbox_info input[name="phone"]').value = json.phone;
            document.querySelector('.showbox_info input[name="breeds"]').value = json.breeds;
        }
    }
    const requestData = 'userid='+encodeURIComponent(userid)+'&pno='+encodeURIComponent(pno);
    xhr.open('POST','/doggybeta/gsinfo');
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
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
                    'price': numberWithCommas(json.list[i].price) + "원",
                    'hostId': json.list[i].puserid,
                    'date': json.list[i].indate + " ~ " + json.list[i].outdate,
                }
                for (let j in tableForm) {
                    const td = document.createElement('td');
                    td.textContent = tableForm[j];
                    tr.appendChild(td);
                }
                if (json.list[i].progress === "2") {
                    const td = document.createElement('td');
                    const button = document.createElement("button");
                    button.textContent = pg;
                    button.addEventListener('click', function () {
                        payInIt(json.list[i]);
                        // location.href ="/doggybeta/bpselect?bookingNo="+tableForm.bookingNo+"&priceSum="+json.list[i].price;
                    });
                    tr.appendChild(td).appendChild(button);
                } else {
                    const td = document.createElement('td');
                    td.textContent = pg;
                    tr.appendChild(td);
                }
                if (json.list[i].progress === "3") {
                    const td = document.createElement('td');
                    const button = document.createElement("button");
                    button.textContent = "리뷰 작성";
                    button.addEventListener('click',function(){
                        popupOpen(tableForm.bookingNo);
                    });
                    tr.appendChild(td).appendChild(button);
                } else {
                    const td = document.createElement('td');
                    td.textContent = "진행 중";
                    tr.appendChild(td);
                }
            }

            const startPage = json.plist.start;
            const endPage = json.plist.end;
            const currentPage = json.plist.page;
            const totalPage = json.plist.totalpage;

            while (pagination.firstChild) {
                pagination.removeChild(pagination.firstChild);
            }

            const pageBox = document.createElement('div');
            pageBox.setAttribute('class', 'pagebox');

            if (startPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<<';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = 1;
                    requestBkAjax();
                }
            }
            if (currentPage > 1) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '<';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage - 1;
                    requestBkAjax();
                }

            }
            for (let i = startPage; i <= endPage; i++) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                if (i === currentPage) {
                    pageBox.textContent = i;
                    pageBox.style.color = 'dodgerblue';
                    pagination.appendChild(pageBox);
                } else {
                    pageBox.textContent = i;
                    pagination.appendChild(pageBox);
                }
                pageBox.onclick = () => {
                    chosenPage = i;
                    requestBkAjax();
                }
            }

            if (currentPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = currentPage + 1;
                    requestBkAjax();
                }
            }
            if (endPage < totalPage) {
                const pageBox = document.createElement('div');
                pageBox.setAttribute('class', 'pagebox');
                pageBox.textContent = '>>';
                pagination.appendChild(pageBox);
                pageBox.onclick = () => {
                    chosenPage = totalPage;
                    requestBkAjax();
                }
            }
        }
    };

    const requestData = 'userid=' + encodeURIComponent(userid.value) + '&page=' + encodeURIComponent(chosenPage);

    xhr.open('POST', '/doggybeta/bklist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}
// 숫자 세자리마다 ,찍기 함수
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 페이지 로드시 예약/결제 내역 출력
document.addEventListener('DOMContentLoaded', () => { requestBkAjax(); });

