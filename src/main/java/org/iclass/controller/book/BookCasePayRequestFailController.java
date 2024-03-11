package org.iclass.controller.book;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.iclass.controller.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BookCasePayRequestFailController implements Controller {

	private static final Logger logger = LoggerFactory.getLogger(BookCasePayRequestFailController.class);

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Map<String,Object> payErr = new HashMap<>();
		payErr.put("code", request.getParameter("code"));
		payErr.put("orderId", request.getParameter("orderId"));
		payErr.put("message", request.getParameter("message"));
		
		logger.info("payErr : {}",payErr);
		request.setAttribute("payErr", payErr);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("reqfail.jsp");
		dispatcher.forward(request, response);
	}

}
