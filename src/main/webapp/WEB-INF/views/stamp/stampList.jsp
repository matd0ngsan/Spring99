<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>STAMP</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>

<% String imgpath ="http://3.37.115.214:8080/resources/upimg/"; %>

</head>
<body>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
<div id="stampbox">
	<c:if test="${not empty cherry}">
		<c:forEach var="stamp" items="${cherry}">
			<table id="challenge">
					<tr><th colspan="3"><b>${stamp.title}</b></th></tr>
					<c:forEach begin="1" end="3">
					<tr>
						<c:forEach begin="1" end="3">
							<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
						</c:forEach>
					</tr>
					</c:forEach>
					<tr>
						<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
						<td colspan="2">
							<a href="sdelete?seq=${stamp.seq}">도장판 지우기</a>
						</td>
					</tr>
				</table>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty cherry}">
		<div class="no_stamp">
			<p>아직 완성한 도장판이 없습니다</p>
		</div>
	</c:if>
</div>
	
</body>
</html>