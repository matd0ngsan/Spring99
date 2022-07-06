<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis Ajax_MemberList **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest01.js"></script>
<script src="resources/myLib/axTest02.js"></script>
</head>
<body>
<!-- ** 반복문에 이벤트 적용하기 
=> 과제 : id 클릭하면 이 id가 쓴 글목록(board)을 resultArea2 에 출력하기 
1) JS : Tag의 onclick 이벤트속성(리스너) , function 이용
=> id 전달: function 의 매개변수를 이용 -> aidBList('banana') 
=> a Tag 를 이용하여 이벤트적용
	   -> href="" 의 값에 따라 scroll 위치 변경 가능.
		  <a href="" onclick="aidBList('banana')" >....
	   -> href="#"      .... scroll 위치 변경 
		 	"#" 에 #id 를 주면 id의 위치로 포커스를 맞추어 이동,
		 	 #만 주면 포커스가 top 으로 올라감 (새로고침과 동일효과)
	   -> href="javascript:;" ...... scroll 위치 변경 없음

2) JQuery : class, id, this 이용
=> 모든 row 들에게 이벤트를 적용하면서 (class 사용)
   해당되는(선택된) row 의 값을 인식 할 수 있어야 함 (id 활용) 
-->

<h2>** Spring Mybatis Ajax_MemberList **</h2>

<c:if test="${not empty message}" >
=> ${message} 
</c:if>
<hr>
<table width=100%>
	<tr bgcolor="Lavender" height=30>
		<th>I D</th><th>Password</th><th>Name</th><th>Level</th>
		<th>Birthday</th><th>Point</th><th>Weight</th><th>추천인</th><th>Image</th>
		<c:if test="${LoginID=='admin'}"> <th>Delete</th> </c:if>	
	</tr>
	<c:if test="${not empty banana}">
		<c:forEach var="member" items="${banana}" >
		<tr height=30>
			<td><!--
				1) JS , function 방식 
						aidBList(${member.id}) -> aidBList(banana) -> Error  //  aidBList('banana')
				<a href="#resultArea2" onclick="aidBList('${member.id}')" >${member.id}</a>
				2) JQuery 방식 : class, id, this 이용 
				=>  id="${member.id}"  : Delete span 에 적용하기 위해 사용하지 않음
				--> 
				<span class="ccc textlink">${member.id}</span>
			</td>	
			<td>${member.password}</td><td>${member.name}</td>
			<td>${member.lev}</td><td>${member.birthd}</td><td>${member.point}</td>
			<td>${member.weight}</td><td>${member.rid}</td>
			
	<!-- ** Image(File) DownLoad 추가 
	** 기본과정 ****************
	1) 요청시 컨트롤러에게 파일패스(path) 와 이름을 제공  (axMemberList.jsp)
	2) 요청받은 컨트롤러에서는 그 파일패스와 이름으로 File 객체를 만들어 뷰로 전달
	   (MemberController.java , 매핑 메서드 dnload ) 
	3) 뷰에서는 받은 file 정보를 이용해서 실제 파일을 읽어들인 다음 원하는 위치에 쓰는 작업을 한다.
       -> DownloadView.java
       	  일반적인 경우에는 컨트롤러에서 작업을 한 후, JSP뷰 페이지로 결과값을 뿌려주는데
     	  다운로드에 사용될 뷰는 JSP가 아니라 파일정보 임 
	   -> 그래서 일반적으로 사용하던 viewResolver 가 처리하는 것이 아니라
          download 만을 처리하는 viewResolver 가 따로 존재해야 함. 	
	4) 위 사항이 실행 가능하도록 xml 설정  (servlet-context.xml) 
	***************************
	
	1) class="dnload" 를 이용하여  jQuery Ajax 로 처리 
		=> 안됨 (java 클래스인 서버의 response가 웹브러우져로 전달되지 못하고 resultArea에 담겨질 뿐 )  
		<img src="${list.uploadfile}" width="50" height="60" class="dnload textLink"> 
	2) aTag 로 직접 요청함 
		=> java 클래스인  서버의 response가  웹브러우져로 전달되어 download 잘됨. 
	-->	
			<td><a href="dnload?dnfile=${member.uploadfile}">  
				<img src="${member.uploadfile}" width=50 height=60></a></td>
				
	<!-- ** Delete 기능 실습 
	=> 1) JQ 방식 : class, id 사용  
	=> 2) JS의 function 으로 처리 
		- function amDelete ....			
	-->		
			<c:if test="${LoginID=='admin'}">
				<td align="center">
					<span id="${member.id}" class="ddd textlink" onclick="amDelete(????)">Delete</span>
				</td>	
			</c:if>
		</tr>
		</c:forEach>
	</c:if> 
	<c:if test="${empty banana}">
			<tr height=30><td colspan=7>** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<hr>
</body>
</html>