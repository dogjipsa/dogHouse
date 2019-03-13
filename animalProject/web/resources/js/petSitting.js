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
