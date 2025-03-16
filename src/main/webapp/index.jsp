<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
    <title>강의평가 웹 사이트</title>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="jsp/index.jsp">강의평가 웹 사이트</a>
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
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search" />
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
    </nav>
    <section class="container">
      <form method="get" action="./index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="">전체</option>
          <option value="M">전공</option>
          <option value="L">교양</option>
          <option value="E">기타</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요" />
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
      </form>
      
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">컴퓨터개론&nbsp;<small>나동빈</small></div>
            <div class="col-4 text-right">종합<span style="color: red">A</span></div>
          </div>
        </div>
        <div class="card-body bg-light">
          <h5 class="card-title">정말 좋은 강의에요. &nbsp;<small>(2024년 2학기)</small></h5>
          <p class="card-text"
            >강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만, 학점도 잘 나오고, 너무 좋은 것 같습니다.</p
          >
          <div class="row">
            <div class="col-9 text-left">
              성적<span style="color: red">A</span>
              널널<span style="color: red">A</span>
              강의<span style="color: red">A</span>
              <span style="color: green">(추천: 15)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationNo=">추천</a>
              <span>|</span>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationNo=">삭제</a>
            </div>
          </div>
        </div>
      </div>
      
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">컴퓨터그래픽스&nbsp;<small>홍길동</small></div>
            <div class="col-4 text-right">종합<span style="color: red">B</span></div>
          </div>
        </div>
        <div class="card-body bg-light">
          <h5 class="card-title">나쁘지 않은 것 같습니다. &nbsp;<small>(2022년 1학기)</small></h5>
          <p class="card-text"
            >강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만, 학점도 잘 나오고, 너무 좋은 것 같습니다.</p
          >
          <div class="row">
            <div class="col-9 text-left">
              성적<span style="color: red">B</span>
              널널<span style="color: red">C</span>
              강의<span style="color: red">B</span>
              <span style="color: green">(추천: 10)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationNo=">추천</a>
              <span>|</span>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationNo=">삭제</a>
            </div>
          </div>
        </div>
      </div>
      
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">알고리즘&nbsp;<small>이순신</small></div>
            <div class="col-4 text-right">종합<span style="color: red">A</span></div>
          </div>
        </div>
        <div class="card-body bg-light">
          <h5 class="card-title">강의력이 가장 좋은 강의입니다. &nbsp;<small>(2023년 겨울학기)</small></h5>
          <p class="card-text"
            >알고리즘 강의를 가르치시는 교수님 중에서 가장 잘 가르치십니다.</p
          >
          <div class="row">
            <div class="col-9 text-left">
              성적<span style="color: red">B</span>
              널널<span style="color: red">C</span>
              강의<span style="color: red">A</span>
              <span style="color: green">(추천: 5)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationNo=">추천</a>
              <span>|</span>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationNo=">삭제</a>
            </div>
          </div>
        </div>
        <div class="card-body bg-light">
          <h5 class="card-title">전달력이 가장 좋은 강의입니다. &nbsp;<small>(2024년 겨울학기)</small></h5>
          <p class="card-text"
            >전달력이 정말 좋으십니다.</p
          >
          <div class="row">
            <div class="col-9 text-left">
              성적<span style="color: red">B</span>
              널널<span style="color: red">C</span>
              강의<span style="color: red">A</span>
              <span style="color: green">(추천: 3)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationNo=">추천</a>
              <span>|</span>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationNo=">삭제</a>
            </div>
          </div>
        </div>
      </div>
    </section>

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
                  <input type="text" name="lectureName" class="form-control" maxlength="20" />
                </div>
                <div class="form-group col-sm-6">
                  <label>교수명</label>
                  <input type="text" name="professorName" class="form-control" maxlength="20" />
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
                    <option value="spring">1학기</option>
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
                <input type="text" name="evaluationTitle" class="form-control" maxlength="30" />
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea
                  name="evaluationContent"
                  class="form-control"
                  maxlength="2048"
                  style="height: 180px"
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
                <input type="text" name="reportTitle" class="form-control" maxlength="30" />
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px"></textarea>
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
    <script src="assets/js/bootstrap.min.js"></script>
  </body>
</html>
