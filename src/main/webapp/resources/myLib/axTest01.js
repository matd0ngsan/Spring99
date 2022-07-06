/*
** 이클립스 자바스크립트 파일 내용이 흑백으로 나올때... 컬러로 고치기 
=> https://creampuffy.tistory.com/66
** js 문서관련 설정
윈도우 - 프레퍼런스 - 제네럴 - 에디터스 - 파일 어소시에이션 - 
add - *.js - 밑에 제네릭 텍스트 에디터 디폴트

********************************************
** Ajax_Test01 
 *  => axLogin, axJoin, MousePointer
	=> form 의 input Data 처리
 */

$(function(){
// ** MousePointer	
// => ~~.hover(f1, f2);
	$('.textlink').hover(function(){
		$(this).css({
			fontSize: '1.2em',
			fontWeight: 'bold',
			color: 'DeepSkyBlue',
			cursor: 'pointer'
		}); //css
	}, function(){
		$(this).css({
			fontSize: '',
			fontWeight: 'bold',
			color: 'Blue',
			cursor: 'default'
		}); //css
	}); //hover	
	
// ** Ajax_Login 구현
// => axLoginf
	$('#axloginf').click(function(){
		$.ajax({
			type:'Get',
			url:'loginf',
			success:function(resultPage){
				$('#resultArea').html(resultPage);
			},
			error:function(){
				$('#resultArea').html('~~ Ajax_Login form 요청 Error ~~');
			}
		});//ajax
	}); //axloginf_click

// => axLogin
//    로그인 성공 or 실패에 따른 다른 처리가 필요함
//    서버로 부터 결과값을 전달받을 필요성 
//    서버의 결과는 Java 의 Data -> JS 가 이를 이용해서 코딩
//    그러므로 Java의 Data를 JS가 인식가능한 Data형식(JSON 포맷)으로 변환 해야함  
	$('#axlogin').click(function(){
		$.ajax({
			type:'Post',
			url:'login',
			data:{
				id:$('#id').val(),
				password:$('#password').val()
			},
			success:function(){
				// => resultArea 는 clear, home: 새로고침
				$('#resultArea').html('');
				location.reload();
			},
			error:function(){
				$('#resultArea').html('~~ Ajax_Login form 요청 Error ~~');
			}
		}); //ajax
	}); //axlogin_click

// ** AjaxJoin
// => axjoinf
	$('#axjoinf').click(function(){
		$.ajax({
			type:'Get',
			url:'joinf',
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:function(){
				$('#resultArea1').html('~~ Ajax_Join form 요청 Error ~~');
			}
		}); //ajax
	}); //axjoinf_click

// => axjoin
	
// ** Ajax에서 input Data (Value) 처리방법
// 1) Form 의 serialize()
// => input Tag 의 name 과 id 가 같아야 함.	
// => 직렬화 : multipart 타입은 전송안됨. 
//           처리하지 못하는 값(예-> file Type) 은 스스로 제외시킴 
// => 제외컬럼 지정하기
//    var formData = $('#myForm:not(#rid)').serialize();
//    rid 만 제외시키는 경우 (보류:적용안됨)

// 2) 객체화	
// => 특정 변수 (객체형) 에 담기		
// => 특별한 자료형(fileType: UpLoadFilef) 적용안됨.	

// 3) FormData 객체 활용
// => 모든 자료형의 특성에 맞게 적용가능하여 이미지등의 file 업로드가 가능한 폼데이터 처리 객체
// => IE10부터 부분적으로 지원되며, 크롬이나 사파리, 파이어폭스같은 최신 브라우져에서는 문제 없이 동작
// => 3.1) append 메서드 또는 3.2) 생성자 매개변수 이용

// ** 관련속성	
// => form Tag 
//		enctype 속성: 'multipart/form-data'  
//  	method: 'Post''
// => ajax 속성
//		method: 'Post','
//		enctype: 'multipart/form-data', // form Tag 에서 지정하므로 생략 가능
//		processData:false, // false로 선언시 formData를 string으로 변환하지 않음
// 		contentType:false, // false로 선언시 content-type 헤더가 multipart/form-data로 전송되게 함
  
	$('#axjoin').click(function(){
	// ** 실습
	// 1) Form 의 serialize() 		
	//	var formData = $('#myform').serialize();
	
	// 2) 객체화
	/*	var formData = {
			id:$('#id').val(),
			password:$('#password').val(),
			name:$('#name').val(),
			lev:$('#lev').val(),
			birthd:$('#birthd').val(),
			point:$('#point').val(),
			weight:$('#weight').val(),
			rid:$('#rid').val()
		}; */
		
	// 3) FormData 객체 : file 업로드가 가능
	// 3.1) append 메서드	
	/* 
		var formData = new FormData();
		formData.append('id',$('#id').val());
		formData.append('password',$('#password').val());
		formData.append('name',$('#name').val());
		formData.append('lev',$('#lev').val());
		formData.append('birthd',$('#birthd').val());
		formData.append('point',$('#point').val());
		formData.append('weight',$('#weight').val());
		formData.append('rid',$('#rid').val());
		
		=> image 처리
			Ajax 의  FormData 는  이미지를 선택하지 않으면 append시 오류 발생
	    	하기 때문에 이를 확인 후 append 하도록 함
	     	이때 append 를 하지 않으면  서버의 vo.uploadfilef 에는 null 값이 전달됨.
		
		if ( $('#uploadfilef')[0].files[0] !=null )
		formData.append('uploadfilef', $('#uploadfilef')[0].files[0]) ;
	*/	
			
	// 3.2) 생성자 매개변수로 form 사용 : all append ...	
	// => JS	
	// 	var formData = new FormData(document.getElementById('myform')); 
	
	// => JQ
	// 	var formData = new FormData($('#myform')); //-> Error 인식안됨
		var formData = new FormData($('#myform')[0]); // JS의 노드로 인식해야함
	
		alert('***** FormData() 객체_생성자2 !!! Test ******');
		$.ajax({
			type:'Post',
			url:'join',
			//=> FormData 객체로 fileUpload 시 enctype, processData, contentType 추가
			//   단, enctype: 'multipart/form-data' 는 생략가능 (form Tag 에 적용했으므로)
			processData:false,
			contentType :false,
			data:formData,
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:errorCode('Join 처리')
		}); //ajax
	}); //axjoin_click
	
	
}); //ready

function errorCode(test) {
	$('#resultArea1').html('~~ Ajax 요청 Error => '+test);
}

/*
** $.ajax 메서드   ******************
 *  
 * 1. 기본형식
 * $.ajax({옵션속성:값}); 
 * => $.ajax 함수는 XMLHttpRequest 객체를 반환함.
 * 
 * 2. 옵션속성 
 * => https://hsj0511.tistory.com/205 참고
 * 
 * url:문자열 - 요청url 설정

=> type:문자열 - GET/POST설정
   data:객체,문자열 - 요청 매개변수 설정 
   dataType: return Data Type - xml, html, json, jsonp, text, script
   success:함수
 		=> 성공시 호출할 함수 설정
 		=> 매개변수가 응답 결과를 받아줌 
   error:함수 - 실패시 호출할 함수 설정
   async:불리언 - 동기/비동기 설정 (True/False)
   beforeSend:HTTP 요청전에 발생하는 이벤트 핸들러
***************************************
*/
