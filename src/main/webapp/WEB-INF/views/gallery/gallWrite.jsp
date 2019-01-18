<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<!-- 핸들바 기능 -->
<script id ="fileTemplate" type="text/x-handlebars-template">
	<li>	
		<input type="hidden" name = "gb_Image" value ="{{originalFileUrl}}">
		<div class = "mailbox-attachment-info">
			<a href ="{{originalFileUrl}}" class="mailbox-attachment-name">
				<img src="{{imgSrc}}" alt = "Attachment" class ="view" align ="center">
			</a>
			<a href="{{fullName}}" class = "btn btn-default btn-xs pull-right delBtn">
				<i class="fa fa-fw fa-remove" style="font-size: 20px; color: #78787c;"></i>
			</a>
		</div>
	</li>
</script>
</head>
<body>
      <div class="w3-row-padding">
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
          
<div><br>
	<h4 style="font-weight: 600; color: #1d2c52;" align="center">글쓰기</h4>
	<hr class="w3-clear" style="margin: 5px 0 20px;">
	<form role = "form" method = "post" action="galleryWrite">
	<input type="hidden" name="mb_ID" value="${member.ID}">	
	<div id="space">
		<select name="gb_Privacy">
			<option value="N" selected="selected">친구공개</option>
			<option value="Y">미공개</option>
		</select>
	</div>
	<textarea rows="5" cols="40" class="w3-col m12 write_area" id="space" name="gb_Content" 
	placeholder="하고싶은 말을 적어보세요!" style="resize: none;"></textarea>

	<%-- 이미지 열기 버튼 --%>
	<span id="file-click">
		<i class="fa fa-camera" aria-hidden="true" style=" font-size: 30px;"></i>
	</span>
	<input type="file" id="file_btn" style=" display: none;">
	

	
	<div class="file-area w3-col m12" >
		<div id="upload-area">
		    <div class="file-dummy" id="space">
		       <div class = "box-footer">
		       		<ul class = "mailbox-attachments clearfix uploadedFileList" style="list-style: none;"></ul>	       
		       </div>
		    </div>
		</div>
	</div>
	<div id ="space" style="text-align: center;">
		<input type ="submit" class="uploadBtn" value="등록">
		<input type ="reset"  class="uploadBtn" value="다시작성">
	</div>
	</form>
</div>
</div>
</div>
</div>
</div>
</body>
<!-- js파일 -->

<!-- image upload -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.7/handlebars.min.js"></script>
<script src="js/load-image-orientation.js"></script>
<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/lightbox.js"></script>

<!-- <script  src="https://code.jquery.com/jquery-3.3.1.js"></script> -->
</html>