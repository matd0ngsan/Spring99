<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis BoardList **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
<table width=100% >
	<tr height="30" bgcolor="YellowGreen">
		<th>번호</th><th>내용</th><th>날짜</th><th>수신자</th><th>확인여부</th></tr>
	<c:if test="${not empty banana}">
	  <c:forEach var="mail" items="${banana}">
		<tr height="30">
			<td>${mail.seq}</td>
			<td align="left">${mail.msg}</td>
			<td>${mail.date}</td>
			<td>${mail.toId}</td>
			<td>${mail.ccheck}</td>
		</tr>
	  </c:forEach>
	</c:if>
	<c:if test="${empty banana}">
			<tr height=30><td colspan=5>** 출력할 자료가 1건도 없</td></tr>
	</c:if>
</table>
</body>
</html>