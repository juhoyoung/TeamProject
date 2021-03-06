<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/message.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style type="text/css">
.messageCloseBtn{
		  width: 200px;
		  max-width : 100%;
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
<div id="sendTitle" align="center" style="background-color: #4497fd; width: 100%; height: 50px;">
	<font color="white" id="send_text" style="font-weight: 600; font-size: 18px;">받은 쪽지 확인</font>
</div>
<c:if test="${member.ID!= null}">
	<div id="viewForm" title="메세지 확인" style="padding: 55px 30px; font-size: 15px; line-height: 200%;">
		<input type="hidden" value="${mdto.MESSAGE_NO}" id="MESSAGE_NO" name="MESSAGE_NO">
		<input type="hidden" value="${messageSearchVO.page}" name="page">
		<input type="hidden" value="${messageSearchVO.perPageNum}" name="perPageNum">
		<input type="hidden" value="${messageSearchVO.searchType}" name="searchType">
		<input type="hidden" value="${messageSearchVO.keyword}" name="keyword">
		<table id="viewTable" align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
			<tr bgcolor="white">
				<th>보낸 사람</th>
				<td>${mdto.MESSAGE_SENDER}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${mdto.MESSAGE_SUBJECT}</td>
			</tr>
			<tr>
				<th>받은 날짜</th>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${mdto.MESSAGE_SENDTIME}"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${mdto.MESSAGE_CONTENT}</td>
			</tr>
		</table>
		<div align="center" style="position: absolute; bottom: 60px; margin-top: 20px; width:100%; left:0; right:0; margin-left:auto; margin-right:auto;">
			<input type="submit" value="답장" class="messageCloseBtn blue" onclick="location.href='${pageContext.request.contextPath}/${member.ID}/messageResend?MESSAGE_NO=${mdto.MESSAGE_NO}'">
			<input type="button" value="창닫기" class="messageCloseBtn gray" onclick="window.close()">
		</div>
	</div>
</c:if>
<!-- js 파일 -->
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</body>
</html>