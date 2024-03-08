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
		<link rel="stylesheet" href="../css/bookmodal.css" />	
		<link rel="stylesheet" href="../css/layout.css" />
		<link rel="stylesheet" href="../assets/css/style.css" />  <!-- 회원가입 (temp.css 는 미사용)-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<link rel="stylesheet" href="../css/booklist.css"> 
		<script src="https://kit.fontawesome.com/352c53403e.js" crossorigin="anonymous"></script>
	</head>
	<body class="is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<%@ include file="../layout/header.jsp" %>
			<!-- Main -->
			<section id="booklist">
				<h3>책장</h3>
				<p>판매 중인 중고도서입니다.</p>
				<hr style="color:white;">
				<div id="mainarea">
					<c:forEach var="bo" items="${saleList }">
					<div class="gallery bookcase">
						<div style="height:80%;">
							<img src="../images/bookcase/${bo.cover }" alt="${bo.title }">
						</div>
						<div  class="intro">	
							<c:if test="${bo.status=='N' }">
								<i class="fa-solid fa-circle-xmark"></i> 판매완료
							</c:if>
							<c:if test="${bo.status=='Y' }">
								<a data-all="${bo.bcode},${bo.title},${bo.price},${bo.saleuser}"><i class="fa-regular fa-circle-play"></i> 구매하기</a>
							</c:if>
							<div>
							<c:out value="${bo.title }"/> (<fmt:formatNumber value="${bo.price }" pattern="###,###"/> 원)
							</div>
							<div><span style="font-size: 0.8em;">판매회원</span> : <c:out value="${bo.saleuser }"/></div>
						</div>
					</div>
					</c:forEach>
				</div>
			</section>
				
			<%@ include file="../layout/footer.jsp" %>
			<div data-num="3" id="datanum"></div>
		</div>

<!-- The Modal -->
<div class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title">책장-도서구매</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="pay">
						<h3 id="saleuser" class="inline"></h3>
						<span>님이 <br>판매하시는 도서를 구매하시겠습니까? </span>
						<hr> 
						<div>제목</div>
						<h4 id="title"></h4>
						<div>판매 가격</div>
						<h3 id="price" class="inline"></h3>원
					</div>	
					<div class="pay">
							<!-- 결제 UI, 이용약관 UI 영역 -->
							  <div id="payment-method"></div>
							  <div id="agreement"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					  <!-- 결제하기 버튼 -->
					  <button id="payment-button" type="button" class="btn btn-primary">결제하기</button>
				</div>
			</div>
		</div>
	</div>

		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/browser.min.js"></script>
			<script src="../assets/js/breakpoints.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<script src="../assets/js/main.js"></script>
			<script src="../js/nav.js"></script>
			<!-- 부트스트랩 - 모달 사용 -->
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
			<!-- 비동기 http 통신 axios api-->
			<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
			<!-- 결제위젯 SDK 추가 -->
  			<script src="https://js.tosspayments.com/v1/payment-widget"></script>
  	<script type="text/javascript">
	const obj ={}
	let orderid=''
  	</script>		
  	<script src="../js/bookcase.js"></script>		
	<script>
	  	const modal = new bootstrap.Modal(document.querySelector(".modal"))  /* 부트스트랩의 모달 기능을 제공하는 객체*/
		document.querySelector("#mainarea").addEventListener('click',function(evt){
			evt.preventDefault()			//a 태그 등 pagination 안에 있는 기본 클릭 동작을 중지
			//evt.stopPropagation()			//클릭 이벤트는 자식 또는 부모요소에 전달되는데 그것을 중지
			const target = evt.target
			if(target.tagName !== 'A') {return}			

			let yn
			if('${user.userid}'==''){
				yn=confirm('글쓰기는 로그인이 필요합니다. 로그인 하시겠습니까?')
				/* 로그인 후 글쓰기로 돌아가기 */
				if(yn) {
					sessionStorage.setItem('back', 'book/bookcase');
					location.href='../login'  // 로그인 후 글쓰기 url로 redirect 하기 위한 파라미터
				}
			}else {
			
			const datas = target.getAttribute("data-all")
			const arr = datas.split(",");
			obj.bcode = arr[0];
			obj.title = arr[1];
			obj.price = arr[2];
			obj.saleuser = arr[3];
			
			const now = new Date();
			orderid = now.toISOString().replace(/\D/g, '').slice(2, 14);
	//		const obj = {bcode :arr[0] ,title:arr[1] , price :arr[2] , saleuser:arr[3] }
			document.querySelector(".modal-body #saleuser").innerHTML = obj.saleuser
			document.querySelector(".modal-body #title").innerHTML = obj.title
			document.querySelector(".modal-body #price").innerHTML = Number(obj.price).toLocaleString("ko-KR")
			modal.show();
			tossPayInit();
			}
		})
		
</script>			
	</body>
</html>