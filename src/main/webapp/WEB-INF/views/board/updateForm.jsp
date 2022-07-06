<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 Board UpdateForm **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<h2>** Spring MVC2 Board UpdateForm **</h2>

<form action="bupdate" method="post">
<table>
	<tr height="40">
		<td bgcolor="Khaki">Seq</td>
		<td><input type="text" name="seq" value="${apple.seq}" ReadOnly></td></tr>
		<!-- 서버로 값을 전달해야하는 Tag만 input Tag 적용
				=> seq, title, content 
				=> seq 는 수정하면 안되지만 값은 서버로 전달 -->
	<tr height="40">
		<td bgcolor="Khaki">I D</td><td>${apple.id}</td></tr>
		
	<tr height="40">
		<td bgcolor="Khaki">Title</td>
		<td><input type="text" name="title" value="${apple.title}"></td></tr>
	<tr height="40">
		<td bgcolor="Khaki">Content</td>
		<td><textarea rows="5" cols="50" name="content">${apple.content}</textarea></td></tr>
		
	<tr height="40">
		<td bgcolor="Khaki">RegDate</td><td>${apple.regdate}</td></tr>				
	<tr height="40">
		<td bgcolor="Khaki">조회수</td><td>${apple.cnt}</td></tr>
	<tr><td></td>
		<td><input type="submit" value="수정">&nbsp;&nbsp;
			<input type="reset" value="취소"></td>
	</tr>	
</table></form>
<br>
<c:if test="${not empty message}">
<b>=> ${message}</b>
</c:if>
<hr>
<!-- 로그인 했으면 새글작성 가능 -->
<c:if test="${not empty LoginID}">
&nbsp;&nbsp;<a href="insertf">새글작성</a>
</c:if>
&nbsp;&nbsp;<a href="blist">BList</a>
&nbsp;&nbsp;<a href="home">HOME</a>
</body>
</html>