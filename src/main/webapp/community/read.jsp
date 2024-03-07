<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<title>커피24 북카페</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<link rel="stylesheet" href="../assets/css/main.css" />
 	<link rel="stylesheet" href="../css/layout.css" />
	<link rel="stylesheet" href="../css/read.css?v=3">
	<script src="https://kit.fontawesome.com/352c53403e.js" crossorigin="anonymous"></script>
<!-- 	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
</head>
<body class="is-preload">
<div id="page-wrapper">
	<%@include file="../layout/header.jsp" %>
	<section id="read" style="overflow: hidden;">
	<h3>북챗 :: 커뮤니티</h3>
	<p>오늘 무슨 책을 읽으셨나요? </p>
	<hr style="color:white;">
		<ul id="table24">
			<li>
				<ul class="mrow2">
					<li>제목</li>
					<li><c:out value="${vo.title}"/></li>
				</ul>
			</li>
			<li>
				<ul class="mrow2">
					<li>작성자</li>
					<li><c:out value="${vo.writer}"/>
					<span style="font-size: 70%; padding-left: 30px;">(<c:out value="${vo.ip}"/>)</span></li>
				</ul>
			</li>
			<li>
				<ul class="mrow4">
					<li>작성날짜</li>
					<li><fmt:formatDate value="${vo.createdAt }" type="both"/></li>
					<!-- pattern="yyyy-MM-dd HH:mm:ss , type= date,time,both -->
					<li>조회수</li>
					<li><c:out value="${vo.readCount}"/></li>
				</ul>
			</li>
			<li id="content">
				<ul>
					<li>내용</li>			
					<!-- textarea에 입력한 엔터는 \n db에도 \n으로 저장됩니다.
					     브라우저 출력은 줄바꿈은 <br> 태그 해결1) pre 태그, 해결  2) \n을 <br>로 대치-->	
					<li>
						<pre><c:out value="${vo.content}"/></pre>
					</li>				
				</ul>
			</li>
		</ul>
	<div style="text-align: center;margin-bottom: 10px;">
	<c:if test="${user.userid==vo.writer }">  <!-- session 에 저장된 user애트리뷰트의 id와 작성자의 id 가 같은면 보이기 -->
		<a class="button" href="javascript:execute(1)">수정</a>  <!-- 자바스크립트 함수:인자값 1은 수정 -->
		<!--  예시 : 글 비밀번호 입력하여 삭제. -->
		<a class="button" href="javascript:execute(2)">삭제</a>  <!-- 자바스크립트 함수:인자값 2는 삭제  -->
	</c:if>
		<a class="button" href="list?page=${page }">목록</a>   <!-- 현재페이지 번호 전달 - 순서3) -->
	</div>
	<script type="text/javascript">
		function execute(f){
			let url
			let message
			if(f===1){			//아래 url 변수와 같이 조건삼항연산자로 변경가능
				message='글 수정하시겠습니까?'
			}else if(f===2){
				message='글 삭제하시겠습니까?'
			}
			const yn = confirm(message)
			if(yn) {
				url = (f===1)? 'update?idx='+${vo.idx} :(f===2)? 'delete?idx='+${vo.idx}:'#';
				location.href=url+'&page='+${page};  /* 현재페이지 번호 전달 - 순서3) */
			}else{
				alert('취소합니다.')
			}	
		}
	</script>
	<!-- 메인글 출력 끝 -->
	
	<hr>
	<!-- 댓글 등록 -->
	<form action="comments" method="post">
	<!-- 필요한 파라미터.화면에는 표시안함. -->
	<input type="hidden" name="mref" value="${vo.idx }">  <!-- 댓글 추가할 메인글의 idx(댓글테이블 mref.고정값)  -->
	<input type="hidden" name="idx" value="0" >	<!-- 삭제할 댓글의 idx(고정값 아님)는 executeCmt 함수에서 설정  -->
	<input type="hidden" name="f" value="0">
	<input type="hidden" name="page" value="${page }">  <!-- 현재페이지 번호 전달 - 순서8) -->
	<input type="hidden" name="writer" class="input" value="${user.userid }">
	<!-- 구현 보류 : 로그인한 사용자가 작성할때는 로그인 이메일,닉네임 가져와서 표시 -->			
		<ul>
			<%-- <li>${user.userid }</li> --%>
			<li>
				<ul style="display: flex;flex-direction: column;">
					<li>
						<textarea rows="5" cols="90" name="content" 
						style="resize:none;margin-right:20px;" 
						placeholder="로그인 후에 댓글을 작성하세요." class="input"></textarea>
					</li>				
					<li style="align-self: center;margin-bottom: 20px;">
<!-- 저장버튼 테스트를 위해 변경 --><c:if test="${sessionScope.user != null }">  <!-- 구현 보류 : 로그인 했을때 -->
								<button type="button" onclick="executeCmt('1',0)">저장</button>  <!-- 2번째 인자 0은 의미없음. -->
							</c:if>	
							<c:if test="${sessionScope.user == null }">		<!-- 구현 보류  : 로그인 안했들때 -->
								<button type="button" onclick="login()">로그인</button>
							</c:if>
					</li>
				</ul>
			</li>
			<li>
					<span>댓글</span>
					<span>[<c:out value="${vo.commentCount }" />]</span> <!-- 댓글갯수 -->
				<hr>
			</li>
			
			<!-- 댓글 목록 -->
			<c:forEach var="cmt" items="${cmtlist}">
			<li>
				<ul class="crow">
					<li><c:out value="${cmt.writer }" /></li>				
					<li><c:out value="${cmt.ip }" /></li>				
					<li><c:out value="${cmt.createdAt }" /></li>	
				<c:if test="${user.userid==cmt.writer }">  <!-- session 에 저장된 user애트리뷰트의 id와 작성자의 id 가 같은면 보이기 -->		
					<li><a href="javascript:executeCmt('2','${cmt.idx }')">삭제</a></li>				
				</c:if>	
				</ul>
			</li>
			<li>
				<pre class="cmtcontent"><c:out value="${cmt.content }" /></pre>
			</li>
			</c:forEach>
		</ul>	
	</form>
</section>	
<div data-num="5" id="datanum"></div>
</div>
<script type="text/javascript">
	const user = '${user.userid}'
	const txtarea = document.querySelector('textarea')
	if(user.length !=0)
		txtarea.placeholder = user + '님 댓글을 작성하세요.'

	function executeCmt(fval,cidx){	/* 댓글 작성추가 와 삭제는 매개변수 f의 값으로 구별한다. idx는 매개변수는 삭제할 댓글번호 */
		console.log(fval)
		document.forms[0].f.value=fval
		if(fval==='2') {
			document.forms[0].idx.value=cidx		/* hidden 타입 idx의 value 로 설정*/
			const yn = confirm('댓글 삭제하시겠습니까?')
			if(yn)	document.forms[0].submit()	
		}else if(fval==='1'){
			document.forms[0].submit()			
		}
	}
	
	function reset_content() {
		document.forms[0].content.value=''
	}
	
	function login() {
		sessionStorage.setItem('back', location.href);
		location.href='../login'  // 로그인 후 글쓰기 url로 redirect 하기 위한 파라미터
	}
	
	var back = sessionStorage.getItem('back');
	if(back) {
		location.href=back;
		sessionStorage.removeItem('back');
	}
</script>
			<script src="../js/nav.js"></script>

</body>
</html>