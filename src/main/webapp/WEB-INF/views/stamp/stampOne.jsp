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
	//1) 전역변수 선언
	//=> 개별적 오류 확인을 위한 switch 변수
	var tCheck=false;
	
	// 2) 개별적 focusout 이벤트 핸들러 작성 : JQuery
	$(function(){
		
		$('#title').focus();
		
		// ** Name
		$('#title').keydown(function(e){
			if (e.which==13) {
				e.preventDefault();
				$('#submit').focus();
			}
		}).focusout(function(){
			tCheck=titleCheck();
		}); //name
		
		
	}); //ready
	
	// 3) submit 판단 & 실행 :  JS submit
	function inCheck() {
		if ( tCheck==false ) { $('#tMessage').html(' title 을 확인해주세요 '); }
		
		if ( tCheck ) {
			if ( confirm("~~ 정말 가입 하십니까 ? (Yes:확인 / No:취소)")==false ) {
				  alert('~~ 가입이 취소 되었습니다 ~~');
				  return false; 
			}else return true; // submit 진행 -> 404
		} else return false;
	} //inCheck()
	
	</script>

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
								<td class="stamp" id="stampO"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="3">
								<td class="stamp" id="stampX"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 3}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr><c:if test="${stamp.cnt > 3 && stamp.cnt < 7}">
							<c:forEach begin="4" end="${stamp.cnt}">
								<td class="stamp" id="stampO"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="6">
								<td class="stamp" id="stampX"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt < 4}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampX"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 6}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr><c:if test="${stamp.cnt > 6 && stamp.cnt < 10}">
							<c:forEach begin="7" end="${stamp.cnt}">
								<td class="stamp" id="stampO"></td>
							</c:forEach>
							<c:forEach begin="${stamp.cnt + 1}" end="9">
								<td class="stamp" id="stampX"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt < 7}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampX"></td>
							</c:forEach>
						</c:if>
						<c:if test="${stamp.cnt > 9}">
							<c:forEach begin="1" end="3">
								<td class="stamp" id="stampO"></td>
							</c:forEach>
						</c:if>
					</tr>
					<tr>
						<c:if test="${stamp.cnt != 10}"><td class="stamp" id="stampX"></td></c:if>
						<c:if test="${stamp.cnt == 10}"><td class="stamp" id="stampO"></td></c:if>
						<td colspan="2">
							<a href="supdate?seq=${stamp.seq}">도장 찍기</a>
						</td>
					</tr>
				</table>
		</c:forEach>
		</c:if>
		
		<c:if test="${empty cherry}">
			<form action="sinsert" method="POST" id="myform" enctype="multipart/form-data" >
				<table id="sinsert">
				<tr height=40>
					<td class="label"><label for=title>주제</label></td>
					<td class="contents"><input type="text" name=title id=title size="20"></td><span id="tMessage" class="eMessage"></span>
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