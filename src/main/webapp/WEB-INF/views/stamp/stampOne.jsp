<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>STAMP</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	
</head>
<body>
<c:if test="${not empty LoginID}" >
	<div id="stampbox">
		<c:if test="${not empty cherry}">
			<c:forEach var="stamp" items="${cherry}">
				<table id="challenge">
					<tr><th colspan="10"><b>${LoginName}</b> 의 표</th></tr>
					<tr>
						<c:forEach begin="1" end="${stamp.cnt}">
							<td class="stamp" id="stamp1">1</td>
						</c:forEach>
						<c:forEach begin="${stamp.cnt}" end="9">
							<td class="stamp" id="stamp1">0</td>
						</c:forEach>
					</tr>
				</table>
				<c:if test="${stamp.cnt == 10}">
					<form action="sinsert" method="get"><input type="hidden" value="${stamp.id}"><input type="submit" value="새 도전"></form>
				</c:if>
				<c:if test="${stamp.cnt != 10}">
					<form action="supdate" method="get"><input type="hidden" value="${stamp.seq}"><input type="submit" value="도장 찍기"></form>
				</c:if>
		</c:forEach>
		</c:if>
		
		<c:if test="${empty cherry}">
			<tr height=30><td colspan=5>** 출력할 자료가 1건도 없습니다 **</td></tr>
		</c:if>
	</div>
</c:if>
<c:if test="${empty LoginID}">
	<div>
		<form action="join" method="post" id="myform" enctype="multipart/form-data" >
			<input type="text" name="title" size="20" placeholder="도장판 이름"><br>
			<img src="" class="select_img"><br>
			<input type="file" name=uploadfilef id=uploadfilef>
			<script>
			// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
			// 이를 해결하기 위해 FileReader이라는 Web API를 사용
			// => 이 를 통해 url data를 얻을 수 있음.
			//    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
			// ** FileReader
			// => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
			//    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
			//    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.	
			// => FileReader.onload 이벤트의 핸들러.
			//    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
			// => e.target : 이벤트를 유발시킨 DOM 객체
			// => type="file" 은 복수개의 파일을 업로드 할 수 있도록 설계됨
			//    그러므로 files[] 배열 형태의 속성을 가짐
			
				$('#uploadfilef').change(function(){
					if(this.files && this.files[0]) {
						var reader = new FileReader;
				 			reader.onload = function(e) {
			 					$(".select_img").attr("src", e.target.result)
			 									.width(100).height(100); 
			 				} // onload_function
			 				reader.readAsDataURL(this.files[0]);
			 		} // if
				}); // change
			</script>
			<input type="submit" value=가입 id="submit" onclick="return inCheck()" disabled >
		</form>
	</div>
</c:if>
</body>
</html>