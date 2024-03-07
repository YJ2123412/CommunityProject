<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
			<!-- Header -->
				<div id="header">
					<!-- Logo -->
						<h1><a href="${pageContext.request.contextPath }" id="logo">커피24 <em>북카페</em></a></h1>

					<!-- Nav -->
						<nav id="nav">
							<ul id="menu-a">
								<li><a href="${pageContext.request.contextPath }">Home</a></li>								
								<li>
									<a href="#">북카페</a>
									<ul id="bookcafe">
										<li><a href="#">우리동네 소개</a></li>
										<li><a href="${pageContext.request.contextPath }/notice/list">이용안내</a></li>
										<li><a href="${pageContext.request.contextPath }/community/list">공지사항</a></li>
									</ul>
								</li>
														
							</ul>
						</nav>
				</div>
			<script type="text/javascript">
					
					sessionStorage.removeItem('datanum')
					document.querySelector('#menu-a > li').addEventListener('click',evt=>{
  							evt.preventDefault()
  							evt.stopPropagation()	
  							const target = evt.target
							if(target.tagName !='A') return
							sessionStorage.setItem('datanum',0)
							location.href = target.href
	  				 })
						
					  	
					document.querySelectorAll('#bookcafe li').forEach( item => {
							item.querySelector('a').addEventListener('click',function(evt){
							evt.preventDefault()
							evt.stopPropagation()	
							const target = evt.target
							if(target.tagName !='A') return
							sessionStorage.setItem('datanum', 1)
							location.href = target.href
							})
						
						})
					
					
				</script>