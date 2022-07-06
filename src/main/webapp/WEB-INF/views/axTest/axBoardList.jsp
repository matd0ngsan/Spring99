<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis Ajax_BoardList **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<h2>** Spring Mybatis Ajax_BoardList **</h2>

<c:if test="${not empty message}">
<b>=> ${message}</b>  
</c:if>
<hr>
<table width=100% >
	<tr height="30" bgcolor="YellowGreen">
		<th>Seq</th><th>Title</th><th>I D</th><th>RegDate</th><th>조회수</th></tr>
	<c:if test="${not empty banana}">
	  <c:forEach var="board" items="${banana}">
		<tr height="30">
			<td>${board.seq}</td>
			<td><a href="bdetail?seq=${board.seq}">${board.title}</a></td>
			<td>${board.id}</td><td>${board.regdate}</td><td>${board.cnt}</td>
		</tr>
	  </c:forEach>
	</c:if>
	<c:if test="${empty banana}">
			<tr height=30><td colspan=5>** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<hr>
</body>
</html>