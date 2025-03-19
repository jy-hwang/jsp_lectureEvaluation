<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
    <link rel="stylesheet" href="assets/css/bootstrap-icons.css" />
    <title>강의평가 웹 사이트</title>
  </head>
  <body>
<%
request.setCharacterEncoding("UTF-8");
String lectureDivide = "";
String searchType = "LATEST";
String search = "";
int pageNumber = 0;
if(request.getParameter("lectureDivide") != null){
  lectureDivide = request.getParameter("lectureDivide");
}
if(request.getParameter("searchType") != null){
  searchType = request.getParameter("searchType");
}
if(request.getParameter("search") != null){
  search = request.getParameter("search");
}
if(request.getParameter("pageNumber") != null){
  try{
    pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
  } catch(Exception e){
    System.out.println("검색 페이지 오류");
  }
}

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

boolean emailChecked = new UserDAO().getUserEmailChecked(userId);
if (!emailChecked) {
  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('이메일 인증이 필요합니다.');");
  script.println("location.href = 'emailSendConfirm.jsp';");
  script.println("</script>");
  script.close();
}
%>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">메인</a>
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
        <form method="get" action="./index.jsp" class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" name="search" placeholder="내용을 입력하세요" aria-label="Search" />
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
    </nav>

    <section class="container">
      <form method="get" action="./index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="">전체</option>
          <option value="M" <% if(lectureDivide.equals("M")) out.println("selected"); %>>전공</option>
          <option value="L" <% if(lectureDivide.equals("L")) out.println("selected"); %>>교양</option>
          <option value="E" <% if(lectureDivide.equals("E")) out.println("selected"); %>>기타</option>
        </select>
        <select name="searchType" class="form-control mx-1 mt-2">
          <option value="LATEST">최신순</option>
          <option value="RECOMMEND" <% if("searchType".equals("RECOMMEND")) out.println("selected"); %>>추천순</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요" value="<%= search %>"/>
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
      </form>
<%
List<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
if(evaluationList != null){
  
 for(int i = 0; i < evaluationList.size(); i++){
   if(i == 5) break;
   EvaluationDTO evaluation = evaluationList.get(i);
 
%>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="row col-8 text-left">
            <div class="col-1">
<span class="badge badge-primary">
<%
switch (evaluation.getLectureDivide()){
  case "M": 
    out.println("전공");
    break;
    
  case "L": 
    out.println("교양");
    break;
    
   default : 
    out.println("기타");
    break;
}
%>
</span>
</div>
<div class="col-8">
<span><%= evaluation.getLectureName() %>&nbsp;</span>
</div>
<div class="col-3">
<small><%= evaluation.getProfessorName() %></small></div></div>
            <div class="col-4 text-right">종합<span style="color: red"> <%= evaluation.getTotalScore() %> </span></div>
          </div>
        </div>
        <div class="card-body bg-light">
          <div class="card-title d-flex justify-content-between">
            <div>
          <%= evaluation.getEvaluationTitle() %> &nbsp;<small>(<%=evaluation.getLectureYear() %>
<%
switch (evaluation.getSemesterDivide()){
  case "spring": 
    out.println("1학기");
    break;
    
  case "summer": 
    out.println("여름학기");
    break;
    
  case "autumn": 
    out.println("2학기");
    break;
    
   default : 
    out.println("겨울학기");
    break;
}
%>
             )</small>
            </div>
            <div><small><%= evaluation.getUpdatedDate() == null ? evaluation.getCreatedDate() : evaluation.getUpdatedDate() %></small></div>
          </div>
          <p class="card-text"
            ><%= evaluation.getEvaluationContent() %></p
          >
          <div class="row">
            <div class="col-10 text-left">
              성적<span style="color: red"> <%= evaluation.getCreditScore() %> </span>
              널널<span style="color: red"> <%= evaluation.getComfortableScore() %> </span>
              강의<span style="color: red"> <%= evaluation.getLectureScore() %> </span>
              
            </div>
            <div class="col-2">
              <div class="row justify-content-center">
<%
if(userId != null && !userId.equals(evaluation.getUserId())){
%>
                <div class="btn btn-light">
                  <a href="./likeAction.jsp?evaluationNo=<%= evaluation.getEvaluationNo() %>"><i class="bi bi-hand-thumbs-up"></i></a>
                  <span style="color: green">(추천 : <%= evaluation.getLikeCount() %>)</span>
                </div>
<%
} else if(userId != null && userId.equals(evaluation.getUserId())){
%>
                <button class="btn btn-light" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="bi bi-three-dots-vertical"></i>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <!-- <a class="dropdown-item" href="#">수정</a> -->
                  <a class="dropdown-item" href="./deleteAction.jsp?evaluationNo=<%= evaluation.getEvaluationNo() %>">삭제</a>
                </div>
<%
}
%>
              </div>
            </div>
          </div>
        </div>
      </div>
<%
 }
}
%>     
    </section>
    <ul class="pagination justify-content-center mt-3">
        <li class="page-item">

