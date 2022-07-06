<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis JoinForm **</title>
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
	var bCheck=false;
	var poCheck=false;
	var wCheck=false;

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
			$('#lev').focus();
		}
	}).focusout(function(){
		nCheck=nameCheck();
	}); //name
	
	// ** Lev : enterkey -> Next 이동
	$('#lev').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#birthd').focus();
		}
	}); //lev
	
	// ** Birthday
	$('#birthd').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#point').focus();
		}
	}).focusout(function(){
		bCheck=biCheck();
	}); //birthd
	
	// ** Point
	$('#point').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#weight').focus();
		}
	}).focusout(function(){
		poCheck=pointCheck();
	}); //password
	
	// ** Weight
	$('#weight').keydown(function(e){
		if (e.which==13) {
			e.preventDefault();
			$('#submit').focus();
		}
	}).focusout(function(){
		wCheck=weCheck();
	}); //weight
	
}); //ready

// 3) submit 판단 & 실행 :  JS submit
function inCheck() {
	if ( iCheck==false ) { $('#iMessage').html(' id 를 확인 하세요 !! '); }
	if ( pCheck==false ) { $('#pMessage').html(' password 를 확인 하세요 !! '); }
	if ( nCheck==false ) { $('#nMessage').html(' name 을 확인 하세요 !! '); }
	if ( bCheck==false ) { $('#bMessage').html(' birthday 를 확인 하세요 !! '); }
	if ( poCheck==false ) { $('#poMessage').html(' point 를 확인 하세요 !! '); }
	if ( wCheck==false ) { $('#wMessage').html(' weight 를 확인 하세요 !! '); }
	
	if ( iCheck && pCheck && nCheck &&
		 bCheck && poCheck && wCheck ) {
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
<!--  ** FileUpLoad Form **
=> form 과 table Tag 사용시 주의사항 : form 내부에 table 사용해야함
   -> form 단위작업시 인식안됨
   -> JQ 의 serialize, FormData 의 append all 등 
   
=> method="post" : 255 byte 이상 대용량 전송 가능 하므로 
=> enctype="multipart/form-data" : 화일 upload 를 가능하게 해줌 
	** multipart/form-data는 파일업로드가 있는 입력양식요소에 사용되는 enctype 속성의 값중 하나이고, 
       multipart는 폼데이터가 여러 부분으로 나뉘어 서버로 전송되는 것을 의미
       이 폼이 제출될 때 이 형식을 서버에 알려주며, 
       multipart/form-data로 지정이 되어 있어야 서버에서 정상적으로 데이터를 처리할 수 있다.     
-->

<form action="join" method="post" id="myform" enctype="multipart/form-data" >
<table>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=id>I D</label></td>
 	<td><input type="text" name=id id=id size="20">&nbsp;&nbsp;
 		<button type="button" id="idDup" onclick="idDupCheck()">ID 중복확인</button><br>
 		<span id="iMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=password>Password</label></td>
	<td><input type="password" name=password id=password size="20"><br>
 		<span id="pMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=name>Name</label></td>
	<td><input type="text" name=name id=name size="20"><br>
 		<span id="nMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=lev>Level</label></td>
	<td><select name=lev id=lev>
			<option value="A">관리자</option>
			<option value="B">나무</option>
			<option value="C">잎새</option>
			<option value="D" selected >새싹</option>
		</select></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=birthd>Birthday</label></td>
	<td><input type="date" name=birthd id=birthd><br>
 		<span id="bMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=point>Point</label></td>
	<td><input type="text" name=point id=point size="20"><br>
 		<span id="poMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=weight>Weight</label></td>
	<td><input type="text" name=weight id=weight size="20"><br>
 		<span id="wMessage" class="eMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=rid>추천인 ID</label></td>
	<td><input type="text" name=rid id=rid size="20"></td>
</tr>
<tr height=40>
	<td bgcolor="AliceBlue"><label for=uploadfilef>Image</label></td>
	<td><img src="" class="select_img"><br>
		<input type="file" name=uploadfilef id=uploadfilef>
		<script>
		// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
		// 이를 해결하기 위해 FileReader이라는 Web API를 사용
		// => 이 를 통해 url data를 얻을 수 있음.
		//    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
		// ** FileReader
		// => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
		//    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
		//    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.	
		// => FileReader.onload 이벤트의 핸들러.
		//    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
		// => e.target : 이벤트를 유발시킨 DOM 객체
		// => type="file" 은 복수개의 파일을 업로드 할 수 있도록 설계됨
		//    그러므로 files[] 배열 형태의 속성을 가짐
		
			$('#uploadfilef').change(function(){
				if(this.files && this.files[0]) {
					var reader = new FileReader;
			 			reader.onload = function(e) {
		 					$(".select_img").attr("src", e.target.result)
		 									.width(100).height(100); 
		 				} // onload_function
		 				reader.readAsDataURL(this.files[0]);
		 		} // if
			}); // change
		</script>
	</td>
</tr>

<tr><td></td>	
	<td><br>
	<input type="submit" value=가입 id="submit" onclick="return inCheck()" disabled >&nbsp;&nbsp;
	<input type="reset" value="취소">&nbsp;&nbsp;
	<span id="axjoin" class="textlink">axJoin</span>
	</td>
</tr>	
</table>
</form>
<br>
<c:if test="${not empty message}">
	=> ${message} <br>
</c:if>
<hr>
<a href="home">HOME</a>
</body>
</html>