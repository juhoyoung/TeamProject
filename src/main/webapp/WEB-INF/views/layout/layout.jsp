<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- CSS -->
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../resources/css/main2.css"/>
	<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
	</style>
<body>
	<div id="header"><tiles:insertAttribute name="header"/></div>
	<div id="side-left"><tiles:insertAttribute name="side-left"/></div>
	<div id="side-right"><tiles:insertAttribute name="side-right"/></div>
</body>
</html>