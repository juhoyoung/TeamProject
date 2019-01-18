<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<style type="text/css">
	.errMsg{
		font-size: 10pt; color: #2f29fc;
	}
	#checkBtn{
			  width: 120px;
		  max-width : 100%;
		  height: 40px;
		  border-radius: 5px;
		  background-color: #6494ff;
		  border: none;
		  padding: 2px;
		  color: white;
		  font-weight: 600;
	}
	#cancelBtn{
			   width: 120px;
		  max-width : 100%;
		  height: 40px;
		  border-radius: 5px;
		  background-color: #cbcbcd;
		  border: none;
		  padding: 2px;
		  color: white;
		  font-weight: 600;
	}
</style>
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
<script  src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.7/handlebars.min.js"></script>
<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/imglogin2.js"></script>
<script type="text/javascript">
</script>
<script type="text/javascript">
		$(document).ready(function() {
			$("#btnDelete").click(function() {
			if(confirm("정말 탈퇴하시겠습니까?")){
				document.member.action="${pageContext.request.contextPath}/delete.do";
				document.member.submit();
			}	
		});
	});
</script>
      <div class="w3-row-padding">
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
              <div align="center" class="mypage_area">
				<h4 style="font-weight: 600; color: #1d2c52;">회원정보 수정페이지</h4><br/>	
				<hr class="w3-clear" style="margin: 5px 0 20px;">	
					<form:form commandName="member"
								   method="post" 
								   action="${pageContext.request.contextPath}/mypageOk"
								   name="member"> 
						<table border="0" width="400" style="margin-left: 80px; color: #1d2c52;">
							<tr>
								<th>아이디</th>
								<td>
									<!-- id부분은 수정금지 읽기만 가능하게 readonly="true"로  -->
									<form:input path="ID" maxlength="20" readonly="true" class="mypage_input"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<form:errors path="ID" cssClass="errMsg"/> <!-- 유효성 체크에 실패하면 error메시지 출력 구문 -->
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<form:password path="PWD" maxlength="20" class="mypage_input"/>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<form:errors path="PWD" cssClass="errMsg"/>
								</td>				
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<form:input path="NAME" maxlength="13" class="mypage_input"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<form:errors path="NAME" cssClass="errMsg"/>
								</td>				
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<form:input path="PHONE" maxlength="13" class="mypage_input"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<form:errors path="PHONE" cssClass="errMsg"/>
								</td>				
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<form:input path="EMAIL" maxlength="50" class="mypage_input"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<form:errors path="EMAIL" cssClass="errMsg"/>
								</td>				
							</tr>
							<tr>
								<th>프로필사진</th>
								<td  colspan="3" class="imgfile">
									<input type="file" class = "file">
									<ul class = "uploadedFileList" style="list-style: none;"></ul>
									<form:hidden path="PIC" id="PIC"/>
								</td>
							</tr>	
							</table>
							<div align="center" style="margin-right: 50px;">
								<input type="submit" id="checkBtn" value="수정"/>
								<input type="button" id="cancelBtn" value="취소" onclick="history.back();">
								<br/>
								<a href="#" id="btnDelete" style="margin-left: 50px;"><font style="font-size: 10pt; color: #78787c;">회원 탈퇴를 하고 싶습니다.</font></a>
								<br/>
							</div>
						</form:form>
				</div>
			</div>
          </div>
        </div>
      </div>