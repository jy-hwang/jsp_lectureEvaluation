package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class EvaluationDAO {

  public int write(EvaluationDTO evaluationDTO) {

    String query =
        " INSERT INTO evaluations (user_id, lecture_name, professor_name, lecture_year, semester_divide, lecture_divide "
            + " , evaluation_title, evaluation_content, total_score, credit_score, comfortable_score, lecture_score) "
            + " VALUES (?, ?, ?, ?, ?, ? "
            + " , ?, ?, ?, ?, ?, ?); ";
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
}
