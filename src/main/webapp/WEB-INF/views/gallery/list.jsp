<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 내가 쓴글만 보여주는건지, 특정 아이디의 글을 볼건지. --%>
<input type="hidden" id="isMyGall" value="${isMyGall}">
<%-- url 아이디 --%>
<input type="hidden" id="pageid" value="${pageid}">
	
<div class="w3-row-padding">
	
	<div class="w3-col m12">
		<div class="w3-card w3-round w3-white" style="padding: 20px 30px;">
			<div class="w3-container w3-padding" id="gallery_list">
			</div>
		</div>
		<td colspan="1">
	</div>
	<!-- Single button -->
	
</div>

<%-- 임시 주석 처리 --%>
<div id="screenLock" style="width:100%; height:100%; top:0px; left:0px; position:absolute; z-index:1; background:#1B1B1B; visibility:hidden;"> -->
	<div style="position: relative; top: 50%; text-align: center; color: red; font-size: 20px; font-weight: bold; opacity: 1.0;">
		차단된 페이지에는 접근할 수 없습니다!<br><br>
		<a href="javascript:history.back();" style=" border: 1px solid white; color: white; border-radius: 20px; padding: 5px 10px;">
		돌아가기
		</a>
	</div> 
	
	
</div>

<script id="writeTemplate" type="text/x-handlebars-template">
<div class = "noAttach">
	{{#write}}
	<table border ="0">
		<tr class="recommentinfo">
			<td width = "10%">
				<a href="${pageContext.request.contextPath}/{{mb_ID}}/gallery" class="w3-bar-item w3-button w3-hover-white">
					<strong>{{mb_ID}}</strong>
				</a>
			</td>
			<td width = "70%">
				<a onclick="modifyRecomment({{cm_Seq}})" href ="javascript:void(0);">{{cm_Content}}</a>
			</td>
			<td width="15%" class="commentTime" align ="right">
				<font style="color: #78787c;">{{cm_Date}}</font>
			</td>

			<%-- 삭제 버튼 --%>
			{{#SetDeleteBtn mb_ID}}
			<td width="5%" align ="right">
				<a href="javascript:void(0);" onclick="deleteBtn({{cm_Seq}},{{gb_Num}})">
					<i class="fa fa-fw fa-remove" style="color: #78787c;"></i>
				</a>
			</td>
			{{/SetDeleteBtn}}
			<%-- 삭제 버튼 끝--%>
		</tr>
	</table>
	{{/write}} 

	<div class="container">
    <form role = "form"  method="post" name ="recommentWrite" id="recommentWrite">
    <br><br>
        <div>
            <div>
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <textarea rows="5" cols="40" class="w3-col m12 write_area" id="space" name="CM_Content" 
					placeholder="하고싶은 말을 적어보세요!" style="resize: none;"></textarea>
            </div>
        </div>
        <input type="hidden" id="MB_ID" name="MB_ID" value="${member.ID}" />
		<input type="hidden" id="GB_Num" name="GB_Num" value="{{gb_Num}}" />
		<input type="button" class="btn pull-right btn_comment" value="등록" style="width: 150px; max-width : 100%;height: 40px;border-radius: 5px; 
		background-color: #6494ff;border: none;padding: 2px;color: white;font-weight: 600;" onclick="formRecommentWrite()">
	</div>
    </form>
</div>
</script>


<script id="gallery-template" type="text/x-handlebars-template">
{{#gall}}

{{#SetPrivercy gallery/gb_Privacy gallery/mb_ID}}
<div id="gallery_{{gallery/gb_Num}}">
	<span class="profileImg">
		<img src="${pageContext.request.contextPath}/{{#GetImgSrc memVO/pic}}{{/GetImgSrc}}" alt="Avatar"
			class="w3-left w3-circle w3-margin-right" style="width: 60px">
	</span>
	<%-- 드랍다운 버튼 --%>
	{{#GetDropdownBtn gallery/mb_ID}}
	<%-- 내가 쓴 글일때 --%>
	<span class="w3-right">
		<div class="w3-dropdown-click">
			<button class="gall_DropBtn w3-button w3-white w3-hover-white">
				<i class="fa fa-check" aria-hidden="true" style="font-size: 15px; color: #78787c;"></i>
			</button>
			<div id="gallDrop_{{gallery/gb_Num}}" class="w3-dropdown-content w3-bar-block w3-border">
				<a href="#" onclick="modifyGallery({{gallery/gb_Num}})" class="w3-bar-item w3-button">수정</a> 
				<a href="" onclick="galleryDelete({{gallery/gb_Num}}); return false;" class="w3-bar-item w3-button">삭제</a>
			</div>
		</div>
	</span>
	{{else}}
	<%-- 다른 사람이 쓴 글일때 --%>
	 <span class="w3-right">
		<div class="w3-dropdown-click">
			<button class="gall_DropBtn w3-button w3-white w3-hover-white">
				<i class="fa fa-check" aria-hidden="true"></i>
			</button>
			<div id="gallDrop_{{gallery/gb_Num}}" class="w3-dropdown-content w3-bar-block w3-border">
				<a href="${pageContext.request.contextPath}/{{gallery/mb_ID}}/follower" class="w3-bar-item w3-button">팔로우 목록</a>
				<%-- 팔로우 언팔로우 버튼 --%>
				<button class="w3-bar-item w3-button followBtn followbtn_{{gallery/mb_ID}} {{#SetBtnState isfollowed 'follow'}}{{/SetBtnState}}" value='{{gallery/mb_ID}}'>팔로우</button>
				<button class="w3-bar-item w3-button followingBtn followbtn_{{gallery/mb_ID}} {{#SetBtnState isfollowed 'following'}}{{/SetBtnState}}"
					value='{{gallery/mb_ID}}'>
					<span>팔로잉</span> <span>언팔로우</span>
				</button>
				<%-- 차단 차단해제 버튼 --%>
				<button class="w3-bar-item w3-button blockBtn blockbtn_{{gallery/mb_ID}}" value="{{gallery/mb_ID}}">차단 하기</button>
				<button type="button" class="w3-bar-item w3-button blockingBtn blockbtn_{{gallery/mb_ID}} fbhide"
					value='{{gallery/mb_ID}}'>
					<span>차단 중</span> <span>차단 해제</span>
				</button>
			</div>
		</div>
	</span>
	
	{{/GetDropdownBtn}} 
	
	

	<%-- 드랍다운 버튼 끝 --%>
	<%-- 글쓴이, 작성시간 --%>
		<a href="${pageContext.request.contextPath}/{{gallery/mb_ID}}/gallery"><font class="writerId" style="font-size: 18px; color: #1d2c52; font-weight: 600;">{{gallery/mb_ID}}</font></a><br/>
		<font class="writeTime w3-opacity">{{gallery/gb_Date}}</font><br/><br/>

	
	
	<%-- 캐러셀 --%>
	<div id="carouselControls_{{gallery/gb_Num}}" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			{{#file}}
				<div class="carousel-item {{#SetActive @index}}{{/SetActive}}">
					<img class="carousel_Img d-block w-100" src="${pageContext.request.contextPath}/{{gb_File}}" alt="이미지">
				</div>
			{{/file}}		
	
		</div>
		{{#setCarousel file.length}}
			<a class="carousel-control-prev" href="#carouselControls_{{gallery/gb_Num}}" role="button" data-slide="prev"> 
				<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carouselControls_{{gallery/gb_Num}}" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span> 
				<span class="sr-only">Next</span>
			</a>
		{{/setCarousel}}
	</div>		

	<%-- 글 내용 --%>
	<span id="Gall_Content"><p>{{#SetContentLine gallery/gb_Content}}{{/SetContentLine}}</p></span>
	<span id ="recomment_{{gallery/gb_Num}}"></span>

	<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom w3-hover-white" onclick ="recomment({{gallery/gb_Num}})">
		<i class="fa fa-comment" id="comment_i"></i><font class="listFont" style="font-size: 14px; color: #1d2c52;">Comment</font>
		 <span class="w3-badge w3-right w3-small"
				style="background-color: #cbcbcd;">{{count}}</span>
	</button>
	
	<hr class="w3-clear" style="margin: 5px 0 20px;">
</div>
{{/SetPrivercy}}	
{{/gall}}
</script>


<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/gallery.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/recomment.js"></script>