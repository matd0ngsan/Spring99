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
<h2>** Spring Mybatis BoardList **</h2>

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
			<td align="left">
				<!-- 답글 등록후 indent 에 따른 들여쓰기 
	             => 답글인 경우에만 적용  -->
	            <c:if test="${board.indent>0}">
	               <c:forEach begin="1" end="${board.indent}">
	                  <span>&nbsp;&nbsp;</span>
	               </c:forEach>
	               <span style="color:green">re..</span>
	            </c:if>
				<a href="bdetail?seq=${board.seq}">${board.title}</a>
			</td>
			<td>${board.id}</td><td>${board.regdate}</td><td>${board.cnt}</td>
		</tr>
	  </c:forEach>
	</c:if>
	<c:if test="${empty banana}">
			<tr height=30><td colspan=5>** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<hr>
<c:if test="${not empty LoginID}">
	&nbsp;&nbsp;<a href="binsertf">새글작성</a>
</c:if>
&nbsp;&nbsp;<a href="home">HOME</a>
</body>
</html>