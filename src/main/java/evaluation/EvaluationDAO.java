package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseUtil;

public class EvaluationDAO {

  public int write(EvaluationDTO evaluationDTO) {

    String query =
        " INSERT INTO evaluations (user_id, lecture_name, professor_name, lecture_year, semester_divide, lecture_divide "
            + " , evaluation_title, evaluation_content, total_score, credit_score, comfortable_score, lecture_score) "
            + " VALUES (?, ?, ?, ?, ?, ? " + " , ?, ?, ?, ?, ?, ?); ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, evaluationDTO.getUserId());
      pStmt.setString(2, evaluationDTO.getLectureName());
      pStmt.setString(3, evaluationDTO.getProfessorName());
      pStmt.setInt(4, evaluationDTO.getLectureYear());
      pStmt.setString(5, evaluationDTO.getSemesterDivide());
      pStmt.setString(6, evaluationDTO.getLectureDivide());
      pStmt.setString(7, evaluationDTO.getEvaluationTitle());
      pStmt.setString(8, evaluationDTO.getEvaluationContent());
      pStmt.setString(9, evaluationDTO.getTotalScore());
      pStmt.setString(10, evaluationDTO.getCreditScore());
      pStmt.setString(11, evaluationDTO.getComfortableScore());
      pStmt.setString(12, evaluationDTO.getLectureScore());
      return pStmt.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (rSet != null) {
          rSet.close();
        }
        if (pStmt != null) {
          pStmt.close();
        }
        if (conn != null) {
          conn.close();
        }
      } catch (Exception e2) {
        e2.printStackTrace();
      }
    }
    return -1;// DB 오류
  }

  public List<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
    
    List<EvaluationDTO> evaluationList = null;
    String query = "";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      if(searchType.equals("LATEST")) {
        query = " SELECT user_id AS userId, lecture_name AS lectureName, professor_name AS professorName, lecture_year AS lectureYear, semester_divide AS semesterDivide "
            + " , lecture_divide AS lectureDivide, evaluation_title AS evaluationTitle, evaluation_content AS evaluationContent, total_score AS totalScore, credit_score AS creditScore "
            + " , comfortable_score AS comfortableScore, lecture_score AS lectureScore, like_count AS likeCount, created_date AS createdDate, updated_date AS updatedDate FROM evaluations "
            + " WHERE lecture_divide LIKE ? AND CONCAT(lecture_name, professor_name, evaluation_title, evaluation_content) LIKE ? "
            + " ORDER BY evaluation_no DESC LIMIT " + pageNumber * 5 + " , " + pageNumber * 5 + 6 + ";";  
      } else if(searchType.equals("RECOMMEND")){
        query = " SELECT user_id AS userId, lecture_name AS lectureName, professor_name AS professorName, lecture_year AS lectureYear, semester_divide AS semesterDivide "
            + " , lecture_divide AS lectureDivide, evaluation_title AS evaluationTitle, evaluation_content AS evaluationContent, total_score AS totalScore, credit_score AS creditScore "
            + " , comfortable_score AS comfortableScore, lecture_score AS lectureScore, like_count AS likeCount, created_date AS createdDate, updated_date AS updatedDate FROM evaluations "
            + " WHERE lecture_divide LIKE ? AND CONCAT(lecture_name, professor_name, evaluation_title, evaluation_content) LIKE ? "
            + " ORDER BY like_count DESC LIMIT " + pageNumber * 5 + " , " + pageNumber * 5 + 6 + ";";  
      }
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, "%" + lectureDivide + "%");
      pStmt.setString(2, "%" + search + "%");
      rSet = pStmt.executeQuery();
      evaluationList = new ArrayList<EvaluationDTO>();
      while (rSet.next()) {
        EvaluationDTO evaluation = new EvaluationDTO();
        evaluation.setUserId(rSet.getString("userId"));
        evaluation.setLectureName(rSet.getString("lectureName"));
        evaluation.setProfessorName(rSet.getString("professorName"));
        evaluation.setLectureYear(rSet.getInt("lectureYear"));
        evaluation.setSemesterDivide(rSet.getString("semesterDivide"));
        evaluation.setLectureDivide(rSet.getString("lectureDivide"));
        evaluation.setEvaluationTitle(rSet.getString("evaluationTitle"));
        evaluation.setEvaluationContent(rSet.getString("evaluationContent"));
        evaluation.setTotalScore(rSet.getString("totalScore"));
        evaluation.setCreditScore(rSet.getString("creditScore"));
        evaluation.setComfortableScore(rSet.getString("comfortableScore"));
        evaluation.setLectureScore(rSet.getString("lectureScore"));
        evaluation.setLikeCount(rSet.getInt("likeCount"));
        evaluation.setCreatedDate(rSet.getString("createdDate"));
        evaluation.setUpdatedDate(rSet.getString("updatedDate"));
        evaluationList.add(evaluation);
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (rSet != null) {
          rSet.close();
        }
        if (pStmt != null) {
          pStmt.close();
        }
        if (conn != null) {
          conn.close();
        }
      } catch (Exception e2) {
        e2.printStackTrace();
      }
    }
    return evaluationList;
    
  }
}
