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
const realFileBtn = document.getElementById("real-file");
const customBtn = document.getElementById("fake-file-btn");
const customTxt = document.getElementById("file-text");

customBtn.addEventListener('click', () =>{
	realFileBtn.click();
});
realFileBtn.addEventListener('change', () =>{
	if(realFileBtn.value){
		customTxt.innerHTML = realFileBtn.value.match(/[\/\\]([\w\d\s\.\-\(\)]+)$/)[1];
	}
});

// 펫시터 등록 버튼 클릭 시 발생 이벤트
const submitBtn = document.getElementById('submit-btn'); 

function handleRadio(name){
	const radioBtns = document.getElementsByName(name);
		for(let i = 0; i < radioBtns.length; i++){
			if(radioBtns[i].checked)
				return radioBtns[i].value; // 체크된 라디오 버튼 value 리턴
		}
}
function checkInputs(obj){
	for(let i in obj){
		if(obj[i] === "") return false;
	}
}
submitBtn.addEventListener('click', ()=>{
	const toSend = {
		userid : document.querySelector('.section1 .input_id').value,
		username : document.querySelector('.section1 .input_name').value,
		agree : handleRadio('agree'),
		phone : document.querySelector('.section2 .input_phone').value,
		email : document.querySelector('.section2 .input_email').value,
		address : document.querySelector('.section2 .input_addr').value,
		price : document.querySelector('.section2 .input_price').value
	}
	if(checkInputs(toSend) && toSend.agree === 'agree'){
		// 모든 인풋 정보가 들어왔을경우
		const jsonString = JSON.stringify(toSend);
		const xhr = new XMLHttpRequest();
		
		xhr.onload = function(){
			
		}
		
		xhr.open('POST','/doggybeta/pss');
		xhr.setRequestHeader("Content-Type","application/json")
		xhr.send(jsonString);
	} else {
		// 필수 인풋 정보가 들어오지 않았을 경우
		console.log('xxxxx');
	}
})