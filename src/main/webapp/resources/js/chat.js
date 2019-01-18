/* 채팅용 JS */

pageNum = 0;
isDetach = true;

function getContextPath() { // ContextPath 얻어오는 함수

	var hostIndex = location.href.indexOf(location.host) + location.host.length;

	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));

}

function getFollowHelper(){
	Handlebars.registerHelper('getType', function(type,chatFollower,chatFollowing,options) {
		  if (type == "chatFollower") {
		    return chatFollower;
		  } else {
		    return chatFollowing;
		  }
	});

	Handlebars.registerHelper('SetBtnState', function(isfollowed,type,options) {
		//console.log(isfollowed);
		if(isfollowed == ""){
			return 'fbhide';
		}
		if (type == "chatFollow") {
			if(isfollowed == 'true'){
			
				return 'fbhide';
			}else{
				return;
			}
		  
		} else if(type =="chatFollowing"){
			if(isfollowed == 'true'){
				return;
			}else{
				return 'fbhide';
			}
		}
		
	});


	Handlebars.registerHelper('GetImgSrc', function(src ,options) {
		//console.log(src);
		
		if(src == null || src == ""){
			return "resources/img/logo_noFlower.png";
		}else
			return src;
		
	});
}
// 


//팔로우 목록을 출력 (로그인된 아이디, 페이지 아이디, 팔로워,팔로잉 목록 확인)
function getFollowList(my_id, page_id, pageType) {
	
	if(pageType == 'chatFollower'){
		url = "/TeamPro/getChatFollowerList"
	}else{
		url = "/TeamPro/getChatFollowingList"
	}
	
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		data : JSON.stringify({
			my_id : my_id,
			id : page_id,
			pageNum : pageNum
		}),
		url : url,
		success : function(result) {
			//console.log(result);
			getFollowHelper();

			if(isDetach == true)
				$("#chatFollow_list").children().detach();
			
			if(result.length == 0){
				if(isDetach == true)
					$("#chatFollow_list").append("<div align='center' style='margin-top:60px;'>" +
												 "<h5 style='font-weight: 600; color: #1d2c52;'>저런! 친구가 없으시네요!</h5></div>");
			}else{
				var source = $("#chatFollow-template").html();
				var template = Handlebars.compile(source);
				var data = {
					chat : result,
					type : pageType
				}	
				//console.log(data);
				var html = template(data);
				$("#chatFollow_list").append(html);
				
				pageNum++;
			}
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

// 버튼 클릭 이벤트 ~~
function BtnClickEvent(){
	// 팔로워 버튼 메뉴 클릭 이벤트
	$(document).on("click", "#chatfollower_Btn" , function(){
		
		var id = $("#page_id").val()
		url = getContextPath() + "/" + id + "/chatFollower/";
		location.href = url;
		
	});
	
	// 팔로잉 버튼 메뉴 클릭이벤트.
	$(document).on("click", "#chatfollowing_Btn" , function(){
		
		var id = $("#page_id").val()
		url = getContextPath() + "/" + id + "/chatFollowing/";
		location.href = url;
		
	});

}

$(document).ready(function(){
	BtnClickEvent();
	
	// 로그인된 아이디 (main.jsp에 hidden값)
	var my_id = $("#CHATROOM_SENDER").val();
	
	// 현재 봐야하는 페이지의 아이디
	var page_id = $("#page_id").val();
	//console.log(my_id + " " + page_id);
	
	// follower 페이지인지 following 페이지 인지.
	var page_type = $("#page_type").val();

	// follow 페이지에서 호출했을때.
	if(page_id != null){
		getFollowList(my_id, page_id, page_type);
	}

})

// 스크롤 할때 처리
// 내일 제대로 작동하는지 확인 필요
$(window).scroll(function() {
	
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    	isDetach = false;
    	
    	// 로그인된 아이디 (main.jsp에 hidden값)
    	var my_id = $("#mem_id").val();
    	
    	// 현재 봐야하는 페이지의 아이디
    	var page_id = $("#page_id").val();
    	//console.log(my_id + " " + page_id);
    	
    	// follower 페이지인지 following 페이지 인지.
    	var page_type = $("#page_type").val();

    	getFollowList(my_id, page_id, page_type);

    }
});
