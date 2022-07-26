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
</head>
<body>
<form action="srpost" method="POST">
<table id="postbox">
	<tr>
		<td class="contents"><textarea rows="5" cols="50" name="formtext" id="formtext" placeholder="발견하신 오류, 개선사항 등을 알려주시면 도움이 됩니다. 감사합니다." required></textarea></td>
	</tr>
	<tr>
		<td class="submitbtn"><input type="hidden" name="id" value="${LoginID}"><input type="submit" value="작성"></td>
	</tr>
</table>
</form><br>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
</body>
</html>