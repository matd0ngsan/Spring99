package vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//** VO (Value Object) , DTO (Data Transfer Object)
//=> 자료의 구조를 표현하는 클래스이며, 자료의 전달에 이용됨
//=> 대부분 Table 별로 만들며, Table 과 동일한 필드(컬럼)명을 사용한다.
//=> Table과 무관하게 자료전달용으로만 정의한 경우 DTO라 함.

@Data
public class MemberVO {
	
	private String id;
	private String password;
	private String name;
	private int lev;
	private int scheck;

} //class
