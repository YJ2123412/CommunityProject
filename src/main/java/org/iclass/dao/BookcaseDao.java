package org.iclass.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.iclass.vo.BookcaseBook;
import org.iclass.vo.SalePayDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mybatis.SqlSessionBean;

public class BookcaseDao {
	private static final Logger logger = LoggerFactory.getLogger(BookcaseDao.class);
	private static BookcaseDao dao = new BookcaseDao();
	private BookcaseDao() {}
	public static BookcaseDao getInstance() {
		return dao;
	}
	
	public List<BookcaseBook> saleList(Map<String,String> map) {
		SqlSession sqlSession = SqlSessionBean.getSession();
		List<BookcaseBook> list = sqlSession.selectList("bookcase.saleList",map);
		logger.info("saleList :{}",list);
		sqlSession.close();
		return list;
	}
	
	public BookcaseBook getOne(String bcode) {
		SqlSession sqlSession = SqlSessionBean.getSession();
		BookcaseBook book = sqlSession.selectOne("bookcase.getOne",bcode);
		sqlSession.close();
		return book;
	}
	
	public int saleOne(SalePayDetails book) {
		SqlSession sqlSession = SqlSessionBean.getSession();
		int result=0;	
		try{
			result = sqlSession.insert("bookcase.saleOne",book);
			sqlSession.update("bookcase.changeStatus",book.getBcode());
			sqlSession.commit();
		}catch(Exception e) {
			logger.warn("도서 구매 오류 : {}",e.getMessage());
			sqlSession.rollback();
		}finally {
			sqlSession.close();
		}	
		return result;
	}
	
	/*
	 * public int changeStatus(String bcode) { SqlSession sqlSession =
	 * SqlSessionBean.getSession(); return null; }
	 */
}