<%
if(pageNumber <= 0){
%>
<a class="page-link disabled">이전</a>        
        
<%
} else {
%>
<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
&searchType=<%= URLEncoder.encode(searchType,"UTF-8") %>
&search=<%= URLEncoder.encode(search,"UTF-8") %>
&pageNumber=<%= pageNumber - 1 %>
">이전</a>             
<%
} 
%>
        </li>
        <li>
<%
if(evaluationList.size() < 6){
%>
<a class="page-link disabled">다음</a>        
        
<%
} else {
%>
<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
&searchType=<%= URLEncoder.encode(searchType,"UTF-8") %>
&search=<%= URLEncoder.encode(search,"UTF-8") %>
&pageNumber=<%= pageNumber + 1 %>
">다음</a>             
<%
} 
%>        
        
        
        </li>
        
    </ul>

    <footer class="bg-dark mt-4 p-5 text-center" style="color:#fff">
    made by jy-hwang in 2025
    </footer>

    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="motal-title" id="modal">평가등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="./evaluationRegisterAction.jsp" method="post">
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>강의명</label>
                  <input type="text" name="lectureName" class="form-control" maxlength="20" required="required" />
                </div>
                <div class="form-group col-sm-6">
                  <label>교수명</label>
                  <input type="text" name="professorName" class="form-control" maxlength="20" required="required" />
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-4">
                  <label>수강연도</label>
                  <select name="lectureYear" class="form-control">
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024" selected>2024</option>
                    <option value="2025">2025</option>
                    <option value="2026">2026</option>
                    <option value="2027">2027</option>
                    <option value="2028">2028</option>
                  </select>
                </div>
                <div class="form-group col-sm-4">
                  <label>수강학기</label>
                  <select name="semesterDivide" class="form-control">
                    <option value="spring" selected>1학기</option>
                    <option value="summer">여름학기</option>
                    <option value="autumn">2학기</option>
                    <option value="winter">겨울학기</option>
                  </select>
                </div>
                <div class="form-group col-sm-4">
                  <label>강의구분</label>
                  <select name="lectureDivide" class="form-control">
                    <option value="M" selected>전공</option>
                    <option value="L">교양</option>
                    <option value="E">기타</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label>제목</label>
                <input type="text" name="evaluationTitle" class="form-control" maxlength="30" required="required"/>
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea
                  name="evaluationContent"
                  class="form-control"
                  maxlength="2048"
                  style="height: 180px"
                  required="required"
                ></textarea>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-3">
                  <label>종합</label>
                  <select name="totalScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>성적</label>
                  <select name="creditScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>널널</label>
                  <select name="comfortableScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>강의</label>
                  <select name="lectureScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="motal-title" id="modal">신고하기</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="./reportAction.jsp" method="post">
              <div class="form-group">
                <label>제목</label>
                <input type="text" name="reportTitle" class="form-control" maxlength="30" required="required"/>
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px" required="required"></textarea>
              </div>
              <div class="modal-footer">
                <button type="submit" class="btn btn-danger">신고하기</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script src="assets/js/jquery-3.7.1.slim.js"></script>
    <!-- <script src="assets/js/bootstrap.min.js"></script> -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
    
    </script>
  </body>
</html>
