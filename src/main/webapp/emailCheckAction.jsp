<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.StringUtils" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
String code = "";

if (request.getParameter("code") != null) {
  code = request.getParameter("code");
}

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

String userEmail = userDAO.getUserEmail(userId);
boolean isRight = (SHA256.getSHA256(userEmail).equals(code)) ? true : false;

if (isRight == true) {
  userDAO.setUserEmailChecked(userId);
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('인증에 성공했습니다.')");
  script.println("location.href='index.jsp';");
  script.println("</script>");
  script.close();
  return;

} else {
  session.setAttribute("userId", userId);
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('유효하지 않은 코드 입니다.')");
  script.println("location.href = 'index.jsp'");
  script.println("</script>");
  script.close();
  return;
}
%>