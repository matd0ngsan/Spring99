<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MailBox</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>

<c:if test="${not empty banana}">
	<c:forEach var="mail" items="${banana}">
	<div class="mailbox" id="mailR">
		<span class="seq">${mail.seq}</span>
		<span class="msg">${mail.msg}</span>
		<span class="date">${mail.date}</span>
	</div>
	</c:forEach>
</c:if>
<c:if test="${empty banana}">
	<div class="mailbox" id="mailR">
		<span class="none">아직 열람할 수 있는 편지가 없어요!</span>
	</div>
</c:if>
<c:if test="${not empty banana2}">
	<c:forEach var="mail" items="${banana2}">
	<div class="mailbox" id="mailR">
		<span class="seq">${mail.seq}</span>
		<span class="date">${mail.date}</span>
	</div>
	</c:forEach>
</c:if>
<c:if test="${empty banana2}">
	<div class="mailbox" id="mailR">
		<span class="none">이제 모든 편지를 읽었어요!</span>
	</div>
</c:if>
</body>
</html>