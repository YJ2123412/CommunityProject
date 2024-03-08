package org.iclass.controller.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.iclass.controller.Controller;
import org.iclass.dao.BookcaseDao;
import org.iclass.vo.BookcaseBook;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class BookCaseSaveController implements Controller {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");	
		//사용자가 업로드한 파일이 저장될 서버 경로(파일 시스템 경로)
		
		String path ="C:\\Users\\YJ\\git\\DemoProject\\img";
		
		//압로드 가능한 최대 크기(바이트) ->10mbyte
		int maxSize = 10*1024*1024;
		MultipartRequest multipartRequest = new MultipartRequest(request, 
				path,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
		//DefaultFileRenamePolicy는 중복된 파일명에 대해 새로 파일명 부여하는 규칙(파일명뒤 일련번호)
		
		//기존처럼 받아오기(문자열도 multipartrequest 사용)
		String bcode= multipartRequest.getParameter("bcode");
		String title= multipartRequest.getParameter("title");
		String writer= multipartRequest.getParameter("writer");
		String publisher= multipartRequest.getParameter("publisher");
		String pubdate= multipartRequest.getParameter("pubdate");
		String saleuser= multipartRequest.getParameter("saleuser");
		String status= multipartRequest.getParameter("status");
		int price = Integer.parseInt(multipartRequest.getParameter("price"));
		
		//서버의 파일 시스템 path 경로에서 파일이 생겻는지 확인하기
		//서버로 업로드 된 파일의 이름 확인
		String cover= multipartRequest.getFilesystemName("cover");
		
		BookcaseBook book = new BookcaseBook(bcode, title, writer, publisher, pubdate, saleuser, price, cover, null);
		log.info("::: book {} :::", book); 
		
		BookcaseDao dao = BookcaseDao.getInstance();
		String url;
		url = "bookcase";
		int result = 0;
		try {
			result = dao.register(book);
			if(result!=1) {
				url="new";
			}
		} catch (Exception e) {
		}
		response.sendRedirect(url);
		//todo 이전 예제 참고, 등록 실패시 쿠키 이용해 메세지 전달하기 
	}
}
