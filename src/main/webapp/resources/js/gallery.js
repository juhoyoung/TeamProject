pageNum = 0;
countGallery = 0; // 표시된 글 수
is_gDetach = true;

function getContextPath() { // ContextPath 얻어오는 함수 (/TeamPro)

	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	
	console.log(hostIndex);
	
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));

}



function regHelper(){
	Handlebars.registerHelper('SetActive', function(index, options) {
		  
		  if (index == "0") {
		    return "active";
		  } else {
		    return "";
		  }
	});
	
	
	// 이미지 수에 따라 캐러셀 사용 여부를 리턴
	Handlebars.registerHelper('setCarousel', function(length, options) {
		  //console.log(length);
		  // 이미지가 한개일때
		  if (length == "1") {
			  return options.inverse(this);
		  } else { // 이미지가 없거나, 한개 이상 일때.
			 return options.fn(this);
		  }
	});
	
	Handlebars.registerHelper('GetImgSrc', function(src ,options) {
		//console.log(src);
		
		if(src == null || src == ""){
			return "resources/img/baby.jpg";
		}else
			return src;
		
	});
	
	
	// Content 글 출력할때 줄바꿈 처리
	Handlebars.registerHelper('SetContentLine', function(content ,options) {
		//console.log(src);
		
		return content.replace(/\n/g, "<br/>")
		
	});
	
	
	// 드랍다운 버튼 결정. 
	// 세션아이디와 글쓴 아이디가 같은지 다른지.
	Handlebars.registerHelper('GetDropdownBtn', function(writerID , options) {
		  var sessionID = $("#mem_id").val();
		  //console.log(sessionID + " " + writerID);
		  //console.log(sessionID == writerID);
		  // 해당 글이 내가 쓴글일때.
		  if(sessionID == "" || sessionID == null){
			  return "";
		  }
		  else if (sessionID == writerID) {
			  return options.fn(this);
		  } else { // 내가 쓴 글이 아닐때.
			  return options.inverse(this);
		  }
	});
	
	
	Handlebars.registerHelper('SetBtnState', function(isfollowed,type,options) {
		//console.log(isfollowed + " " + type);
		if(isfollowed == ""){
			return 'fbhide';
		}
		if (type == "follow") {
			if(isfollowed == 'true'){
				return 'fbhide';
			}else{
				return;
			}
		  
		} else if(type =="following"){
			if(isfollowed == 'true'){
				return;
			}else{
				return 'fbhide';
			}
		}
		
	});
	
	Handlebars.registerHelper('SetPrivercy', function(Privercy,id,options) {
		//console.log(isfollowed + " " + type);
		var sessionID = $("#mem_id").val();
		
		if(Privercy == "N" || sessionID == id){
			return options.fn(this);
		}else{
			return options.inverse(this);
		}

	});
}

function ShowGallery(id, isMyGall){
	var GotoUrl = "";
	// 내가 쓴 글만 출력할때 = main 으로 접근
	if(isMyGall == 'true'){
		GotoUrl = "/TeamPro/getMyGallery";
	}
	// 대상 id가 쓴 글을 출력할때 = {id}/gallery 로 접근
	else{
		GotoUrl = "/TeamPro/getSpecGallery"
	}

	if(is_gDetach == true)
		$("#gallery_list").children().detach();
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		data : JSON.stringify({
			id : id ,
			pageNum : pageNum
		}),
		DataType : "json",
		url : GotoUrl,
		success : function(result) {
			console.log(result);
			// 차단되어있을때 화면 잠금.			
			if(result.length != 0){
				if(result[0].isblocked == 'true'){
					screenLock();
					return;
				}
				
				var source = $("#gallery-template").html();
				var template = Handlebars.compile(source);
				var data = {
						gall : result,
				}
				
				regHelper();
				
				countGallery = countGallery + result.length;
				var html = template(data);
				$("#gallery_list").append(html);
				TimeFormat();
				
				pageNum++;
			} else{
					if(is_gDetach == true)
						$("#gallery_list").append("<div align='center' style='line-height: 200%;'>" +
								"<img src='"+ getContextPath() +"/resources/img/logo_oops.png'style='width: 20%; margin-bottom: 30px;'/><br/>"+
								"<h4 style='color: #1d2c52; font-weight: 600;'>" +
								"아직 작성한 글이 없습니다.<br/>새로운 글을 업로드 해주세요!</h4></div>");
					
			}
		}
			//console.log(result.length);
		
		
	});
	
}
function galleryDelete(GB_Num){
	$.ajax({
		
		type : "POST",
		contentType : "application/json",
		// dataType: "json",
		data : JSON.stringify(GB_Num),
		url : "/TeamPro/galleryDelete",
		
		success : function() {
			//console.log($("#gallery_"+GB_Num));
			
			$("#gallery_"+GB_Num).remove();
			
			countGallery--;
			
			if(countGallery == 0){
				$("#gallery_list").append("<div align='center' style='line-height: 200%;'>" +
						"<img src='"+ getContextPath() + "/resources/img/logo_sad.png'style='width: 20%; margin-bottom: 30px;'/><br/>"+
						"<h4 style='color: #1d2c52; font-weight: 600;'>" +
						"작성된 글이 없네요!<br/>새로운 친구를 팔로우 해보세요!</h4></div>");
			}
			
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
		
		
		
	});
	
}
// 갤러리 수정
function modifyGallery(gb_Num){
	// 갤러리 글 번호 받아온다.
	
	var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");  //Post 방식
    form.setAttribute("action", getContextPath()+"/galleryModify"); //요청 보낼 주소


    var mb_id = $("#gallery_"+gb_Num).find(".writerId").text();
    var gb_content = $("#gallery_"+gb_Num).children("#Gall_Content").text();
    var gb_Image = $("#gallery_"+gb_Num).children("#carouselControls_"+gb_Num).find(".carousel_Img")


    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "gb_Num");
    hiddenField.setAttribute("value", gb_Num);
    form.appendChild(hiddenField);
    
    
    hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "mb_ID");
    hiddenField.setAttribute("value", mb_id);
    form.appendChild(hiddenField);

    hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "gb_Content");
    hiddenField.setAttribute("value", gb_content);
    form.appendChild(hiddenField);
    
    var contextLen = getContextPath().length;
    
    for(var i=0; i<gb_Image.length; i++){
    	
    	var imgSrc = gb_Image.eq(i).attr("src");
    	imgSrc = imgSrc.substring(contextLen+1,imgSrc.length);
    	//console.log(imgSrc);
    	
    	hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "gb_Image");
        hiddenField.setAttribute("value", imgSrc);
        form.appendChild(hiddenField);
    }
    
    
    document.body.appendChild(form);

    form.submit();
	
}

