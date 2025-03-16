package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {

  public int login(String userId, String userPassword){
   
    String query = " SELECT user_password AS userPassword FROM users WHERE user_id = ? ";
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    try {
      conn = DatabaseUtil.getConnection();
      pStmt = conn.prepareStatement(query);
      pStmt.setString(1,  userId);
      rSet = pStmt.executeQuery();
      
      if(rSet.next()){
        if(rSet.getString(1).equals(userPassword)){
          return 1; // 로그인 성공
        } else {
          return 0; // 비밀번호 틀림
        }
      }
      return -1; // 아이디 없음.
    } catch (Exception e) {
      e.printStackTrace();
    }
    return -2;// DB 오류
  }
  
}
