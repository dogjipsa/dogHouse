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