<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/follow.css">
<!-- JS 파일 -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js"></script>
<script src="/${pageContext.request.contextPath}/resourses/js/sockjs.js"></script>
<script src="/${pageContext.request.contextPath}/resourses/js/chat.js"></script>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<%-- 팔로워 페이지인지 팔로잉 페이지인지 --%>
<input type="hidden" id="page_type" value="${type}">
<%-- 현재 봐야하는 페이지의 아이디 --%>
<input type="hidden" id="page_id" value="${page_id}">
	<div id="positionLayer">
		<div align="center" style="border: solid 1px #4497fd; background-color:#4497fd; height: 50px; width: 100%;">
			<font style="font-size: 18px; font-weight:bold; line-height: 50px;" color="#FFFFFF">채팅 목록</font>
		</div>
		<span id="chatListArea">
			<a href="${pageContext.request.contextPath}/${member.ID}/multiChatList">채팅 중인 목록</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/${member.ID}/chatSearch">팔로우 리스트</a>
		</span>
		<hr>
		<jsp:include page="${center}"></jsp:include>
	</div>
</html>