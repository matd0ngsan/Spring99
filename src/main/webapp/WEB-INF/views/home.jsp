<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axTest01.js"></script>
	
</head>
<body>
<c:if test="${not empty LoginID}" >
	<header>
	<div id="mybox">
		<!-- 내정보 -->
		<span>ID : </span><span>${LoginID}</span> <span>NAME : </span><span>${LoginName}</span> <a href="logout">로그아웃</a><a href="memberDelete">탈퇴</a><br>
	</div>
	</header>
	<nav><!-- 메뉴 -->
		<ul id="navimenu">
			<li id="nav1">도전 중</li>
			<li id="nav2">도전 성공</li>
			<li id="nav3">받은 편지</li>
			<li id="nav4">보낸 편지</li>
			<li id="nav5">편지쓰기</li>
			<li id="nav6">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</li>
		</ul>
	</nav>
	<section>
		<div id="box"><!-- 하단... -->
			<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
			
			<p class="hometext">
			<br>이 사이트에서는...<br><br>
			
			<span class="text1">사용법</span><br><br>
			<span class="text2">도장</span> : 도전 과제를 만들고, 달성하고, 해낸 도전들을 기록할 수 있어요.<br>
			<span class="text2">편지</span> : 친구들과 주고받은 편지를 달성 갯수에 따라 열어볼 수 있어요.<br><br>
			
			<span class="text2">잠깐!</span><br>
			한 번 등록한 도전은 내용을 완수할 때까지 삭제할 수 없어요.<br>
			한 번 보낸 편지는 친구가 확인하기 전에만 삭제할 수 있어요.<br><br>
			
			<span class="text1">주의사항</span><br><br>
			본 사이트는 포트폴리오 용으로 개인에게 제작되었습니다.<br>
			본 사이트에 입력된 모든 정보는 제작자의 의도에 따라, 혹은 의도가 아니더라도 불시에 삭제되거나 다른 곳에 제출, 게시될 수 있습니다.<br><br>
			
			!! 개인 정보를 입력하지 않도록 주의해주세요. !!<br><br>
			
			
			</p>
			
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
		$("#mbox").load("loginf");
	});
	
	$("#joinB").click(function(){
		$("#mbox").load("joinf");
	});

	$("#nav1").click(function(){
		$("#box").load("sselect");
	});

	$("#nav2").click(function(){
		$("#box").load("slist");
	});

	$("#nav3").click(function(){
		$("#box").load("mlistR");
	});
	
	$("#nav4").click(function(){
		$("#box").load("mlistS");
	});

	$("#nav5").click(function(){
		$("#box").load("mpostf");
	});
	
	$("#nav6").click(function(){
		location.reload();
	});
</script>


</body>
</html>
