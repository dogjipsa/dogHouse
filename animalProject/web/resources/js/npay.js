function payInIt(datalist){

    console.log(datalist);
    let kind ="";
    switch (datalist.kind) {
        case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
        case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
        case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
        case '3': kind = "펫시터 집에 맡기기 서비스"; break;
    }
    //실제 복사하여 사용시에는 모든 주석을 지운 후 사용하세요
    BootPay.request({
	price: datalist.price, //실제 결제되는 가격
	application_id: "5ca0fb96b6d49c5161190988",
	name: kind, //결제창에서 보여질 이름
	// pg: 'kakao',
	// method: 'easy', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
	show_agree_window: 1, // 부트페이 정보 동의 창 보이기 여부
	items: [
        {
            item_name: '나는 아이템', //상품명
			qty: 1, //수량
			unique: '123', //해당 상품을 구분짓는 primary key
			price: 1000, //상품 단가
			cat1: 'TOP', // 대표 상품의 카테고리 상, 50글자 이내
			cat2: '티셔츠', // 대표 상품의 카테고리 중, 50글자 이내
			cat3: '라운드 티', // 대표상품의 카테고리 하, 50글자 이내
		}
	],
	user_info: {
		username: '사용자 이름',
		email: '사용자 이메일',
		addr: '사용자 주소',
		phone: '010-1234-4567'
	},
	order_id: datalist.bno, //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
	params: {callback1: '그대로 콜백받을 변수 1', callback2: '그대로 콜백받을 변수 2', customvar1234: '변수명도 마음대로'}
}).error(function (data) {
    //결제 진행시 에러가 발생하면 수행됩니다.
	console.log(data);
}).cancel(function (data) {
    //결제가 취소되면 수행됩니다.
	console.log(data);
}).ready(function (data) {
    // 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
	console.log(data);
}).confirm(function (data) {
    //결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
	//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
	console.log(data);
	if (data) { // 재고 수량 관리 로직 혹은 다른 처리
		this.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.
	} else {
        this.ermovePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
	}
}).close(function (data) {
    // 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
    console.log(data);
}).done(function (data) {
    //결제가 정상적으로 완료되면 수행됩니다
	//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
	console.log(data);
});
}