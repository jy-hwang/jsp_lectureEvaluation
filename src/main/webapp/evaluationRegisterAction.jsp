<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="util.StringUtils"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
String userId = null;
if (session.getAttribute("userId") != null) {
  userId = (String) session.getAttribute("userId");
}

if (userId == null) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('로그인이 필요합니다.');");
  script.println("location.href = 'userLogin.jsp';");
  script.println("</script>");
  script.close();
}

String lectureName = "";
String professorName = "";
int lectureYear = 0;
String semesterDivide = "";
String lectureDivide = "";
String evaluationTitle = "";
String evaluationContent = "";
String totalScore = "";
String creditScore = "";
String comfortableScore = "";
String lectureScore = "";

if (request.getParameter("lectureName") != null) {
  lectureName = request.getParameter("lectureName");
}

if (request.getParameter("professorName") != null) {
  professorName = request.getParameter("professorName");
}

if (request.getParameter("lectureYear") != null) {
  lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
}

if (request.getParameter("semesterDivide") != null) {
  semesterDivide = request.getParameter("semesterDivide");
}

if (request.getParameter("lectureDivide") != null) {
  lectureDivide = request.getParameter("lectureDivide");
}

if (request.getParameter("evaluationTitle") != null) {
  evaluationTitle = request.getParameter("evaluationTitle");
}

if (request.getParameter("evaluationContent") != null) {
  evaluationContent = request.getParameter("evaluationContent");
}

if (request.getParameter("totalScore") != null) {
  totalScore = request.getParameter("totalScore");
}

if (request.getParameter("creditScore") != null) {
  creditScore = request.getParameter("creditScore");
}

if (request.getParameter("comfortableScore") != null) {
  comfortableScore = request.getParameter("comfortableScore");
}

if (request.getParameter("lectureScore") != null) {
  lectureScore = request.getParameter("lectureScore");
}

if (StringUtils.isEmpty(userId) || StringUtils.isEmpty(lectureName)
    || StringUtils.isEmpty(professorName) || StringUtils.isEmpty(semesterDivide)
    || StringUtils.isEmpty(lectureDivide) || StringUtils.isEmpty(evaluationTitle)
    || StringUtils.isEmpty(evaluationContent) || StringUtils.isEmpty(totalScore)
    || StringUtils.isEmpty(creditScore) || StringUtils.isEmpty(comfortableScore)
    || StringUtils.isEmpty(lectureScore)) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('입력이 안된 사항이 있습니다.')");
  script.println("history.back()");
  script.println("</script>");
  script.close();
}


EvaluationDTO evaluationDTO = new EvaluationDTO();
evaluationDTO.setUserId(userId);
evaluationDTO.setLectureName(lectureName);
evaluationDTO.setProfessorName(professorName);
evaluationDTO.setLectureYear(lectureYear);
evaluationDTO.setLectureDivide(lectureDivide);
evaluationDTO.setSemesterDivide(semesterDivide);
evaluationDTO.setEvaluationTitle(evaluationTitle);
evaluationDTO.setEvaluationContent(evaluationContent);
evaluationDTO.setTotalScore(totalScore);
evaluationDTO.setCreditScore(creditScore);
evaluationDTO.setComfortableScore(comfortableScore);
evaluationDTO.setLectureScore(lectureScore);

EvaluationDAO evaluationDAO = new EvaluationDAO();
int result = evaluationDAO.write(evaluationDTO);

if (result == -1) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('강의 평가 등록 실패했습니다.')");
  script.println("history.back();");
  script.println("</script>");
  script.close();
} else {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('강의 평가 등록 성공했습니다.')");
  script.println("location.href = 'index.jsp'");
  script.println("</script>");
  script.close();
}
%>
