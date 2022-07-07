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
		
		let stamp = 7;
		
		var stamp1 = $("#stamp1");
		var stamp2 = $("#stamp2");
		var stamp3 = $("#stamp3");
		var stamp4 = $("#stamp4");
		var stamp5 = $("#stamp5");
		var stamp6 = $("#stamp6");
		var stamp7 = $("#stamp7");
		var stamp8 = $("#stamp8");
		var stamp9 = $("#stamp9");
		var stamp0 = $("#stamp0");
		
		if (stamp > 0) {
			stamp1.css("background-image","url(./resources/images/stamp.png)");
			if (stamp > 1) {
				stamp2.css("background-image","url(./resources/images/stamp.png)");
				if (stamp > 2) {
					stamp3.css("background-image","url(./resources/images/stamp.png)");
					if (stamp > 3) {
						stamp4.css("background-image","url(./resources/images/stamp.png)");
						if (stamp > 4) {
							stamp5.css("background-image","url(./resources/images/stamp.png)");
							if (stamp > 5) {
								stamp6.css("background-image","url(./resources/images/stamp.png)");
								if (stamp > 6) {
									stamp7.css("background-image","url(./resources/images/stamp.png)");
									if (stamp > 7) {
										stamp8.css("background-image","url(./resources/images/stamp.png)");
										if (stamp > 8) {
											stamp9.css("background-image","url(./resources/images/stamp.png)");
											if (stamp > 9) {
												stamp0.css("background-image","url(./resources/images/stamp.png)");
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
	});
	</script>
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
<header>
	
</header>
<nav><!-- 메뉴 -->
	<ul id="navimenu">
		<c:if test="${not empty LoginID}" >
			<li id="nav1">대문</li>
			<li id="nav2">도장찍기</li>
			<li id="nav3">우편함</li>
			<li id="nav4">보낸 편지</li>
			<li id="nav5">편지쓰기</li>
		</c:if>
		<c:if test="${empty LoginID}">
			
		</c:if>
	</ul>
</nav>
<section>
	<div style="clear: both;"></div>
	<div id="midbox"><!-- 뭔가... -->
		<div class="clock"><span id="now"></span></div>
		<div class="img" id="img1"></div>
		<div class="img" id="img2"></div>
		<div class="img" id="img3"></div>
		<div class="img" id="img4"></div>
		<div class="img" id="img5"></div>
	</div>
	<div id="userbox"><!-- 로그인창 -->
		<c:if test="${not empty LoginID}" >
			<!-- 내정보 -->
			ID : ${LoginID}<br>
			NAME : ${LoginName}<br>
			<a href="logout">LOGOUT</a><br>
			<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
			
		</c:if>
		<c:if test="${empty LoginID}">
			<ul><li id="loginB">LOGIN</li><li id="joinB">JOIN</li></ul>
			<c:if test="${not empty message}"><span id="message">${message}</span></c:if>
			<div id="mbox"></div>
		</c:if>
	</div>
	<div style="clear: both;"></div>
	<div id="box"><!-- 하단... -->
		<h3>예제1</h3>
		<form method="post" action="clickCheck.jsp">
			<input type="submit" value="Click">
			<span>click = ${mydata.click}</span>
		</form>
		<br>
		<c:if test="${not empty LoginID}" >
			&nbsp;&nbsp;<b>${LoginID}, ${LoginName}</b> 님 안녕하세요 ~~ <br>
		</c:if>
		<c:if test="${empty LoginID}">
			&nbsp;&nbsp;로그인 후 이용 하세요 ~~<br>
		</c:if>
		<hr>
		<c:if test="${empty LoginID}">
			&nbsp;&nbsp;<a href="loginf">LoginF</a>
			&nbsp;&nbsp;<span id="axloginf" class="textlink" >axLoginF</span>
			&nbsp;&nbsp;<a href="stampOne">stamp</a>
		</c:if>
		<hr>
	</div>
</section>
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
<P>  The time on the server is ${serverTime}. </P>
<hr>
<c:if test="${not empty LoginID}" >
	&nbsp;&nbsp;<b>${LoginID}, ${LoginName}</b> 님 안녕하세요 ~~ <br>
</c:if>
<c:if test="${empty LoginID}">
	&nbsp;&nbsp;로그인 후 이용 하세요 ~~<br>
</c:if>
<hr>
<img src="resources/images/n.gif" width="400" height="300" >
<div id="resultArea"></div>
<hr>
<c:if test="${not empty LoginID}">
	&nbsp;&nbsp;<a href="mdetail">MyInfo</a>
	&nbsp;&nbsp;<a href="mdetail?jcode=U">Update</a> 
	&nbsp;&nbsp;<a href="logout">Logout</a>
	&nbsp;&nbsp;<a href="mdelete">탈퇴</a> 
</c:if>
<c:if test="${empty LoginID}">
	&nbsp;&nbsp;<a href="loginf">LoginF</a>
	&nbsp;&nbsp;<span id="axloginf" class="textlink" >axLoginF</span>
	&nbsp;&nbsp;<a href="stamp">stamp</a>
</c:if>
<hr>
&nbsp;&nbsp;<a href="mlist">MList</a> 
&nbsp;&nbsp;<a href="mpagelist">MPList</a>
&nbsp;&nbsp;<a href="mcrilist">MCriList</a>
&nbsp;&nbsp;<a href="mchecklist">MCheck</a><br>

&nbsp;&nbsp;<a href="blist">BList</a>
&nbsp;&nbsp;<a href="bpagelist">BPList</a>
&nbsp;&nbsp;<a href="bcrilist">BCriList</a>
&nbsp;&nbsp;<a href="bchecklist">BCheck</a>
&nbsp;&nbsp;<a href="bjoinlist">BJoin</a><br>
&nbsp;&nbsp;<a href="axtest">AxTest</a>
&nbsp;&nbsp;<a href="extest">Exception</a> 
&nbsp;&nbsp;<a href="bcrypt">BCrypt</a><br>
&nbsp;&nbsp;<a href="gps">GPS</a>
&nbsp;&nbsp;<a href="greensn">GreenSN</a>
&nbsp;&nbsp;<a href="greenall">GreenAll</a>
&nbsp;&nbsp;<a href="jeju">JeJu</a>
&nbsp;&nbsp;<a href="calendarMain">Calendar</a>

<hr>
<c:if test="${not empty message}" >
&nbsp;&nbsp;<b><span style="color:green">${message}</span></b>
</c:if>

</body>
</html>