//팔로우, 차단 버튼 눌렀을때 추가 처리.
function galleryBtnExtends(target_id, type, state){	
	
	
	if(state == 1 && type == "block"){
		$('.followbtn_'+ target_id).filter('.followBtn').removeClass(
		'fbhide');
		$('.followbtn_'+ target_id).filter('.followingBtn').addClass(
		'fbhide');
	}
		
	
}

// 시간 처리 ex)1분전 , 10초전 작성 등등
function TimeFormat(){
	
	var length = $(".writeTime").length;
	var now = new Date();
	var old;
	for(var i=0; i<length; i++){
		var timetxt = $(".writeTime").eq(i).text();
		//console.log(now.getTime() + " : " + timetxt);
		
		old = new Date(parseInt(timetxt));
		var gap = now.getTime() - old.getTime();
		var sgap = Math.round(gap/1000);
		var mgap = Math.round(gap/1000/60);
		var hgap = Math.round(gap/1000/3600);
		if(hgap > 24){
			$(".writeTime").eq(i).text(old.getMonth()+1 + "월 " + old.getDate() + "일");
		}		
		else if(hgap >= 1){
			$(".writeTime").eq(i).text(hgap + "시간 전");
		}else if(mgap >= 1){
			$(".writeTime").eq(i).text(mgap + "분 전");
		}else if(sgap >= 1){
			$(".writeTime").eq(i).text(sgap + "초 전");
		}else{
			$(".writeTime").eq(i).text("방금 전");
		}
		
		//console.log(sgap + "초 차이 ," + mgap + "분 차이 " + hgap + "시간 차이");

	}
	
	
}

function screenLock(){ 
    var obj = document.getElementById("screenLock"); 
    obj.style.width = document.body.Width + 'px'; 
    obj.style.height = document.body.scrollHeight + 'px';

    obj.style.filter = "alpha(opacity=80)"; 
    obj.style.opacity = "0.8"; 
    obj.style.visibility = "visible"; 
}


$('body').scroll(function(){
	
	if ($('body').scrollTop() == $(document).height() - $(window).height()) {
    	is_gDetach = false;
    	
    	// 내 갤러리인지 아닌지
    	var isMyGall = $("#isMyGall").val()
    	// 스크롤링에 사용되는 페이지 번호 
    	var pageid = $("#pageid").val();

    	ShowGallery(pageid, isMyGall);
    	
    }	
});

$(document).ready(function(){
	var isMyGall = $("#isMyGall").val()
	var pageid = $("#pageid").val();

	ShowGallery(pageid, isMyGall);
	
	
	$(document).on("click", ".gall_DropBtn", function(){
		if($(this).hasClass("w3-theme-d1") == false){
			$(this).addClass("w3-theme-d1");
			$(this).next().addClass("w3-show");
		}else{
			$(this).removeClass("w3-theme-d1");
			$(this).next().removeClass("w3-show");
		}
	});
	
	/*$(document).on("blur", ".gall_DropBtn", function(){
		setTimeout(function () {
			$(this).delay(300).removeClass("w3-theme-d1");
			$(this).next().delay(300).removeClass("w3-show");
		},300);
	});*/
	
	
	
	
});

