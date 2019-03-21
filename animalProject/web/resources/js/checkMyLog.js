function showMain(){
    const present = document.querySelector('input[name="item"]:checked');
    if(present.value === 'booking'){
        console.log('111')
    }
}

document.querySelectorAll('input[name="item"]');

function init(){
    showMain();
}

init();

