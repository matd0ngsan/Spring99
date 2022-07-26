package vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StampVO {
	private int seq;
	private String id;
	private String title;
	private int cnt;
	private String upfileO;
	private String upfileX;
	
	private MultipartFile upfilefO;
	private MultipartFile upfilefX;
}
