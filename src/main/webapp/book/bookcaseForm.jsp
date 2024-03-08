<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>커피24 북카페</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../css/layout.css" />
	<link rel="stylesheet" href="../assets/css/style.css" />  <!-- 회원가입 (temp.css 는 미사용)-->
	<link rel="stylesheet" href="../assets/css/main.css" />	
	<link rel="stylesheet" href="../css/book.css" />
	<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
	<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
</head>
	<body class="is-preload">
		<div id="page-wrapper">
			<!-- Header -->
			<%@ include file="../layout/header.jsp" %>
			<section id="book">
			<h3>책장</h3>
			<p class="sub">판매할 중고도서를 등록하세요.</p>
			<hr style="color:white;">
			<form action="save" method="POST" enctype="multipart/form-data">
			<!--enc 속성 꼭 확인, 파일과 문자열 데이터를 같이 보낼때 필요  -->
			<table style="width:50rem;"> 
			<tr>
				<th><label>판매자 아이디</label></th>			
				<td><input name="saleuser" value="${user.userid }" readonly></td>
			</tr>
			<tr>
				<th><label>판매 코드</label></th>			
				<td><input name="bcode" required></td>
			</tr>
			<tr>
				<th><label>책 제목</label></th>			
				<td><input name="title" required></td>
			</tr>
			<tr>
				<th><label>도서 이미지</label></th>			
				<td><input type="file" name="cover" accept="image/*" required></td>
			</tr>
			<tr>
				<th><label>저자</label></th>			
				<td><input name="writer" required></td>
			</tr>
			<tr>
				<th><label>출판사</label></th>			
				<td><input name="publisher" required></td>
			</tr>
			<tr>
				<th><label>출판일자</label></th>			
				<td><input name="pubdate" placeholder="YYYY-MM-DD"></td>
			</tr>
			<tr>
				<th><label>가격</label></th>			
				<td><input type="number" name="price" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">저장</button>
					<button type="reset">다시쓰기</button>
					<button type="button" onclick="location.href='bookcase'">목록</button>
				</td>
			</tr>
			
			</table>
			</form>
			
			
			
			</section>
			 <div data-num="3" id="datanum"></div>
		</div>		 
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
				<script src="../assets/js/browser.min.js"></script>
			<script src="../assets/js/breakpoints.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<script src="../assets/js/main.js"></script>
			<script src="../js/nav.js"></script>
			<script src="../js/editor.js"></script>
</body>
</html>
