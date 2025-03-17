<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.StringUtils"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%
UserDAO userDAO = new UserDAO();
String userId = null;

if (session.getAttribute("userId") != null) {
  userId = (String) session.getAttribute("userId");
}

if (StringUtils.isEmpty(userId)) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('로그인이 필요합니다.')");
  script.println("location.href = 'userLogin.jsp'");
  script.println("</script>");
  script.close();
  return;
}

boolean emailChecked = userDAO.getUserEmailChecked(userId);

if (emailChecked == true) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('이미 인증한 회원입니다.')");
  script.println("location.href='index.jsp'");
  script.println("</script>");
  script.close();
  return;
}

String host = "http://localhost:9192/LectureEvaluation/";
String from = System.getProperty("smtp.username");
String to = userDAO.getUserEmail(userId);
String subject = "강의 평가를 위한 이메일 인증 메일입니다.";
String content = " 다음 링크에 접속하여 이메일 인증을 진행하세요.<br>'" + "<a href='" + host
    + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일인증하기</a> ";

Properties p = new Properties();
p.put("mail.smtp.user", from);
p.put("mail.smtp.host", "smtp.googlemail.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.ssl.protocols", "TLSv1.2");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

try {
  Authenticator auth = new Gmail();
  Session ses = Session.getInstance(p, auth);
  ses.setDebug(true);
  MimeMessage msg = new MimeMessage(ses);
  msg.setSubject(subject);
  Address fromAddr = new InternetAddress(from);
  msg.setFrom(fromAddr);
  Address toAddr = new InternetAddress(to);
  msg.addRecipient(Message.RecipientType.TO, toAddr);
  msg.setContent(content, "text/html;charset=UTF8");
  Transport.send(msg);

} catch (Exception e) {
  e.printStackTrace();
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('오류가 발생했습니다.')");
  script.println("history.back();");
  script.println("</script>");
  script.close();
  return;
}
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
    <link rel="stylesheet" href="assets/css/sweetalert2.min.css" />
    <title>강의평가 웹 사이트</title>
  </head>
  <body>
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link active" href="index.jsp">메인</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
              <div class="dropdown-menu" aria-labelledby="dropdown">
<%
if (userId == null) {
%>
                <a class="dropdown-item" href="userLogin.jsp">로그인</a>
                <a class="dropdown-item" href="userJoin.jsp">회원가입</a>

<%
} else {
%>
               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
}
%>
              </div>
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search" />
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
          </form>
        </div>
      </nav>
    </div>

    
    <section class="container mt-3" style="max-width: 560px">
      <div class="alert alert-success mt-4" role="alert">
        이메일 주소 인증메일이 전송되었습니다. <br>
        회원가입시 입력했던 이메일에 들어가셔서 인증해주세요.
      </div>
    </section>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #fff"> made by jy-hwang in 2025 </footer>

    <script src="assets/js/jquery-3.7.1.slim.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/sweetalert2.all.min.js"></script>
  </body>
</html>

