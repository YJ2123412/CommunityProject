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
		const responseData='${payment}'
		const payment = JSON.parse(responseData)
		const buyuser ='${user.userid}'
		console.dir(payment)

		async function requestPaymentSave(payReq){
			const result = await axios.post('../api/pay',payReq)
			console.log(result)
			return result.data
		}
		
		const payReq = {bcode: payment.orderId.substring(0,7),
						orderid: payment.orderId , 
						amount: payment.totalAmount, 
						buyuser:buyuser, 
						paydate:payment.approvedAt ,
						paytype : payment.card.cardType + ' ' + payment.method, 
						paymentkey:payment.paymentKey }
		
		requestPaymentSave(payReq)
		.then(result => {
			document.querySelector('#result').innerHTML = result
			document.querySelector('#orderId').innerHTML = payment.orderId
			document.querySelector('#orderName').innerHTML = payment.orderName
			document.querySelector('#cardtype').innerHTML = payment.card.cardType
			document.querySelector('#method').innerHTML = payment.method
			document.querySelector('#cardno').innerHTML = payment.card.number
			document.querySelector('#paydate').innerHTML = payment.approvedAt
			document.querySelector('#amount').innerHTML = payment.totalAmount.toLocaleString() + '원'
		})
		.catch(e=> {
			console.error(e.response)
			location.href='../invalid.html'
		})
		
		
	</script>
	</body>
</html>