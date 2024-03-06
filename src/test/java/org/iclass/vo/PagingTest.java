package org.iclass.vo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iclass.dao.CommunityDao;
import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;
@Slf4j

class PagingTest {
	
	@Test
	void test() {
		//2페이지를 보고 싶다/ 글의 총개수: 258개, 한페이지의 글 목록:10개
		Paging page = new Paging(2, 230, 10);
		log.info("page 프로퍼티 계산 결과: {}",page);
		
	}

	//2페이지의 글 목록 가져오기
	@Test
	void getPageList() {
		Paging page = new Paging(2, 258, 10);
		Map<String, Integer> map = new HashMap<>();
		map.put("start", page.getStartNo());
		map.put("end", page.getEndNo());
		CommunityDao dao = CommunityDao.getInstance();
		List<Community> list = dao.pagelist(map);
		log.info("2페이지 글목록: {}",list);
		
	}
	
	
	@Test
	void getArticle() {
		//idx 259 글 1개 가져오기
		CommunityDao dao = CommunityDao.getInstance();
		Community comvo= new Community();
		long idx = 259;
		comvo = dao.selectByIdx(idx);
		log.info("idx 글: {}",comvo);
	}
	
	
	
	
	
	
}
