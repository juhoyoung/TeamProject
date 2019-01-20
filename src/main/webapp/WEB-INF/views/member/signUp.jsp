<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    <!-- 스프링 프레임웍에서 제공해주는 form태그 사용을 위한 선언 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BabyParent | Sign Up</title>	
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signup.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet"> 
<!-- 핸들바 기능 -->
<script id ="imgLogin" type="text/x-handlebars-template">
	<li>
		<input type="hidden" name="PIC1" id="PIC1" value ="{{originalFileUrl}}">
		<div class = "mailbox-attachment-info">
			<a href ="{{originalFileUrl}}" class="mailbox-attachment-name">
				<img src="{{imgSrc}}" alt = "Attachment" class ="view">
			</a>
			<a href="{{fullName}}" class = "btn btn-default btn-xs pull-right delBtn">
				<i class="fa fa-fw fa-remove" style="font-size: 20px; color: #78787c;"></i>
			</a>
		</div>
	</li>
</script>

	<script type="text/javascript">
	 // 취소 버튼 클릭시 첫화면으로 이동
    function goFirstForm() {
        location.href="login";
    }
	</script>
	<!-- imgupload -->
	<script  src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.7/handlebars.min.js"></script>
	<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/imglogin.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	//아이디 중복체크
	    $('#ID').blur(function(){
	        $.ajax({
		     type:"POST",
		     url:"checkSignup",
		     data:{
		            "ID":$('#ID').val()
		     },
		     success:function(data){	//data : checkSignup에서 넘겨준 결과값
		            if($.trim(data)=="YES"){
		               if($('#ID').val()!=''){ 
		               	alert("사용가능한 아이디입니다.");
		               }
		           	}else{
		               if($('#ID').val()!=''){
		                  alert("중복된 아이디입니다.");
		                  $('#ID').val('');
		                  $('#ID').focus();
		               }
		            }
		         }
		    }) 
	     })

	});
	
$(function(){
	  $('#PWD').keyup(function(){
	   $('font[name=check]').text('');
	  }); //#user_pass.keyup

	  $('#chpass').keyup(function(){
	   if($('#PWD').val()!=$('#chpass').val()){
	    $('font[name=check]').text('');
	    $('font[name=check]').html("암호 불일치");
	   }else{
	    $('font[name=check]').text('');
	    $('font[name=check]').html("암호 일치");
	   }
	  }); //#chpass.keyup
	 });
</script>
</head>
<body class="main">
<!-- Header -->
	<jsp:include page="../layout/header.jsp"/>
<!-- END Header -->
	<div class="w3-col m3" id="signupArea" align="center">
      <!-- Profile -->
      	<div class="w3-card w3-round w3-white" style="width:550px; padding: 30px 0 30px 30px; color: #1d2c52;">
        	<div class="w3-container">
				<table id="signupTable">
					<form:form action="insertOk" method="post" commandName="member" >		
							<tbody style="width: 100%;">
								<tr>
									<th scope="row" >이름</th>
									<td>
										<form:input class="signupInput" path="NAME" maxlength="13"/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="3">
										<form:errors path="NAME" cssClass="msg"/>
									</td>
								</tr>
								<tr>
									<th scope="row">아이디</th>
									<td>
										<form:input class="signupInput" path="ID" maxlength="20" />
										<input type="button" value="중복확인" id="checkSignup" style="background-color: #6494ff; border-radius: 5px; border: none;
		  																							  padding: 3px 10px; color: white;font-weight: 600;">
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2">
										<form:errors path="ID" cssClass="msg"/>
									</td>	
								</tr>
								<tr>
									<th scope="row">비밀번호</th>
									<td>
										<form:password class="signupInput" path="PWD" maxlength="20"/>
									</td>
								</tr>
								<tr>
							    	<th scope="row">비밀번호 확인</th>
							    		<td>
							    			<input type="password" name="chpass" id="chpass" size="10" class="signupInput" style="width:165px; margin-top: 2px;"/>
							    			<font name="check" size="2" color="red"></font> 
							    		</td>
							    </tr>
								<tr>
									<td></td>
									<td colspan="2">
										<form:errors path="PWD" cssClass="msg"/>
									</td>
								</tr>
								<tr>
									<th scope="row">전화번호</th>
									<td>
										<form:input class="signupInput" path="PHONE" maxlength="12"/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2">
										<form:errors path="PHONE" cssClass="msg"/>
									</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td>
										<form:input class="signupInput" path="EMAIL" maxlength="50"/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2">
										<form:errors path="EMAIL" cssClass="msg"/>
									</td>
								</tr>
								<tr>
									<th scope="row">생년월일</th>
									<td>
										<form:input class="signupInput" path="BIRTH" maxlength="9"/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2">
										<form:errors path="BIRTH" cssClass="msg"/>
									</td>
								</tr>
								<tr>
									<th>프로필사진</th>
									<td colspan="3" class="imgfile">
										<input type="file" class = "file">		
										<ul class = "uploadedFileList" style="list-style: none;"></ul>
										<form:hidden path="PIC" id="PIC"/>
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3" align="center" style="margin-top: 10px;">
										<input type="submit" id="checkBtn" value="회원가입" style="width: 150px; max-width : 100%;height: 40px;border-radius: 5px;
		  																						background-color: #6494ff;border: none;padding: 2px;color: white;font-weight: 600;">
										<input type="button" id="cancelBtn" value="취소" style="width: 150px; max-width : 100%;height: 40px;border-radius: 5px;
		  																						background-color: #cbcbcd; border: none; padding: 2px;color: white; font-weight: 600;" onclick="goFirstForm()">
									</td>
								</tr>
							</tfoot>
					</form:form>
				</table>
		   	</div>
		</div>
	</div>	
</body>
</html>