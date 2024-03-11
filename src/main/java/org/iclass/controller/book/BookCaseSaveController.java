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
		//사용자가 업로드한 파일이 저장될 서버 경로(파일시스템 경로)
		String path = "D:\\Class231228\\upload";
		// 서버의 로컬 경로에 대해 url 을 지정합니다 -> 톰캣 server.xml
		// <Context docBase="D:/Class231228/upload" path="/upload"/> 추가하기
		
		//업로드 가능한 최대 크기(바이트)
		int maxSize = 10*1024*1024;		//1024바이트=1KB, 10MByte로 설정
		
		//request 는 파일을 받을 수 있는 MultipartRequest 로 사용해야 합니다. : cos 라이브러리 추가
		MultipartRequest multiRequest = new MultipartRequest(request, 
				path,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy());		
		//DefaultFileRenamePolicy는 중복된 파일명에 대해 새로 파일명 부여하는 규칙(파일명뒤에 일련번호)
		
		//기존 방식처럼 text 타입 등 파라미터 받아오기 - 문자열 파라미터도 MultipartRequest 를 사용합니다.
		String bcode = multiRequest.getParameter("bcode");
		String title = multiRequest.getParameter("title");
		String temp = multiRequest.getParameter("writer");
		String publisher = multiRequest.getParameter("publisher");
		String pubdate = multiRequest.getParameter("pubdate");
		String saleuser = multiRequest.getParameter("saleuser");
		int price = Integer.parseInt(multiRequest.getParameter("price"));
		// 서버의 파일 시스템 D:\\Class231228\\upload 경로에서 파일이 생겼는지 확인하기

		//서버로 업로드된 파일의 파일명 저장
		String cover = multiRequest.getFilesystemName("cover");
		
		BookcaseBook book = new BookcaseBook(bcode, title, temp, publisher, pubdate, saleuser, price, cover, null);
		log.info("::: book-{}  :::",book);   
		
		BookcaseDao dao = BookcaseDao.getInstance();
		String url="bookcase";
		int result=0;
		try {
			result = dao.register(book);
			if(result!=1) {
				//todo : 이전 예제 참고해서 등록 실패하면 쿠키 이용해서 메시지를 전달해 주세요.
				url="new";
			}
		}catch (Exception e) {
		}

		response.sendRedirect(url);
	}

}




