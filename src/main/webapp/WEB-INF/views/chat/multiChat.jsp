<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<!-- JS 파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sockjs.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<style type="text/css">
.messageCloseBtn{
		  width: 200px;
		  height: 50px;
		  border-radius: 5px;	  
		  border: none;
		  padding: 2px;
		  color: white;
		  font-weight: 600;		  	
}	
.blue{
	background-color: #6494ff;
}	
.gray{
	background-color: #cbcbcd;
}
</style>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
	<div id="positionLayer">
	<!-- 레이어팝업 -->
	<table align="center" bgcolor="#FFFFFF" width="100%">
		<tr>
			<c:choose>
				<c:when test="${cvo2.CHATROOM_RECEIVER ne member.ID}">
					<td bgcolor="#4497fd" align="center" height="50px" width="100%" style="border: solid 1px #4497fd;">
						<font style="font-size: 18px; font-weight:bold" color="#FFFFFF">${cvo2.CHATROOM_RECEIVER}님과의 대화</font>
					</td>
				</c:when>
				<c:otherwise>
					<td bgcolor="#4497fd" align="center" height="50px" width="100%" style="border: solid 1px #4497fd;">
						<font style="font-size: 18px; font-weight:bold" color="#FFFFFF">${cvo2.CHATROOM_SENDER}님과의 대화</font>
					</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<td>
				<div style="padding: 20px 0; overflow: auto; width: 90%; height: 390px;" align="left" id="chatArea" >
					<ul id="discussion"></ul>
				</div>
 			<ul id="discussion"></ul>
			<br/>
			<br/>		
	<c:choose>
		<%-- 로그인 되어 있을 경우 --%>
		<c:when test="${member.ID != null}">
			<input type="hidden" id="memID" name="CHAT_SENDER" width="110" value="${member.ID}" readonly="readonly">
			<input type="hidden" id="uID" name="CHAT_RECEIVER" width="110" value="${cvo2.CHATROOM_RECEIVER}" readonly="readonly">
			<span style="display: none;" id="memName" width="110" value="${member.NAME}" readonly="readonly">${member.NAME}</span>
		</c:when>
		<%-- 로그인되어 있지 않을 경우 로그인 화면으로 이동 --%>
		<c:otherwise>
			<%
				response.sendRedirect("login");
			%>
		</c:otherwise>
	</c:choose>
		<input type="text" class="chatInput" id="message" size="50" align="middle" placeholder="메세지를 입력하세요">
			<br/>
			<ul id="discussion">
			</ul>
			</td>
		</tr>	
	</table>
	<input type="submit" class="messageCloseBtn blue" id="btnSend" value="전송" disabled="disabled"/>
	<input type="button" class="messageCloseBtn gray" id="closeBtn" value="창닫기" onclick="window.close()">
	<br/>
<!-- 채팅 API -->
	<script src="http://demo.dongledongle.com/Scripts/jquery-1.10.2.min.js"></script>
	<script src="http://demo.dongledongle.com/Scripts/jquery.signalR-2.2.1.min.js"></script>

	<script type="text/javascript">
		var connection = $.hubConnection('http://demo.dongledongle.com/');
		var chat = connection.createHubProxy('chatHub');
		var sender = '<c:out value="${cvo.CHAT_SENDER}"/>';
// 		var pic = '<c:out value="${member.PIC}"/>';
		
		$(document).ready(
				
				function() {
					chat.on('addNewMessageToPage', function(memID, message) {
						var memName = document.getElementById('memName');
						var list_ID = "<li class='listId'><strong style='color: #1d2c52;'>"+htmlEncode(memID)+"</strong></li>"
//  						var list_pic = "<img src='../resources/img/logo_noFlower.png' style='width: 12%; display:block;'>"
						var list_route = "<li class='balloon'><span name='CHAT_SENDCONTENT' id='CHAT_SENDCONTENT'>"+htmlEncode(message)+"</span></li><br/>";
						
						$('#discussion').append(list_ID+list_route);
						var chatAreaHeight = $('#chatArea').height();
						var maxScroll = $('#discussion').height() - chatAreaHeight;
						$('#chatArea').scrollTop(maxScroll);
					});
					$('#message').focus();
				
				connection.start({jsonp : true}).done(
				function (){
					$('#btnSend').click(function () {
						chat.invoke('send', $('#memID').val(),
											$('#message').val());
											$('#message').val('').focus();
					});
				});
		});
		function htmlEncode(value) {
			var encodedValue = $('<div />').text(value).html();
			return encodedValue;
		};
		//엔터키 인식하여 메세지 전송
		var input = document.getElementById("message");
		input.addEventListener("keyup", function(event) {
			event.preventDefault();
			if (event.keyCode == 13) {
				document.getElementById("btnSend").click();
			}
			//빈칸 인식
			if ($('#message').val().length==0) {
				$('#btnSend').attr('disabled', 'disabled');
			}else{
				$('#btnSend').removeAttr('disabled');	
			}
		/* var my_id = document.getElementById("memID");
		var uid = document.getElementById("uID");

			if (my_id == sender) {
				$('#discussion li').addClass('right');
			}else{
				$('#discussion li').addClass('left');
			} */
		});
	</script>
<!-- 채팅 API -->	
	</div>
</body>
</html>