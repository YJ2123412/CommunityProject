package org.iclass.controller.community;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.iclass.controller.Controller;
import org.iclass.dao.CommunityDao;
import org.iclass.vo.Community;
import org.iclass.vo.DemoMember;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// 요청 매핑 :	mapping.put(new RequestKeyValue("/community/update","GET"), new UpdateViewController() );
public class UpdateViewController implements Controller {
	private static final Logger logger = LoggerFactory.getLogger(UpdateViewController.class);

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//수정 화면으로 데이터 보내기 구현해 보세요.
		//지정된 idx 메인글 가져오기
				String temp = request.getParameter("idx");			//메인글 글번호 파라미터로 받기
				long idx=0;
				
				//1)현재 접속한 세션에서 사용자 정보를 읽어오기
				HttpSession session = request.getSession();
				DemoMember user = (DemoMember) session.getAttribute("user");
				try {
					idx = Long.parseLong(temp);
					CommunityDao dao = CommunityDao.getInstance();
					Community vo = dao.selectByIdx(idx);
					
				//2) idx 글 작성자와 로그인 작성자 비교-불일치시 수정 불가, 예외 발생 (url에서 임의로 idx 변경 가능하기에 )
					//인가(권한) 확인:Authorization, 인증(로그인 -> 사용자 확인):Authentication  -> 따로 라이브러리 존재함/현재는 코딩으로
				if(vo==null || !vo.getWriter().equals(user.getUserid())) throw new RuntimeException();
					request.setAttribute("vo", vo);				
					
					//현재페이지를 read.jsp에서 받아 update.jsp로 전달합니다.
					logger.info(":::::::UpdateViewController page - {} ::::::::::",request.getParameter("page"));
					request.setAttribute("page",request.getParameter("page") ); 	//현재페이지 번호 전달 - 순서4)
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
					dispatcher.forward(request, response);
				}catch (NumberFormatException e) {
					response.sendRedirect("list");
				}
				
				

	}

}
