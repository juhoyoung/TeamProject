pageNum = 0;
isDetach = true;

function getContextPath() { // ContextPath 얻어오는 함수

	var hostIndex = location.href.indexOf(location.host) + location.host.length;

	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));

}

// function이 존재하는지 체크 후 호출
function existFunction(func){
	return typeof func == "function";
}


function getFollowHelper(){
	Handlebars.registerHelper('getType', function(type,follower,following,options) {
		  if (type == "follower") {
		    return follower;
		  } else {
		    return following;
		  }
	});

	Handlebars.registerHelper('SetBtnState', function(isfollowed,type,options) {
		//console.log(isfollowed);
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
	
	if(pageType == 'follower'){
		url = "/TeamPro/getFollowerList"
	}else{
		url = "/TeamPro/getFollowingList"
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
			
			if(result.length > 0){
				$("#getfollower_Btn > span").html("팔로워 <br>" + result[0].followerNum);
				$("#getfollowing_Btn > span").html("팔로잉 <br>" + result[0].followingNum);
				$("#getblocking_Btn > span").html("차단 <br>" + result[0].blockingNum);
			}
			
			if(isDetach == true)
				$("#follow_list").children().detach();
			
			if(result[0].memVO == null){
				if(isDetach == true)
					$("#follow_list").append("<div align='center'>" +
											"<img src='" + getContextPath() + "/resources/img/logo_sad.png'style='width: 20%; margin-bottom: 30px; padding-left:20px;'/>"+
											"<h4 style='font-weight: 600; color: #1d2c52;'>저런! 친구가 없으시네요!</h4></div>");
			}else{
				var source = $("#follow-template").html();
				var template = Handlebars.compile(source);
				var data = {
					follow : result,
					type : pageType
				}	
				//console.log(data);
				var html = template(data);
				$("#follow_list").append(html);
				
				pageNum++;
			}
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}


// 차단 목록을 출력 (로그인된 아이디)
function getBlockingList(my_id) {

	$.ajax({
		type : "POST",
		contentType : "application/json",
		data : JSON.stringify({
			id : my_id,
			pageNum : pageNum
		}),
		url : "/TeamPro/getBlockingList",
		success : function(result) {
			//console.log(result);
			getFollowHelper();
			
			if(result.length > 0){
				$("#getfollower_Btn > span").html("팔로워 <br>" + result[0].followerNum);
				$("#getfollowing_Btn > span").html("팔로잉 <br>" + result[0].followingNum);
				$("#getblocking_Btn > span").html("차단 <br>" + result[0].blockingNum);
			}
			
			if(isDetach == true)
				$("#follow_list").children().detach();
			
			if(result[0].memVO == null){
				if(isDetach == true)
					$("#follow_list").append("<div align='center'>" +
									 		 "<img src='" + getContextPath() + "/resources/img/logo_noFlower.png'style='width: 17%; margin-bottom: 20px; padding-left:20px;'/>"+
											 "<h4 style='color: #1d2c52; font-weight: 600;'>차단한 사람이 없으시네요!</h4></div>");
			}else{
				var source = $("#block-template").html();
				var template = Handlebars.compile(source);
				var data = {
					block : result,
				}	
				console.log(data);
				var html = template(data);
				$("#follow_list").append(html);
				
				pageNum++;
			}
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}


// 팔로우,차단 눌렀을때 처리
function FBProc(target_id, url, type) {
	// 대상 아이디, 이동할 주소, follow인지 block인지
	var mem_id = $("#mem_id").val();
	
	var data;
	var reverse_type;
	
	if(type == 'follow'){
		data = JSON.stringify({
			follower_id : mem_id,
			following_id : target_id
		})
		reverse_type = 'block';
	}else if(type == 'block'){
		data = JSON.stringify({
			blocker_id : mem_id,
			blocking_id : target_id
		})
		reverse_type = 'follow';
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		data : data,
		url : url,
		success : function(result) {
			if(result == -1){ // 차단 된 상태일때.
				alert("차단된 상대입니다.\n팔로우 할 수 없습니다.")
			}
			else if (result == 1) { // 잘 처리 되었을때
				// alert("성공!");
				console.log("처리 성공 - ajax")
				$('.'+ type + 'btn_'+ target_id).filter('.' + type + 'Btn').addClass(
				'fbhide');
				$('.'+ type + 'btn_'+ target_id).filter('.' + type + 'ingBtn').removeClass(
				'fbhide');
				
				// 함수가 존재할때 호출한다.
				if(typeof galleryBtnExtends == 'function')
					galleryBtnExtends(target_id, type, 1);
				if(typeof searchBtnExtends == 'function')
					searchBtnExtends(target_id, type, 1);
				
			} else { // 처리 안되었을때
				console.log("처리 실패! 이미 처리 되어있음.")
			}

		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}

	});
}

//언팔로우,차단 해제 눌렀을때 처리
function UnFBProc(target_id, url, type) {
	// 대상 아이디, 이동할 주소, follow인지 block인지
	var mem_id = $("#mem_id").val();
	
	var data;
	
	if(type == 'follow'){
		data = JSON.stringify({
			follower_id : mem_id,
			following_id : target_id
		})
	}else if(type == 'block'){
		data = JSON.stringify({
			blocker_id : mem_id,
			blocking_id : target_id
		})
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		data : data,
		url : url,
		success : function(result) {
			if (result == 1) { // 언팔로우or차단 해제 되었을때
				// alert("성공!");
				console.log("처리 성공 - ajax")
				$('.'+ type + 'btn_'+ target_id).filter('.' + type + 'Btn').removeClass(
				'fbhide');
				$('.'+ type + 'btn_'+ target_id).filter('.' + type + 'ingBtn').addClass(
				'fbhide');
				
				if(typeof searchBtnExtends == 'function')
					searchBtnExtends(target_id, type, 0);
				
			} else { // 언팔로우or차단 해제 안되었을때
				console.log("처리 실패! 이미 처리 되어있음.")
			}

		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}

	});
}


// 팔로우 추천 목록 얻어오기.
function getSuggestionFollowList(my_id){
	
	$("#small_recommend_list").children().detach();
	if(my_id != ""){
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			// dataType: "json",
			data : my_id,
			url : "/TeamPro/SuggestionFollow",
			success : function(result) {
				console.log(result);
				if(result.length > 0){
					var source = $("#s_recom_follow-template").html();
					var template = Handlebars.compile(source);
					var data = {
						s_r_list : result,
						my_id,
					}
					
					var html = template(data);
					$("#small_recommend_list").append(html);
					/*
					$.each(result, function(i){
						isFollowed(my_id , result[i].following_id);
					})*/
				}else{
					$("#small_recommend_list").append("<div align='center'><h5 style='color: #1d2c52; font-weight: 600;'>더 이상 추천할 회원이 없습니다.</h5></div>");
				}
			}
		})
	}	
}

// 스크롤 할때 처리
$('body').scroll(function() {
	
    if ($('body').scrollTop() == $(document).height() - $(window).height()) {
    	isDetach = false;
    	
    	// 로그인된 아이디 (main.jsp에 hidden값)
    	var my_id = $("#mem_id").val();
    	
    	// 현재 봐야하는 페이지의 아이디
    	var page_id = $("#page_id").val();
    	//console.log(my_id + " " + page_id);
    	
    	// follower 페이지인지 following 페이지 인지.
    	var page_type = $("#page_type").val();

    	// follow 페이지에서 호출했을때.
    	if(page_id != null && page_type != "blocking"){
    		getFollowList(my_id, page_id, page_type);
    	}else if(page_id != null && page_type == "blocking"){
    		getBlockingList(my_id);
    	}
    	
    }
});

// 버튼 클릭 이벤트 ~~
function FBBtnClickEvent(){
	// 팔로워 버튼 메뉴 클릭 이벤트
	$(document).on("click", "#getfollower_Btn" , function(){
		
		var id = $("#page_id").val()
		url = getContextPath() + "/" + id + "/follower/";
		location.href = url;
		
	});
	
	// 팔로잉 버튼 메뉴 클릭이벤트.
	$(document).on("click", "#getfollowing_Btn" , function(){
		
		var id = $("#page_id").val()
		url = getContextPath() + "/" + id + "/following/";
		location.href = url;
		
	});
	
	// 차단 목록 버튼 클릭이벤트.
	$(document).on("click", "#getblocking_Btn" , function(){
		
		var id = $("#page_id").val()
		url = getContextPath() + "/" + id + "/blocking/";
		location.href = url;
		
	});
	
	
	$(document).on("click", ".followBtn" , function(){
		var following_id = $(this).val();
		FBProc(following_id, "/TeamPro/follow", "follow");
	});
	
	$(document).on("click", ".followingBtn" , function(){
		var following_id = $(this).val();
		UnFBProc(following_id, "/TeamPro/unfollow", "follow");
	});
	
	
	$(document).on("click", ".blockBtn" , function(){
		var txt;
		var r = confirm("정말 차단 하시겠습니까? \n대상의 글이 더이상 보이지 않게 됩니다.");
		if (r == true) {
			var blocking_id = $(this).val();
			FBProc(blocking_id, "/TeamPro/block", "block");
		} else {
			
		}
		
		
	});
	
	$(document).on("click", ".blockingBtn" , function(){
		var blocking_id = $(this).val();
		UnFBProc(blocking_id, "/TeamPro/unblock", "block")
		
	});

}

$(document).ready(function(){
	FBBtnClickEvent();
	
	// 로그인된 아이디 (main.jsp에 hidden값)
	var my_id = $("#mem_id").val();
	
	// 현재 봐야하는 페이지의 아이디
	var page_id = $("#page_id").val();
	//console.log(my_id + " " + page_id);
	
	// follower 페이지인지 following 페이지 인지.
	var page_type = $("#page_type").val();
	
	// follow 페이지에서 호출했을때.
	if(page_id != null && page_type != "blocking"){
		getFollowList(my_id, page_id, page_type);
	}else if(page_id != null && page_type == "blocking"){
		getBlockingList(my_id);
	}
	// 로그인 되어있지않으면 팔로우 추천목록을 호출하지 않음.
	if(my_id != null){
		//$("#small_recommend_list").children().detach();
		getSuggestionFollowList(my_id);
	}
	
	
	
	
})
