// 펫시팅 신청 메뉴 클릭 시 발생 이벤트
const psBtn = document.getElementById('pet_reg__btn');
const psRegBox = document.querySelector('.ps_reg_form');
const xBtn = document.querySelector('.ps_reg_form .close');

psBtn.addEventListener('click', (e) => {
	e.preventDefault();
	psRegBox.style.display = 'grid';
});

xBtn.addEventListener('click', ()=>{
	psRegBox.style.display = 'none';
});

// 이미지 파일 업로드 시 발생 이벤트
const realFile = document.getElementById("real-file");
const customBtn = document.getElementById("fake-file-btn");
const customTxt = document.getElementById("file-text");
const imageBox_pic = document.querySelector('.section3 .image_box .image_box_pic');

customBtn.addEventListener('click', () =>{
	realFile.click();
});

function readURL(input){
	if(input.files && input.files[0]){
		const reader = new FileReader();
		reader.onload = function(e){
			imageBox_pic.setAttribute('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

realFile.addEventListener('change', (e) =>{
	// 업로드 하면 버튼 옆에 파일명(경로제외) 출력 됨.
	readURL(e.target);
	 if(realFile.value)
	 	customTxt.innerHTML = realFile.value.match(/[\/\\]([\w\d\s\.\-\(\)]+)$/)[1];
});

// 펫시터 등록 버튼 클릭 시 발생 이벤트
const submitBtn = document.getElementById('submit-btn'); 

function handleRadio(name){
	const radioBtns = document.getElementsByName(name);
		for(let i = 0; i < radioBtns.length; i++){
			if(radioBtns[i].checked)
				return radioBtns[i]; // 체크된 라디오 버튼 리턴
		}
}
// 필수 입력항목 체크
function checkInputs(obj){
	for(let i in obj){
		obj[i].style.borderBottom = "1px solid white";
		if(obj[i].value === ""){
			obj[i].style.borderBottom = "1px solid red";

			return false;
		} 
	}
		return true;
}
submitBtn.addEventListener('click', (e)=>{
	e.preventDefault();
		const toSend = {
		userid : document.querySelector('.section1 .input_id'),
		username : document.querySelector('.section1 .input_name'),
		agree : handleRadio('agree'),
		phone : document.querySelector('.section2 .input_phone'),
		email : document.querySelector('.section2 .input_email'),
		address : document.querySelector('.section2 .input_addr'),
		price : document.querySelector('.section2 .input_price'),
	}
	if(checkInputs(toSend) && toSend.agree.value === 'agree'){
		// 모든 인풋 정보가 들어왔을경우
		const formData = new FormData();
		const file = document.getElementById('real-file');
		const xhr = new XMLHttpRequest();

		formData.append('pic', file.files[0]);
		formData.append('price', toSend.price.value);
		formData.append('userid',toSend.userid.value);
		formData.append('username',toSend.username.value);
		formData.append('phone',toSend.phone.value);
		formData.append('email',toSend.email.value);
		formData.append('addr',toSend.address.value);
		console.log(formData.values);
		xhr.onload = function(){
			const alertBox = document.querySelector('.ps_reg_form_popup_box');
			alertBox.style.display = "flex";
		}
		
		xhr.open('POST','/doggybeta/hostup');
		xhr.send(formData);
	} else {
		// 필수 인풋 정보가 들어오지 않았을 경우
		alert('bad');
	}
})

const chkRegFormBtn = document.querySelector('.ps_reg_form_popup_box button');

chkRegFormBtn.addEventListener('click', function(){
	location.href = '/doggybeta/index.jsp';
});
