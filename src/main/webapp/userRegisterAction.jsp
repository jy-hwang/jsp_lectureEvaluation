<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.StringUtils"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
String userId = null;
if (session.getAttribute("userId") != null) {
  userId = (String) session.getAttribute("userId");
}

if (userId != null) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('로그인이 된 상태입니다.');");
  script.println("location.href = 'index.jsp';");
  script.println("</script>");
  script.close();
}

String userPassword = "";
String userEmail = "";

if (request.getParameter("userId") != null) {
  userId = request.getParameter("userId");
}

if (request.getParameter("userPassword") != null) {
  userPassword = request.getParameter("userPassword");
}

if (request.getParameter("userEmail") != null) {
  userEmail = request.getParameter("userEmail");
}

if (StringUtils.isEmpty(userId) || StringUtils.isEmpty(userPassword)
    || StringUtils.isEmpty(userEmail)) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('입력이 안된 사항이 있습니다.')");
  script.println("history.back()");
  script.println("</script>");
  script.close();
}

UserDAO userDAO = new UserDAO();
int dupCheck = userDAO.dupCheckUserId(userId);

if (dupCheck == 1) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('이미 존재하는 ID 입니다.')");
  script.println("history.back();");
  script.println("</script>");
  script.close();
  return;
}

int result =
    userDAO.join(new UserDTO(userId, userPassword, userEmail, SHA256.getSHA256(userEmail)));

if (result == -1) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('서버 내부 오류가 발생했습니다.')");
  script.println("history.back();");
  script.println("</script>");
  script.close();
} else {
  session.setAttribute("userId", userId);
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("location.href = 'emailSendAction.jsp'");
  script.println("</script>");
  script.close();
}
%>
