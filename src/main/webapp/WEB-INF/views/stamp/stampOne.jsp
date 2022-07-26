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
	<script src="resources/myLib/inCheck.js"></script>
	<script src="resources/myLib/axTest01.js"></script>
	
	<script>
		$("#upfilefo").on('change',function(){
		  var fileName = $("#upfilefo").val();
		  $("#filefo").val(fileName);
		});
		
		$("#upfilefx").on('change',function(){
			  var fileName = $("#upfilefx").val();
			  $("#filefx").val(fileName);
			});
	</script>
	
	<script>
	function checkSize(input) {
	    if (input.files && input.files[0].size > (1 * 1024 * 1024)) {
	        alert(" 1mb 이하의 이미지만 업로드 가능해요 ");
	        input.value = null;
	    }
	}
	</script>
	
<% String imgpath ="http://3.37.115.214:8080/resources/upimg/"; %>

</head>
<body>
<c:if test="${not empty LoginID}" >
	<div id="stampbox">
		<c:if test="${not empty cherry}">
			<c:forEach var="stamp" items="${cherry}">
				<table id="challenge">
					<tr><th colspan="3"><b>${stamp.title}</b></th></tr>
					
					<tr><c:if test="${stamp.cnt < 4}">
							<c:forEach begin="1" end="${stamp.cnt}">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="3">
								<td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 3}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr><c:if test="${stamp.cnt > 3 && stamp.cnt < 7}">
							<c:forEach begin="4" end="${stamp.cnt}">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="6">
								<td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt < 4}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 6}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr><c:if test="${stamp.cnt > 6 && stamp.cnt < 10}">
							<c:forEach begin="7" end="${stamp.cnt}">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="9">
								<td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt < 7}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 9}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr>
						<c:if test="${stamp.cnt != 10}"><td class="stamp" id="stampX"><img src="<%= imgpath %>${stamp.upfileX}"></td></c:if>
						<c:if test="${stamp.cnt == 10}"><td class="stamp" id="stampO"><img src="<%= imgpath %>${stamp.upfileO}"></td></c:if>
						<td class="stpbtn"><a href="sdelete?seq=${stamp.seq}">지우기</a></td>
						<td class="stpbtn"><a href="supdate?seq=${stamp.seq}">도장 찍기</a></td>
					</tr>
				</table>
		</c:forEach>
		</c:if>
		
		<c:if test="${empty cherry}">
			<form action="sinsert" method="POST" id="myform" name="newup" onsubmit="filecheck()" enctype="multipart/form-data" >
				<table id="sinsert">
				<tr>
					<td class="label"><label for=title>제목</label></td>
					<td class="contents"><input type="text" name=title id=title size="20"></td><span id="tMessage" class="eMessage"></span>
				</tr>
				<tr class="fileupload2">
					<td class="label"><label>도장</label></td>
					<td>						
						<input class="upload-name" id="filefo" value="달성 도장"" placeholder="달성 도장">
					    <label for="upfilefo" class="filelabel">올리기</label><input type="file" id="upfilefo" name="upfilefO" onchange="checkSize(this)">
					    <br>
					    <input class="upload-name" id="filefx" value="미달성 도장" placeholder="미달성 도장">
					    <label for="upfilefx" class="filelabel">올리기</label><input type="file" id="upfilefx" name="upfilefX">
					    <br><span>파일을 선택하지 않아도 기본 이미지가 출력됩니다.</span>
					</td>
				</tr>
				<tr>
					<td><input type="hidden" name="id" value="${LoginID}"></td>	
					<td><input type="submit" value=도전 ></td>
				</tr>
				</table>
			</form>
			
		</c:if>
	</div>
</c:if>
</body>
</html>