package org.iclass.controller;

import java.util.HashMap;
import java.util.Map;


public class RequestControllerMapping {
	private static final Map<RequestKeyValue,Controller> mapping = new HashMap<>();
	
	public static void init() {
		//설계된 url,method 에 따라 처리할 controller 구현체를 Key,Value 로 HashMap에 저장합니다.
//		mapping.put(new RequestKeyValue("/community/list", "GET"), new ListController() );
//		mapping.put(new RequestKeyValue("/community/write","GET"), new WriteViewController() );
//		mapping.put(new RequestKeyValue("/community/write","POST"), new WriteController() );
//		//게시판 글 상세보기 ,수정하기,삭제하기
//		mapping.put(new RequestKeyValue("/community/read", "GET"), new ReadController() );
//		mapping.put(new RequestKeyValue("/community/update","GET"), new UpdateViewController() );
//		mapping.put(new RequestKeyValue("/community/update","POST"), new UpdateController() );
//		mapping.put(new RequestKeyValue("/community/delete","GET"), new DeleteController() );		//오류 처리 위해 POST로 변경
//		mapping.put(new RequestKeyValue("/community/comments","POST"), new CommentsController());
//		//회원가입
//		mapping.put(new RequestKeyValue("/join","GET"), new MemberJoinController());
//		mapping.put(new RequestKeyValue("/join","POST"), new MemberSaveController());
//		mapping.put(new RequestKeyValue("/auth/cert/sms","GET"), new AuthCertSMSController());
//		
//		// api mapping
//		mapping.put(new RequestKeyValue("/api/auth/checkId", "POST"), new ApiCheckIdController() );
//		mapping.put(new RequestKeyValue("/api/auth/join", "POST"), new ApiMemberJoinController() );

	}
	//url,method 필드를 저장하는 key 를 전달받아 HashMap에서 value(컨트롤러)를 리턴
	public static Controller getController(RequestKeyValue key) {
		return mapping.get(key);
	}
}
