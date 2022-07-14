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
	<div class="mailbox" id="mailS">
		<span class="seq">${mail.seq}</span>
		<span class="date">${mail.date}</span>
		<span class="toid">To. ${mail.toId}</span>
		
		<c:if test="${mail.ccheck == 0}">
			<span class="ccheck">안읽음</span>
			<span class="mdelete"><a href="">X</a></span>
		</c:if>
		
		<c:if test="${mail.ccheck == 1}">
			<span class="ccheck">읽음</span>
		</c:if>
		
		<br>
		<span class="msg">${mail.msg}</span>
	</div>
	</c:forEach>
</c:if>
<c:if test="${empty banana}">
	<div class="mailbox" id="mailS">
		<span class="none">아직 보낸 편지가 없어요!</span>
	</div>
</c:if>

</body>
</html>