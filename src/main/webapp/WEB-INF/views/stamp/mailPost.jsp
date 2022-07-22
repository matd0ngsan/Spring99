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
		<td class="contents" id="toidbox"><input type="text" name="toId" id="toId" placeholder="상대의 id를 적어주세요" required></td>
	</tr>
	<tr height="40">
		<td class="contents"><textarea rows="5" cols="50" name="msg" id="msg" placeholder="편지의 내용을 적어주세요" required></textarea></td>
	</tr>
	<tr>
		<td class="submitbtn"><input type="hidden" name="fromId" value="${LoginID}"><input type="submit" value="보내기"></td>
	</tr>
</table>
</form><br>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
</body>
</html>