package kr.ezen.guest.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GuestBookVO {
	private int idx;
	private String title;
	private String name;
	private String password;
	private String content;
	private Date regdate;
	private int vcount;
	private String ip;
}
