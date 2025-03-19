package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DatabaseUtil;

public class LikeyDAO {

  public int like(LikeyDTO likeyDTO){

    String query =
        " INSERT INTO likeys VALUES (?, ?, ?) ";
    Connection conn = null;
    PreparedStatement pStmt = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setInt(1, likeyDTO.getEvaluationNo());
      pStmt.setString(2, likeyDTO.getUserId());
      pStmt.setString(3, likeyDTO.getUserIp());
      return pStmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
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
    return -1; // 추천 중복 오류
  
  }
  
}
