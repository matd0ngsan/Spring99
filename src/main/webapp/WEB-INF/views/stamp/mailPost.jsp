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
<table id="postbox">
	<tr height="40">
		<td class="label">받는 사람 ID</td>
		<td class="contents"><input type="text" name="toId" id="toId" required></td>
	</tr>
	<tr height="40">
		<td class="label">내용</td>
		<td class="contents"><textarea rows="5" cols="50" name="msg" id="msg" required></textarea></td>
	</tr>
	<tr>
		<td><input type="hidden" name="fromId" value="${LoginID}"></td>
		<td class="submitbtn"><input type="submit" value="보내기"></td>
	</tr>
</table>
</form><br>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
</body>
</html>