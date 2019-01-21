<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 팔로워 페이지인지 팔로잉 페이지인지 --%>
<input type="hidden" id="page_type" value="${type}">
<%-- 현재 봐야하는 페이지의 아이디 --%>
<input type="hidden" id="page_id" value="${page_id}">
<div class="w3-row-padding">
	<div class="w3-col m12">
		<div class="w3-card w3-round w3-white" style="padding: 30px;">
			<div id="div_flist" class="w3-container w3-padding">
				<span id="s_listArea"> <%-- 팔로워 팔로잉 목록 버튼 --%>
					<button type="button" class="w3-button w3-theme-d1 w3-hover-white"
						id="getfollower_Btn">
						<i class="fa fa-thumbs-up" style="color: #4497fd;"></i>
						<span style="font-weight: bold; color:#1d2c52;">&nbsp;팔로워<br>0</span>
					</button>
					<button type="button" class="w3-button w3-theme-d1 w3-hover-white"
						id="getfollowing_Btn">
						<i class="fa fa-thumbs-up" style="color: #597eff;"></i>
						<span style="font-weight: bold; color:#1d2c52;">&nbsp;팔로잉<br>0</span>
					</button>
					<%-- 자신의 페이지 일때만 차단 목록을 볼 수 있다. --%> 
					<c:if test="${member.ID eq page_id}">
						<button type="button" class="w3-button w3-theme-d1 w3-hover-white"
							id="getblocking_Btn">
							<i class="fa fa-thumbs-down" style="color: #f72c47;"></i>
							<span style="font-weight: bold; color:#1d2c52;">&nbsp;차단<br>0</span>
						</button>
					</c:if>
				</span>
				<hr class="w3-clear" style="margin: 5px 0 20px;">			
				<span id="follow_list"> <%-- 팔로우 정보 리스트 영역 --%>				
				</span>
			</div>
		</div>
	</div>
</div>
<script id="follow-template" type="text/x-handlebars-template">
{{#follow}}		
	<div id="list_{{target_id}}">
		<img src="${pageContext.request.contextPath}/{{#GetImgSrc memVO/pic}}{{/GetImgSrc}}" alt="프로필 사진" class="w3-left w3-margin-right w3-circle" style="width: 70px; max-height: 70px;">
		<span id="span_fBtn" class="w3-right">
			<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom followBtn fbBtn {{#SetBtnState isfollowed 'follow'}}{{/SetBtnState}} followbtn_{{target_id}}"
				value='{{target_id}}'>팔로우
			</button>
			<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom followingBtn fbBtn {{#SetBtnState isfollowed 'following'}}{{/SetBtnState}} followbtn_{{target_id}}"
				value='{{target_id}}'>
				<span>팔로잉</span> <span>언팔로우</span>
			</button>
		</span>
						
		<h4 style="color:#1d2c52;">
			<a href="${pageContext.request.contextPath}/{{target_id}}/gallery">
				{{target_id}}
			</a>
		</h4>
		<br>	
		<hr class="w3-clear">
	</div>
{{/follow}}
</script>

<script id="block-template" type="text/x-handlebars-template">
{{#block}}	
	<div id="list_{{target_id}}">
		<img src="${pageContext.request.contextPath}/{{#GetImgSrc memVO/pic}}{{/GetImgSrc}}" alt="프로필 사진" class="w3-left w3-circle w3-margin-right" style="width: 60px">
		<span id="span_fBtn" class="w3-right">
			<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom blockBtn fbBtn blockbtn_{{target_id}} fbhide"
				value='{{target_id}}'>차단
			</button>
			<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom blockingBtn fbBtn blockbtn_{{target_id}}"
				value='{{target_id}}'>
				<span>차단중</span> <span>차단 해제</span>
			</button>
		</span>
						
		<h4>
			<a href="${pageContext.request.contextPath}/{{target_id}}/gallery">
				{{target_id}}
			</a>
		</h4>
		<br>	
		<hr class="w3-clear">
	</div>
{{/block}}

</script>

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/followblock.js"></script> --%>