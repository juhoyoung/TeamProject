<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
	.uploadResult{
	width:100%;
	background-color:gray;
	}
	.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
	}
	.uploadResult ul li{
	list-style: none;
	padding :10px;
	align-content: center;
	text-align: center;
	}
	.uploadResult ul li img{
	width:100px;
	}
	
	.uploadResult ul li span{
		color:white;
	}
	
	.bigPictureWrapper{
		position: absolute;
		display: none;
		justify-content:center;
		align-items: center;
		top:0%;
		width:100%;
		height:100%;
		background:rgba(255,255,255,0.5);
	}
	.bigPicture{
		position:relative;
		display: flex;
		justify-content:center;
		align-items: center;
	}
	.bigPicture img{
		width:600px;
	}
</style>
      <div class="w3-row-padding">
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
              <div align="center" style="padding: 30px;">
              <%-- 로그인된 아이디 --%>
<input type="hidden" id="mem_id" value="${member.ID}">
<h2>글쓰기 페이지</h2>
<c:set var="path" value="${pageContext.request.contextPath}" />
<form name="ddto" method="post" action="${path}/${member.ID}/deal/insert" class="table" >
	<div>제목<input name="DEAL_SUBJECT" id="deal_subject" size="80" required></div>
	<div>내용<textarea name="DEAL_CONTENT" id="deal_content" rows="8" cols="80" required></textarea> </div>
	<div>작성자<input name="DEAL_ID" id="deal_id" size="80" required></div>  
	
	<div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">File Attach</div>
            			<div class="panel-body">
            				<div class="form-group uploadDiv">
            					<input type="file" name="uploadFile" multiple>
            				</div>
            				<div class="uploadResult">
            					<ul>
            					</ul>
            				</div>
            			</div>
            		</div>
            	</div>
            </div>
		<div style="width:650px; text-align:center;">
            <input type="submit" value="확인">
            <input type="reset" value="리셋">
            <input type="button" value="목록" onclick="location.href='${path}/${member.ID}/deal/list'">
        </div>
		
</form>
			</div>
            </div>
          </div>
        </div>
      </div>
      <script>
	$(document).ready(function(e){
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
			var str="";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj =$(obj);
				
				console.dir(jobj);
				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			formObj.append(str).submit();
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;	//5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >=maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr||uploadResultArr.length==0){return;}
			var uploadUL = $(".uploadResult ul");
			
			var str="";
			$(uploadResultArr).each(function(i,obj){
				//image type
				if(obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName);
					str+="<li data-path='"+obj.uploadPath+"'";
					str+="data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"'data-type='"+obj.image+"'><div>";
					str+="<span>"+obj.fileName+"</span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/display?fileName="+fileCallPath+"'>";
					str+="</div></li>";
				}else{
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					var fileLink =fileCallPath.replace(new RegExp(/\\/g),"/");
					str+="<li data-path='"+obj.uploadPath+"'";
					str+="data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"'data-type='"+obj.image+"'><div>";
					str+="<span>"+obj.fileName+"</span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<a><img src='/resources/img/attach.jpg'></a>";
					str+="</div></li>";
				}
			});
			uploadUL.append(str);
		}
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			for(var i=0; i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size))	{
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url:'/uploadAjaxAction',
				processData:false,
				contentType:false,
				data:formData,
				type:'POST',
				dataType:'json',
				success:function(result){
					console.log(result);
					showUploadResult(result); 
				}
			});
		});
		$(".uploadResult").on("click","button",function(e){
			console.log("delete file");
			var targetFile=$(this).data("file");
			var type=$(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url:'/deleteFile',
				data:{fileName: targetFile, type:type},
				dataType:'text',
				type:'POST',
				success:function(result){
					alert(result);
					targetLi.remove();                
				}
			})
		});

	});
</script>