package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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

  public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
    
    ArrayList<EvaluationDTO> evaluationList = null;
    String query = "";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      if(searchType.equals("LATEST")) {
        query = " SELECT user_id AS userId, lecture_name AS lectureName, professor_name AS professorName, lecture_year AS lectureYear, semester_divide AS semesterDivide "
            + " , lecture_divide AS lectureDivide, evaluation_title AS evaluationTitle, evaluation_content AS evaluationContent, total_score AS totalScore, credit_score AS creditScore "
            + " , comfortable_score AS comfortableScore, lecture_score AS lectureScore, like_count AS likeCount, created_date AS createdDate, updated_date AS updatedDate FROM evaluations ; "; 
      }
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);

      rSet = pStmt.executeQuery();

      if (rSet.next()) {
        
      }
      return null;
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
    return null;
    
  }
}
