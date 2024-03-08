package org.iclass.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BookcaseBook {
	private String bcode;
	private String title;
	private String writer;
	private String publisher;
	private String pubdate;
	private String saleuser;
	private int price;
	private String cover;
	private String status;


}
