<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOIN</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/inCheck.js"></script>
<script src="resources/myLib/axTest01.js"></script>

<script>
//1) 전역변수 선언
//=> 개별적 오류 확인을 위한 switch 변수
	var iCheck=false;
	var pCheck=false;
	var nCheck=false;

// 2) 개별적 focusout 이벤트 핸들러 작성 : JQuery
$(function(){
	$('#id').focus();
	// ** ID
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
			$('#name').focus();
		}
	}).focusout(function(){
		pCheck=pwCheck();
	}); //password
	
	// ** Name
	$('#name').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#submit').focus();
		}
	}).focusout(function(){
		nCheck=nameCheck();
	}); //name
	
	
}); //ready

// 3) submit 판단 & 실행 :  JS submit
function inCheck() {
	if ( iCheck==false ) { $('#iMessage').html(' id 를 확인 하세요 !! '); }
	if ( pCheck==false ) { $('#pMessage').html(' password 를 확인 하세요 !! '); }
	if ( nCheck==false ) { $('#nMessage').html(' name 을 확인 하세요 !! '); }
	
	if ( iCheck && pCheck && nCheck ) {
		if ( confirm("~~ 정말 가입 하십니까 ? (Yes:확인 / No:취소)")==false ) {
			  alert('~~ 가입이 취소 되었습니다 ~~');
			  return false; 
		}else return true; // submit 진행 -> 404
	} else return false;
} //inCheck()

// *** ID 중복확인
// => id 옆에 button 추가 (button type='button')
// => submit : 초기화면 disabled , id 확정후 enabled ( 동시에 idDup 버튼은 disabled )  
// => id 무결성 확인 후 서버로 확인요청 -> 결과는 새창으로 처리
function idDupCheck() {
	// id 무결성 확인
	if (iCheck==false) iCheck=idCheck();
	else {
		// 서버로 확인요청 -> 결과는 새창으로 처리
		var url='idDupCheck?id='+$('#id').val();  // idDupCheck?id=newid 
		window.open(url,'_blank',
				'toolbar=no, menubar=yes, scrollbars=yes, resizable=yes, width=400, height=300');
	}
}; //idDupCheck

</script>

</head>
<body>
<form action="join" method="post" id="myform" enctype="multipart/form-data" >
<table class="joinbox">
<tr height=40>
 	<td><input type="text" name=id id=id size="20" placeholder="아이디">
 		<button type="button" id="idDup" onclick="idDupCheck()">중복확인</button><br>
 		<span id="iMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td><input type="password" name=password id=password size="20" placeholder="비밀번호"><br>
 		<span id="pMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td><input type="text" name=name id=name size="20" placeholder="별명"><br>
 		<span id="nMessage" class="eMessage"></span></td>
</tr>
<tr>	
	<td class="submittd">
	<input type="submit" value=가입 id="submit" onclick="return inCheck()" disabled >
	<input type="reset" value="취소">
	</td>
</tr>	
</table>
</form>
<br>
<c:if test="${not empty message}">
	=> ${message} <br>
</c:if>
</body>
</html>