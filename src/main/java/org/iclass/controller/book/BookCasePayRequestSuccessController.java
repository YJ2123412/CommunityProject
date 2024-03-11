package org.iclass.controller.book;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.iclass.controller.Controller;
import org.iclass.dao.BookcaseDao;
import org.iclass.vo.BookcaseBook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class BookCasePayRequestSuccessController implements Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(BookCasePayRequestSuccessController.class);

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
//		Map<String,Object> payMap = new HashMap<>();
//		payMap.put("paymentType", request.getParameter("paymentType"));
//		payMap.put("orderId", request.getParameter("orderId"));
//		payMap.put("paymentKey", request.getParameter("paymentKey"));
//		payMap.put("amount", request.getParameter("amount"));
//		
//		logger.info("payMap : {}",payMap);
//		request.setAttribute("payMap", payMap);
//		
		String orderId = request.getParameter("orderId");
		int amount = Integer.parseInt(request.getParameter("amount"));
		BookcaseDao dao = BookcaseDao.getInstance();
		BookcaseBook item = dao.getOne(orderId.substring(0, 7));
		if(item.getPrice() != amount)
						throw new IOException("금액에 문제가 있습니다.");
		
		
		////////////////////

        // API 엔드포인트 및 요청 데이터
        String apiUrl = "https://api.tosspayments.com/v1/payments/confirm";
        String paymentKey = request.getParameter("paymentKey");
        //amount , orderId도 필요함.
        
        // Authorization 헤더 생성
        String secretKey = "";
        String authorizationHeader = createAuthorizationHeader(secretKey);

        // JSON 데이터 생성
        String jsonData = String.format("{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}", paymentKey, amount, orderId);

        // HTTP POST 요청 보내기
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        // 요청 메소드 설정
        connection.setRequestMethod("POST");

        // 헤더 설정
        connection.setRequestProperty("Authorization", authorizationHeader);
        connection.setRequestProperty("Content-Type", "application/json");

        // POST 데이터를 전송 가능하도록 설정
        connection.setDoOutput(true);

        // POST 데이터 전송
        try (DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream())) {
            outputStream.writeBytes(jsonData);
            outputStream.flush();
        }

        // 응답 코드 확인
        int responseCode = connection.getResponseCode();
        if(responseCode != 200 && responseCode != 201) 
    		throw new IOException("결제 오류가 발생했습니다.");
        
        logger.info("Response Code: {}" , responseCode);
        String payment=null;
        // 응답 데이터 읽기
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String line;
            StringBuilder responseStr = new StringBuilder();
            while ((line = reader.readLine()) != null) {
            	responseStr.append(line);
            }
            payment=responseStr.toString();
            logger.info("Response: {}" , payment);
       }
              
        // 연결 종료
        connection.disconnect();
		request.setAttribute("payment", payment);
		request.setAttribute("item", item);
		RequestDispatcher dispatcher = request.getRequestDispatcher("success.jsp");
		dispatcher.forward(request, response);

	}

	
	 private static String createAuthorizationHeader(String secretKey) {
	        String credentials = secretKey + ":";
	        String encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes(StandardCharsets.UTF_8));
	        return "Basic " + encodedCredentials;
	    }
}
/*

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
            Date parsedDate = dateFormat.parse(dateString);

            // java.sql.Timestamp로 변환
            Timestamp timestamp = new Timestamp(parsedDate.getTime());
            
              SalePayDetails dto = SalePayDetails.builder()
        					.bcode(orderId)
        					.amount(amount)
        					.buyUser("")
        					.build();
            */
