/**
**  입력값의 무결성 확인
** member 무결성 확인사항
// ID : 길이(4이상), 영문자,숫자 로만 구성
// password : 길이(4이상), 영문,숫자,특수문자로 구성, 특수문자는 반드시 1개 이상 포함할것
// Name : 길이(2이상), 영문 또는 한글로 만 입력
// Level : select 를 이용 (X)
// BirthDay : 입력 여부 확인  ( length == 10 )
// Point : 정수의 범위  ( 숫자이면서, '.'이 없어야함 )
// Weight: 구간 (20 ~ 200)

** 작성 규칙
   => JavaScript function 으로 정의 하고 
      결과를 true or false 로 return
 */

function idCheck() {
	var id=$('#id').val(); 
	if ( id.length<4 ) {
		$('#iMessage').html(' ID 길이는 4 이상 입니다. !! ');
		$('#id').focus();
		return false;
	}else if ( id.replace(/[a-z.0-9]/gi,'').length > 0 ) {
		$('#iMessage').html(' ID는 영문자,숫자 로만 입력하세요. !! ');
		$('#id').focus();
		return false;
	}else {
		$('#iMessage').html('');
		return true;
	};
}; //idCheck 

function pwCheck() {
	var password=$('#password').val();
	if ( password.length<4 ) {
		$('#pMessage').html(' Password 길이는 4 이상 입니다. !! ');
		$('#password').focus();
		return false;
	}else if ( password.replace(/[!-*.@]/gi ,'').length >= password.length ) {
		// 비교 : replace(/[!.@.#.$.%.^.&.*]/gi ,'')
		$('#pMessage').html(' Password 에는 특수문자가 반드시 포함 되어야 합니다. !!');
		$('#password').focus();
		return false;
	}else if ( password.replace(/[a-z.0-9.!-*.@]/gi,'').length > 0 ) {
		$('#pMessage').html(' Password 는 영문자, 숫자, 특수문자 로만 입력하세요. !!');
		$('#password').focus();
		return false;
	}else {
		$('#pMessage').html('');
		return true;
	}
}; //pwCheck

function nameCheck() {
	var name = $('#name').val();
	if ( name.length < 2) {
		$('#nMessage').html(' Name 길이는 2 이상 입니다. !! ');
		$('#name').focus();
		return false;
	}else if (name.replace(/[a-z.가-힣]/gi,'').length > 0) {
		$('#nMessage').html('  Name은 영문, 한글만 입력 가능 합니다. !!');
		$('#name').focus();
		return false;
	}else {
		$('#nMessage').html('');
		return true;
	} 
}; nameCheck//

function biCheck() {
	var birthd = $('#birthd').val();
	if ( birthd.length != 10 ) {
		$('#bMessage').html(' 생년월일을 정확하게 입력 하세요 (yyyy-mm-dd) !! ');
		$('#birthd').focus();
		return false;
	}else {
		$('#bMessage').html('');
		return true;
	}  
}; //biCheck

function pointCheck() {
	var point = $('#point').val();
	if ( $.isNumeric(point)==false ||
		point.replace(/[.]/g,'').length < point.length ) {
		$('#poMessage').html(' 정수값을  정확하게 입력 하세요. !! ');
		$('#point').focus();
		return false;
	}else {
		$('#poMessage').html('');
		return true;
	} 
}; //poCheck

function weCheck() {
	var weight = $('#weight').val();
	if ( $.isNumeric(weight)==false ) {
		$('#wMessage').html(' weight 값을 숫자로 정확하게 입력 하세요. (20~200) !! ');
		$('#weight').focus();
		return false;
	}else if ( parseFloat(weight) < 20 || parseFloat(weight) > 200 ) {
		$('#wMessage').html(' weight 의 범위를 벗어납니다. (20~200) !! ');
		$('#weight').focus();
		return false;
	}else {
		$('#wMessage').html('');
		return true;
	} 
}; //weCheck
