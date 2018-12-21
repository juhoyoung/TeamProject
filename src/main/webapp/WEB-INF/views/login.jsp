<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.msg{font-size: 10pt; color: blue;}
</style>
</head>
<link rel="stylesheet" href="./resources/css/main2.css"/>
<body style="margin: 5% 10% 0 10%">
	<form action="loginPost" method="post">
		<table class="login_page">
			<caption>Login</caption>
			<tr>
				<td>
					<input type="text" name="ID" id="ID" placeholder="ID"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="PWD" id="PWD" placeholder="Password"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" id="Login" value="Login"/>
					<!-- 회원가입 페이지 넘어가는 용 -->
					<input type="button" value="Register" id="Register"/>
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>