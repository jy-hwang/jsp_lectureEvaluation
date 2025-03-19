<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="util.StringUtils"%>
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

request.setCharacterEncoding("UTF-8");
int evaluationNo = 0;
if(request.getParameter("evaluationNo") != null){
 evaluationNo = Integer.parseInt(request.getParameter("evaluationNo")) ;
}

EvaluationDAO evaluationDAO = new EvaluationDAO();
if(userId.equals(evaluationDAO.getUserId(evaluationNo))){
  int result = evaluationDAO.delete(evaluationNo);
  if(result == 1){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('삭제가 완료되었습니다.')");
    script.println("location.href = 'index.jsp'");
    script.println("</script>");
    script.close();
    
  } else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('데이터베이스 오류가 발생했습니다.')");
    script.println("history.back()");
    script.println("</script>");
    script.close();
    
  }
} else {
  
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('강의평가 작성자만 삭제할 수 있습니다.')");
  script.println("history.back()");
  script.println("</script>");
  script.close(); 
  
}

%>
