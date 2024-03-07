package org.iclass.service;

import static org.junit.jupiter.api.Assertions.*;

import java.security.NoSuchAlgorithmException;
import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;
@Slf4j

class HasingTest {

	@Test
	void test() {
		MemberService service = new MemberService();
		try {
			String hashvalue = service.encrypt("11111");
			log.info("해시 값: {}",hashvalue);
			String hashvalue2 = service.encrypt("thGh123!@4");
			log.info("해시 값: {}",hashvalue2);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}

}
