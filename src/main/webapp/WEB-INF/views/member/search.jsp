<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.searchTemplateStyle{
width: 30%; 
margin: 0px 10px 10px 10px;

}

</style>

</head>
<body>
<input type="hidden" id="keyword" value="${keyword}">

<!-- Profile -->
	<div class=" w3-row-padding" id="search_list" style="text-align: left; min-height : 1px">

	
	</div>

<script id="search-template" type="text/x-handlebars-template">
{{#search}}
			<div class="w3-col w3-card w3-round w3-white searchTemplateStyle">
				<div class="w3-container">
					<br />
					<div class="w3-center image_wrapper">
						<%-- 만약 회원 프로필 이미지가 없을 경우에는 기본 이미지를 띄운다. --%>
						<img src="${pageContext.request.contextPath}/{{sMem_pic}}" class="w3-circle" style="height: 110px;  width: 100%;">
					</div>
					<hr>
					<%-- 회원 정보 --%>
					<div class="member_icon" style="font-weight: 500; font-size: 15px;">
						<span class="w3-right smallSizeFont">
							<button type="button"
								class="w3-button w3-theme-d1 w3-margin-bottom followBtn fbBtn {{#SetBtnState isfollowed isblocked 'follow'}}{{/SetBtnState}} followbtn_{{sMem_id}}"
								value='{{sMem_id}}'>팔로우</button>
							<button type="button"
								class="w3-button w3-theme-d1 w3-margin-bottom followingBtn fbBtn {{#SetBtnState isfollowed isblocked 'following'}}{{/SetBtnState}} followbtn_{{sMem_id}}"
								value='{{sMem_id}}'>
								<span>팔로잉</span> <span>언팔로우</span>
							</button>
							<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom blockingBtn fbBtn {{#SetBtnState isfollowed isblocked 'blocking'}}{{/SetBtnState}} blockbtn_{{sMem_id}}"
								value='{{sMem_id}}'>
								<span>차단중</span> <span>차단 해제</span>
							</button>
							<%-- 드랍다운 버튼 --%>
							<div class="w3-dropdown-click">
							<button class="search_DropBtn w3-button w3-white w3-hover-white" style="padding: 0px 0px 15px 0px;">
								<i class="fa fa-cog" aria-hidden="true"></i>
							</button>
								<div id="searchDrop_{{sMem_id}}" class="w3-dropdown-content w3-bar-block w3-border">
									<a href="${pageContext.request.contextPath}/{{sMem_id}}/follower" class="w3-bar-item w3-button">팔로우 목록</a>
									<button class="w3-bar-item w3-button blockBtn blockbtn_{{sMem_id}}" value="{{sMem_id}}">차단 하기</button>
					
									<button type="button" class="w3-bar-item w3-button blockingBtn blockbtn_{{sMem_id}} fbhide"
										value='{{sMem_id}}'>
										<span>차단 중</span> <span>차단 해제</span>
									</button>
								</div>
							</div>

							<%-- 드랍다운 버튼 끝 --%>
						</span>
						<p style="padding-top: 5px; margin-bottom: 7px;">
							<font style="font-size: 17px; font-weight: bold; color: #1d2c52;">
								<a href="${pageContext.request.contextPath}/{{sMem_id}}/gallery">{{sMem_id}}</a>
							</font>
						</p>
						<br>
						<%-- 이메일 --%>
						<p><i class="fa fa-envelope fa-fw w3-text-theme"></i><font style="color: #1d2c52;">{{sMem_email}}</font></p>
					</div>
				</div>
			</div>
{{/search}}
</script>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/search.js"></script>

</body>
</html>
