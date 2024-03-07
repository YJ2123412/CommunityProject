<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피24 북카페</title>
<!-- 상대경로는 ../css/community.css 입니다. request객체의 contextPath를 el로 접근할 때에는 현재 jsp 객체 pageContext 를 사용해야 합니다. -->
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<link rel="stylesheet" href="../assets/css/main.css" />
  		<link rel="stylesheet" href="../css/layout.css" />
		<link rel="stylesheet" href="../css/list.css">  <!-- 절대경로 -->
		<script src="https://kit.fontawesome.com/352c53403e.js" crossorigin="anonymous"></script>
</head>
<body class="is-preload">
<div id="page-wrapper">
<%@include file="../layout/header.jsp" %>
	<section style="overflow: hidden;" id="list">
  	
	<div style="padding: 2rem;width: 60rem;margin: auto;" class="table" >
	<div>
		<h3>북챗</h3>
		<p>오늘 무슨 책을 읽으셨나요? </p>
			<hr style="color:orange;">
			<ul id="main">
				<li>
					<ul  class="row">
						<li>번호</li>
						<li>제목</li>
						<li>작성자</li>
						<li>조회수</li>
						<li>작성일</li>
					</ul>
				</li>
				
			 	<c:forEach var="vo" items="${list}"> 
				<li>
					<ul  class="row">
						<li>
							<c:out value="${vo.idx }"/>
						</li>
						<li><a href="read?idx=${vo.idx }&page=${paging.currentPage}" class="title">  <!-- 현재페이지 번호 전달 시작 -순서1) -->
								<c:out value="${vo.title }"/>
							</a>
					 		..<span style="color:orange;font-size: 80%;">(<c:out value="${vo.commentCount }"/>)
					 		</span></li>
						<li>
							<c:out value="${vo.writer }"/><%-- (<c:out value="${vo.ip }"/>) --%>
						</li>
						<li>
							<c:out value="${vo.readCount }"/>
						</li>
					<li>
					<!-- vo.createdAt 날짜 패턴을 적용한 결과 문자열을 createdAt 새로운 변수로 저장 -->
					<fmt:formatDate value="${vo.createdAt }" pattern="yyyy-MM-dd" var="createdAt"/>
					<!-- 오늘 작성한 글은 시간으로 표시 -->
					<c:if test='${createdAt == today}'>
						<fmt:formatDate value="${vo.createdAt }" type="time"/>
					</c:if>
					<!-- 오늘 이전에 작성한 글은 날짜로 표시 -->
					<c:if test='${createdAt != today}'>
						<fmt:formatDate value="${vo.createdAt }" pattern="yyyy-MM-dd"/>
					</c:if>
					</li>
					
				</ul>
			</li>
		 	</c:forEach>
			</ul>
		</div>	
	<!-- <div style="float:right;margin:40px;"> -->
	<hr>
<%-- 		<a href="write?page=${paging.currentPage }" class="button" >글쓰기</a> --%>  
		<!-- 로그인 상태가 아니면 로그인으로 이동으로 변경 -->
		<button onclick="cwrite()">글쓰기</button>
<%-- 		<a href="${pageContext.request.contextPath}" class="button" >홈</a> --%>
	

<script type="text/javascript">
	function cwrite() {
		let yn
		if('${user.userid}'==''){
			yn=confirm('글쓰기는 로그인이 필요합니다. 로그인 하시겠습니까?')
			/* 로그인 후 글쓰기로 돌아가기 */
			if(yn) {
				// 로그인 후 글쓰기 화면 다시 요청하기 위해 url을 브라우저에 저장하기
				sessionStorage.setItem('back', './community/write');
				location.href='../login'  
			}
		}else{
			location.href='write?page=${paging.currentPage }'
		}
	}
</script>

<!-- 페이지 버튼을 클릭하면  url은  http://localhost:8081/iclass10_Board/community/list 는 동일하고 
	 page 번호 파라미터만 변경됩니다.  이런 경우 앞의 부분 생략하고 ? 부터 작성.
-->
			<div style="width:100%;margin: auto;padding: 10px;text-align: center;float: none;" class="list">
				전체 글 개수 : <c:out value="${paging.totalCount }"/> <br>
				<hr>
				<a class="pagenum" href="?page=1">&lt;&lt;</a>   <!--(1) 첫번째 페이지 1번으로 이동 -->
				
				<!--(2)  실행하면서 파악해보세요. --> <!-- 요청은 ListController가 받음.page파라미터 변경됨. -->
				<a class="pagenum" href="?page=${paging.startPage-1 }"      
						style='<c:if test="${paging.startPage==1 }">display:none;</c:if>' >&lt;</a>
				
				<!--(3) 페이지 범위 startPage 부터 endPage 까지 반복 -->
				<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
					<a class="pagenum ieach" href="?page=${i }"><c:out value="${i }"/></a>
				</c:forEach>
				
				<!--(4)  실행하면서 파악해보세요. -->
				<a class="pagenum" href="?page=${paging.endPage+1 }"
						style='<c:if test="${paging.endPage==paging.totalPage }">display:none;</c:if>'	>&gt;</a>
						
				<a class="pagenum" href="?page=${paging.totalPage }">&gt;&gt;</a>  <!--(5) 가장 마지막 페이지로 이동 -->
			</div>
	</div>
<!-- 	<div class="mycol-2" style="width:20rem;height: 50rem;float:right;">
			<img alt=""  width="100%" height="100%"style="object-fit:cover;" src="../images/bookcafe2.jpg">
	</div> -->
	<div data-num="5" id="datanum"></div>
</section>

 <script type="text/javascript">
	const pnums = document.querySelectorAll('.ieach');
	pnums.forEach(function(item){
		console.log(item);
		/* item 번호가 현재 페이지 이면 글꼴 스타일을 다르게함. */
		if(item.innerHTML=='${paging.currentPage}') {    
			item.classList.add('current')
		}else{
			item.classList.remove('current')
		}
	});
</script>
<%@ include file="../layout/footer.jsp" %>
</div>			
		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/browser.min.js"></script>
			<script src="../assets/js/breakpoints.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<script src="../assets/js/main.js"></script>
			<script src="../js/nav.js"></script>
			
</body>
</html>













