<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/inCheck.js"></script>
<script src="resources/myLib/axTest01.js"></script>
<script>
//1) 전역변수 선언
//=> 개별적 오류 확인을 위한 switch 변수
	var iCheck=false;
	var pCheck=false;

// 2) 개별적 focusout 이벤트 핸들러 작성 : JQuery
$(function(){
	//$('#id').focus();
	// => 개별적으로 이벤트를 적용하는 경우에는 없는것이 더 적절.
	
	$('#id').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			// => form 에 submit 이 있는경우
			// => enter 누르면 자동 submit 발생되므로 이를 제거함
			$('#password').focus();
		}
	}).focusout(function(){
		iCheck=idCheck();
	}); //id
	
	// ** Password
	$('#password').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#submit').focus();
		}
	}).focusout(function(){
		pCheck=pwCheck();
	}); //password
}); //ready

// 3) submit 판단 & 실행 :  JS submit
function inCheck() {
	if ( iCheck==false ) { $('#iMessage').html(' id 를 확인 하세요 !! '); }
	if ( pCheck==false ) { $('#pMessage').html(' password 를 확인 하세요 !! '); }
	
	if ( iCheck && pCheck ) return true;
	else return false;
} //inCheck()

</script>
</head>
<body>
<br>

<form action="login" method=post>
<table class="loginbox">
	<tr><td id="login_id"><input type="text" name=id id=id placeholder="아이디"></td></tr>
	<tr><td id="login_pw"><input type="text" name=password id=password placeholder="비밀번호"></td></tr>
	<tr><td class="submittd"><input type="submit" value="LOGIN" id="submit" onclick="return inCheck()"></td></tr>
</table>
</form>
<br>
<c:if test="${not empty message}" >
=> ${message} <br>
</c:if>
</body>
</html>