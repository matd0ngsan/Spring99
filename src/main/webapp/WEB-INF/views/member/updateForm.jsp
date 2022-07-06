<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis UpdateForm **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
</head>
<body>
<h2>** Spring Mybatis UpdateForm **</h2>
<form action="mupdate" method="post"  enctype="multipart/form-data">
<table>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=id>I D</label></td>
 	<td><input type="text" name=id id=id size="20" value="${apple.id}" readonly ></td>
 			<!-- ** input Tag 입력 막기 
				=> disabled :  서버로 전송 안됨 
				=> readonly :  서버로 전송 됨   -->
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=password>Password</label></td>
	<td><input type="password" name=password id=password size="20" value="${apple.password}"></td>
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=name>Name</label></td>
	<td><input type="text" name=name id=name size="20" value="${apple.name}"></td>
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=lev>Level</label></td>
	<td><select name=lev id=lev>
	<%-- ${apple.lev} 에 따라서 해당되는 option 을 selected 
	     DAO 의 sql 구문에서 CONCAT~등을 적용했기때문에 lev 의 값은 'A 관리자' 
	     -> 그러므로 이것에 대한 처리가 필요 -> EL 의 function 적용 
	         ${fn:substring(message,0,1)}
    --%>
		<c:choose>
		  <c:when test="${fn:substring(apple.lev,0,1)=='A'}">
			<option value="A" selected>관리자</option>
			<option value="B">나무</option>
			<option value="C">잎새</option>
			<option value="D">새싹</option>
		  </c:when>
		  <c:when test="${fn:substring(apple.lev,0,1)=='B'}">
			<option value="A">관리자</option>
			<option value="B" selected>나무</option>
			<option value="C">잎새</option>
			<option value="D">새싹</option>
		  </c:when>	
		  <c:when test="${fn:substring(apple.lev,0,1)=='C'}">
			<option value="A">관리자</option>
			<option value="B">나무</option>
			<option value="C" selected>잎새</option>
			<option value="D">새싹</option>
		  </c:when>
		  <c:when test="${fn:substring(apple.lev,0,1)=='D'}">
			<option value="A">관리자</option>
			<option value="B">나무</option>
			<option value="C">잎새</option>
			<option value="D" selected>새싹</option>
		  </c:when>	 
		</c:choose>	
	</select></td>
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=birthd>Birthday</label></td>
	<td><input type="date" name=birthd id=birthd  value="${apple.birthd}"></td>
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=point>Point</label></td>
	<td><input type="text" name=point id=point size="20"  value="${apple.point}"></td>
</tr>
<tr height=40>
	<td bgcolor="LavenderBlush"><label for=weight>Weight</label></td>
	<td><input type="text" name=weight id=weight size="20"  value="${apple.weight}"></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=rid>추천인 ID</label></td>
	<td><input type="text" name=rid id=rid size="20" value="${apple.rid}"></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=uploadfilef>Image</label></td>
	<td><img src="${apple.uploadfile}" class="select_img">
		<input type="hidden" name="uploadfile" value="${apple.uploadfile}"><br>
		<input type="file" name=uploadfilef id=uploadfilef>
		<script>
		// ** 선택된 이미지 출력 script 
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
	</td>
</tr>
<tr><td></td>	
	<td><br>
	<input type="submit" value=수정>&nbsp;&nbsp;
	<input type="reset" value="취소">
	</td>
</tr>	
</table>
</form>
<br>
<c:if test="${not empty message}">
	<b>=> ${message}</b><br>
</c:if>
<hr>
<a href="home">HOME</a>
</body>
</html>