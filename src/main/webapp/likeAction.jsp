<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="util.StringUtils"%>
<%@ page import="java.io.PrintWriter"%>
<%!
public static String getClientIp(HttpServletRequest request){
  String ip =  request.getHeader("X-FORWAREDED-FOR");
  
  if (ip == null || ip.length() == 0){
    ip = request.getHeader("Proxy-Client-IP");
  }
  
  if (ip == null || ip.length() == 0){
    ip = request.getHeader("WL-proxy-Client-IP");
  }
  
  if (ip == null || ip.length() == 0){
    ip = request.getRemoteAddr();
  }
  
   return ip;
}

%>
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
LikeyDAO likeyDAO = new LikeyDAO();
LikeyDTO likeyDTO = new LikeyDTO();
likeyDTO.setEvaluationNo(evaluationNo);
likeyDTO.setUserId(userId);
likeyDTO.setUserIp(getClientIp(request));

int result = likeyDAO.like(likeyDTO);

if(result == 1){
  result = evaluationDAO.like(evaluationNo);
  if(result == 1){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('추천이 완료되었습니다.')");
    script.println("location.href = 'index.jsp'");
    script.println("</script>");
    script.close();
    return;
  } else {
    
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('데이터베이스 오류가 발생했습니다.')");
  script.println("location.href = 'index.jsp'");
  script.println("</script>");
  script.close();
  }
} else {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('이미 추천을 누른 상태입니다.')");
  script.println("history.back(0)");
  script.println("</script>");
  script.close();
  
}

%>
