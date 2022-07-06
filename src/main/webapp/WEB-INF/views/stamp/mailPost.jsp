<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axTest01.js"></script>
	
</head>
<body>
<form action="mpost" method="POST">
<table>
	<tr height="40">
		<td bgcolor="LightGreen">받는 사람 ID</td>
		<td><input type="text" name="toId" id="toId" required></td>
	</tr>
	<tr height="40">
		<td bgcolor="LightGreen">내용</td>
		<td><textarea rows="5" cols="50" name="msg" id="msg" required></textarea></td>
	</tr>
	<tr>
		<td><input type="hidden" name="fromId" value="${LoginID}"></td>
		<td><input type="submit" value="글등록">&nbsp;&nbsp;
			<input type="reset" value="취소"></td>
	</tr>
</table>
</form><br>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
</body>
</html>