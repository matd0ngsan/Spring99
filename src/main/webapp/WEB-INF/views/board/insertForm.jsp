<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 Board InsertForm **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<h2>** Spring MVC2 Board InsertForm **</h2>
<form action="binsert" method="post">
<table>
	<tr height="40"><td bgcolor="LightGreen">I D</td>
		<td><input type="text" name="id" value="${LoginID}" readonly></td>
	</tr>
	<tr height="40"><td bgcolor="LightGreen">Title</td>
		<td><input type="text" name="title"></td>
	</tr>
	<tr><td bgcolor="LightGreen">Content</td>
		<td><textarea rows="5" cols="50" name="content"></textarea></td>
	</tr>
	<tr><td></td>
		<td><input type="submit" value="글등록">&nbsp;&nbsp;
			<input type="reset" value="취소"></td>
	</tr>
</table>
</form><br>
<c:if test="${not empty message}">
<b>=> ${message}</b>
</c:if>
<hr>
&nbsp;&nbsp;<a href="blist">BList</a>
&nbsp;&nbsp;<a href="home">HOME</a>
</body>
</html>