<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE HTML>
<!--
	Arcana by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->
<html>
	<head>
		<title>커피24 북카페</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../assets/css/main.css" />
		<link rel="stylesheet" href="../css/layout.css" />
		<link rel="stylesheet" href="../css/booklist.css" />
	</head>
	<body class="is-preload">
		<div id="page-wrapper">

			<%@ include file="../layout/header.jsp" %>

			<!-- Main -->
				<section class="wrapper style1">
					<div class="container">
						<div class="row gtr-200">
							<div class="col-3 col-12-narrower">
								<div id="sidebar1">
								</div>
							</div>
							<div class="col-6 col-12-narrower imp-narrower">
								<div id="content">

									<!-- Content -->

										<article>
											<header>
												<h2>결제 완료</h2>
												<h3 id="result">결제 내역입니다.</h3>
											</header>
											
											<div style="margin-bottom: 1em;">
												<img src="../images/bookcase/${item.cover}" width="90px">
											</div>
											<div  class="info">
												<p>
												<span>도서명:</span>
												<span class="title" id="orderName"></span>(<span id="orderId"></span>)
												</p>
												<p>
												<span>가격:</span>
												<span class="title"><fmt:formatNumber value="${item.price }" pattern="###,###"/> 원</span>
												</P>
												<span>총 결제금액:</span>
												<span class="title" id="amount"></span>
												<br>
												결제카드 : <span id="cardtype"></span> <span id="method"></span> (<span id="cardno"></span>)<br> 
												승인날짜 : <span class="title" id="paydate"></span>
											</div>
											<div class="paybtn">
												<h4>구매하신 도서는 2일 이내 도착하도록 배송해 드리겠습니다.</h4>
												<a class="btn btn-primary ok" href="/DemoProject">⛪홈</a>&nbsp;&nbsp;&nbsp;
												<a class="btn btn-primary ok" href="../book/bookcase">📚책장더보기</a>
											</div>
										</article>

								</div>
							</div>
							<div class="col-3 col-12-narrower">
								<div id="sidebar2">

								</div>
							</div>
						</div>
					</div>
				</section>

				<%@ include file="../layout/footer.jsp" %>
				<div data-num="3" id="datanum"></div>
		</div>

		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/browser.min.js"></script>
			<script src="../assets/js/breakpoints.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<script src="../assets/js/main.js"></script>
			<script src="../js/nav.js"></script>
			<!-- 비동기 http 통신 axios api-->
			<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script type="text/javascript">
		const responseData='${payment}'		//토스에서 보내준 응답
		const payment = JSON.parse(responseData)//자바스크립트 객체로 변환
		const buyuser ='${user.userid}'
		console.dir(payment)

		//비동기 통신의 다른 방법 axios(lib) : 우리 서버에 table 정보를 insert 하기 위한 통신
		//함수 requestPaymentSave는 async(비동기)처리한다는 뜻
		async function requestPaymentSave(payReq){
			//await 은 axios가 post 요청을 보낸 후 응답을 기다린다는 의미
			//비동기 함수 안에서 다른 비동기 함수를 기다리도록 함
			const result = await axios.post('../api/pay',payReq)
			console.log(result)
			return result.data //응답의 data (정해진 이름)프로퍼티를 리턴
		}
		
		//토스가 보내준 응답 payment 값을 api/pay로 보내고 db에 insert 할 것
		const payReq = {bcode: payment.orderId.substring(0,7),
						orderid: payment.orderId , 
						amount: payment.totalAmount, 
						buyuser:buyuser, 
						paydate:payment.approvedAt ,
						paytype : payment.card.cardType + ' ' + payment.method, 
						paymentkey:payment.paymentKey }
		
		//requestPaymentSave 함수 실행. 데이터는payReq
		requestPaymentSave(payReq)
		.then(result => {				//then은 요청 성공시 실행(axios 메소드)
		//결제 승인정보 출력
			document.querySelector('#result').innerHTML = result
			document.querySelector('#orderId').innerHTML = payment.orderId
			document.querySelector('#orderName').innerHTML = payment.orderName
			document.querySelector('#cardtype').innerHTML = payment.card.cardType
			document.querySelector('#method').innerHTML = payment.method
			document.querySelector('#cardno').innerHTML = payment.card.number
			document.querySelector('#paydate').innerHTML = payment.approvedAt
			document.querySelector('#amount').innerHTML = payment.totalAmount.toLocaleString() + '원'
		})
		.catch(e=> {	//요청에 오류 생겼을때 실행(axios 메소드)
			console.error(e.response)
			location.href='../invalid.html'
		})
		
		
	</script>
	</body>
</html>