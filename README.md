

com.a.a.deal.*  - > com.team.board.deal.* 로 변경

com.minji.mysns.board.controller - > com.team.board.deal.Controller 로 변경

----------------------------------------------------------------------------
12/21
<최지원>
src/main/java : com.team.chat.*, com.team.login.*, com.team.message.*, com.team.main.Controller 추가
src/main/resources > mybatis : mybatis-config.xml 추가(Mapper 사용시 필요)
src>main>webapp : mainPage.jsp 삭제, loginPage.jsp 실행하면 login 후 loginPost > main으로 이동하는 시스템입니다.
				  로그인만 되게 한 거라, 유효성, 디자인 등 조금 이상한 것들이 있습니다.
				  디자인은 추후 수정할 예정입니다.
servlet-context.xml : interceptor 추가(login interceptor용)
pom.xml : spring-jdbc, spring-test, commons-dbcp 추가
root-context.xml : db 실행이 안되서 주석처리한 부분이 2군데 정도 있습니다. 확인해주세요.



