<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis MemberList **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
</head>
<body>
<h2>** Spring Mybatis MemberList **</h2>

<c:if test="${not empty message}" >
=> ${message} 
</c:if>
<hr>
<table width=100%>
	<tr bgcolor="Lavender" height=30>
		<th>I D</th><th>Password</th><th>Name</th><th>Level</th>
		<th>Birthday</th><th>Point</th><th>Weight</th><th>추천인</th><th>Image</th>
	</tr>
	<c:if test="${not empty banana}">
		<c:forEach var="member" items="${banana}" >
			<tr height=30><td>${member.id}</td><td>${member.password}</td><td>${member.name}</td>
			<td>${member.lev}</td><td>${member.birthd}</td><td>${member.point}</td>
			<td>${member.weight}</td><td>${member.rid}</td>
			<td><img src="${member.uploadfile}" width=50 height=60></td>	
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${empty banana}">
			<tr height=30><td colspan=7>** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<hr>
<a href="home">HOME</a>
</body>
</html>