package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {

  public int login(String userId, String userPassword) {

    String query = " SELECT user_password AS userPassword FROM users WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userId);
      rSet = pStmt.executeQuery();

      if (rSet.next()) {
        if (rSet.getString(1).equals(userPassword)) {
          return 1; // 로그인 성공
        } else {
          return 0; // 비밀번호 틀림
        }
      }
      return -1; // 아이디 없음.
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
    return -2;// DB 오류
  }

  public int join(UserDTO userDTO) {

    String query =
        " INSERT INTO users (user_id, user_password, user_email, user_email_hash) VALUES (?, ?, ?, ?) ";
    Connection conn = null;
    PreparedStatement pStmt = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userDTO.getUserId());
      pStmt.setString(2, userDTO.getUserPassword());
      pStmt.setString(3, userDTO.getUserEmail());
      pStmt.setString(4, userDTO.getUserEmailHash());
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
    return -1; // 회원가입 실패
  }

  public int dupCheckUserId(String userId) {

    String query = " SELECT user_id AS userId FROM users WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userId);
      rSet = pStmt.executeQuery();

      if (rSet.next()) {
        return 1; // 중복
      } else {
        return 0;
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
    return -1;// DB 오류
  }

  public boolean getUserEmailChecked(String userId) {

    String query = " SELECT user_email_checked AS userEmailChecked FROM users WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userId);
      rSet = pStmt.executeQuery();

      if (rSet.next()) {
        return rSet.getBoolean(1);
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
    return false;// DB 오류
  }

  public String getUserEmail(String userId) {

    String query = " SELECT user_email AS userEmail FROM users WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userId);
      rSet = pStmt.executeQuery();

      if (rSet.next()) {
        return rSet.getString(1);
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
    return null;// DB 오류
  }

  public boolean setUserEmailChecked(String userId) {

    String query = " UPDATE users SET user_email_checked = 1 WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;

    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1, userId);
      pStmt.executeUpdate();

      return true;
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
    return false;// DB 오류
  }

}
