<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis BoardDetail **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<h2>** Spring Mybatis BoardDetail **</h2>

<table>
	<tr height="40">
		<td bgcolor="GreenYellow">Seq</td><td>${apple.seq}</td></tr>
	<tr height="40">
		<td bgcolor="GreenYellow">I D</td><td>${apple.id}</td></tr>
	<tr height="40">
		<td bgcolor="GreenYellow">Title</td><td>${apple.title}</td></tr>
	<tr height="40">
		<td bgcolor="GreenYellow">Content</td>
		<td><textarea rows="5" cols="50" readonly>${apple.content}</textarea></td></tr>
	<tr height="40">
		<td bgcolor="GreenYellow">RegDate</td><td>${apple.regdate}</td></tr>				
	<tr height="40">
		<td bgcolor="GreenYellow">조회수</td><td>${apple.cnt}</td></tr>
</table>
<c:if test="${not empty message}">
<b>=> ${message}</b>
</c:if>
<hr>
<!-- 로그인 했으면 새글작성 가능 -->
<c:if test="${not empty LoginID}">
&nbsp;&nbsp;<a href="binsertf">새글작성</a>
&nbsp;&nbsp;<a href="rinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">답글작성</a>
</c:if>
&nbsp;&nbsp;<a href="rinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">답글작성</a>
<!-- 내글이면 글수정, 글삭제 (root 값은 답글기능 추가후 필요함) 가능 -->
<c:if test="${LoginID==apple.id}">
&nbsp;&nbsp;<a href="bupdatef?seq=${apple.seq}">글수정</a>
&nbsp;&nbsp;<a href="bdelete?seq=${apple.seq}&root=${apple.root}">글삭제</a>
</c:if>
<hr>
&nbsp;&nbsp;<a href="blist">BList</a>
&nbsp;&nbsp;<a href="home">HOME</a>
</body>
</html>