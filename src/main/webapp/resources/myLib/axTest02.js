/**
 *  ** AjaxTest 02
	=> 반복문에 이벤트 적용하기
	=> axmlist : id별로 board조회, 관리자기능 (delete 버튼), Image(File)Download 
	=> axblist : 상세글 보기
 */
$(function(){
// ** Ajax_MemberList    	
	$('#axmlist').click(function(){
		$.ajax({
			type:'Get',
			url:'axmlist',
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:function(){
				$('#resultArea1').html('');
				alert(' ~~ 서버오류 !! 잠시후 다시 하세요 ~~');
			}
		}); //ajax
	}); //axmlist_click

// ** Ajax_BoardList    	
	$('#axblist').click(function(){
		$.ajax({
			type:'Get',
			url:'axblist',
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:function(){
				$('#resultArea1').html('');
				alert(' ~~ 서버오류 !! 잠시후 다시 하세요 ~~');
			}
		}); //ajax
	}); //axblist_click
	
// ** 반복문에 이벤트 적용하기 2) -> JQuery  
// => id별로 board조회
	$('.ccc').click(function(){
		// 1) 요청 id 인식
		var id = $(this).html() ; // 또는 $(this).text()
		//var id = $(this).attr('id') ;
		alert('*** 반복문에 이벤트 적용하기 2) -> JQuery => '+id);
		
		// 2) ajax 처리
		$.ajax({
			type:'Get',
			url:'aidblist',
			data: { id:id },
			success:function(resultPage){
				$('#resultArea2').html(resultPage);
			},
			error:function(){
				$('#resultArea2').html('');
				alert(' ~~ 서버오류 !! 잠시후 다시 하세요 ~~');
			}
		}); //ajax
	}); // ccc_click

// => id별로 Delete 기능
// => Response 는 jsonView 로 처리 
// => Delete 후 표시  
	$('.ddd').click(function(){
		var id=$(this).attr('id');
		$.ajax({
			type:'Get',
			url:'axmdelete',
			data: { id:id },
			success:function(resultData){
				// Delete 결과 처리
				
			if ( resultData.code=='200' ) {
				alert('삭제가 성공적으로 처리되었습니다. ~~ ');
				// span 의 컨텐츠를 Deleted, click_event 를 off
				/* 
				$(this).html('Deleted'); 
				ajax 처리 단계이므로 이미 this는 변경되어 click 시의 this 가 아님 
				=> 그러므로 id 활용 */ 
				$('#'+id).html('Deleted')
				.css({
					color:'Gray',
					fontgWeight:'bold'
				}).off();
				// 이벤트제거 (적용됨) , removeClass 는 적용안됨
			}else if ( resultData.code=='201' )	 {
				$('#resultArea2').html('');
				alert('~~ Delete Sql 오류 !! 잠시후 다시 하세요 ~~');
			}else {
				$('#resultArea2').html('');
				alert('~~ 관리자 로그인 정보 없음!!  다시 하세요 ~~');
			} //else
				
			}, // seccess
			error:function(){
				alert('~~ 서버오류 !! 잠시후 다시 하세요 ~~');
			}
		}); //ajax
	}); //ddd_click 


	
}); //ready

// ** 반복문에 이벤트 적용하기  
// => id별로 board조회
// test 1) JS function
function aidBList(id) {
	$.ajax({
		type:'Get',
		url:'aidblist',
		data: { id:id },
		success:function(resultPage){
			$('#resultArea2').html(resultPage);
		},
		error:function(){
			$('#resultArea2').html('');
			alert(' ~~ 서버오류 !! 잠시후 다시 하세요 ~~');
		}
	}); //ajax
} //aidBList 





