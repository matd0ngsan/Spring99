<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axTest01.js"></script>
	
	<script>
		
	$(function() {
		
		var now = new Date();
		
		//var year = now.getFullYear(); // 년, 2015
		//var month = (now.getMonth() + 1); // 월, 11[1을 더해야함. 유일하게 조심해야할 부분. 1월은 0이다.]
		//var date = now.getDate(); // 일, 14
		 
		let h = now.getHours(); // 시, 10
		let m = now.getMinutes(); // 분, 35
		let s = now.getSeconds(); // 초, 42
		 
		//var day = now.getDay(); // 요일, 숫자로 출력됨(0~6), 일요일(0)부터 시작해서 토요일(6)에 끝남
		
					
		setInterval(function() {
			now = new Date();
			h = now.getHours();
			m = now.getMinutes();
			s = now.getSeconds();
			
			$("#now").text(h + " : " + m + " : " + s);
		}, 1000);
	});
	</script>
	
	<script>
		
	$(function() {
		
		let cnt = 0;
		
		var img1 = $("#img1");
		var img2 = $("#img2");
		var img3 = $("#img3");
		var img4 = $("#img4");
		var img5 = $("#img5");
				
		setInterval(function() {
			
			switch(cnt) {
				case 0 : break;
				case 1 : img1.css("background-image","url(./resources/images/n.gif)"); break;
				case 2 : img2.css("background-image","url(./resources/images/n.gif)"); break;
				case 3 : img3.css("background-image","url(./resources/images/n.gif)"); break;
				case 4 : img4.css("background-image","url(./resources/images/n.gif)"); break;
				case 5 : img5.css("background-image","url(./resources/images/n.gif)"); break;
				case 6 : img1.css("background-image","none"); break;
				case 7 : img2.css("background-image","none"); break;
				case 8 : img3.css("background-image","none"); break;
				case 9 : img4.css("background-image","none"); break;
				case 10 : img5.css("background-image","none"); cnt = 0; break;
			}
			cnt++;
		}, 1000);
		
	});
	</script>

</head>
<body>
<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
<c:if test="${not empty LoginID}" >
	<header>
	<div id="mybox">
		<!-- 내정보 -->
		ID : ${LoginID} NAME : ${LoginName} <a href="logout">LOGOUT</a><br>
	</div>
	</header>
	<nav><!-- 메뉴 -->
		<ul id="navimenu">
			<li id="nav1">도전 중</li>
			<li id="nav2">도전 성공</li>
			<li id="nav3">받은 편지</li>
			<li id="nav4">보낸 편지</li>
			<li id="nav5">편지쓰기</li>
		</ul>
	</nav>
	<section>
		<div id="box"><!-- 하단... -->
			현재까지 받은 편지 갯수
			열람한 편지 갯수
			이...정보를 받아서 home으로 넘기는 컨트롤러 만들기
			<c:if test="${not empty banana2}">
				<c:forEach var="mailRN" items="${banana2}">
					읽지 않은 메세지가 ${mailRN.seq} 통 있습니다.
				</c:forEach>
			</c:if>
		</div>
	</section>
</c:if>
<c:if test="${empty LoginID}">
	<section>
	<div id="userbox">
		<div id="btnbox"><ul><li id="loginB">LOGIN</li><li id="joinB">JOIN</li></ul></div>
		<div id="mbox"></div>
	</div>
	</section>
</c:if>

<script>
	$("#loginB").click(function(){
		//도장판 (있으면 등록, 없으면...)
		$("#mbox").load("loginf");
	});
	
	$("#joinB").click(function(){
		//도장판 (있으면 등록, 없으면...)
		$("#mbox").load("joinf");
	});

	$("#nav1").click(function(){
		//도장판 (있으면 등록, 없으면...)
		$("#box").load("sselect");
	});

	$("#nav2").click(function(){
		//달성치 수정 (클릭하면 확인하고 작동)
		$("#box").load("slist");
	});

	$("#nav3").click(function(){
		//내가 받은 메시지 상태 (아래에 띄워줌)
		//$("#box").html("<h3>예제1</h3><button>Click</button><p>--------</p><p>------</p>");
		$("#box").load("mlistR");
	});
	
	$("#nav4").click(function(){
		//아직뭐없음 테스트...
		$("#box").load("mlistS");
	});

	$("#nav5").click(function(){
		//아직뭐없음 테스트...
		$("#box").load("mpostf");
	});
</script>


</body>
</html>
