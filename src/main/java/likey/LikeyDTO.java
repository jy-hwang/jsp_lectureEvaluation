package likey;

public class LikeyDTO {

  private String userId;
  
  private int evaluationNo;
  
  private String userIp;

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public int getEvaluationNo() {
    return evaluationNo;
  }

  public void setEvaluationNo(int evaluationNo) {
    this.evaluationNo = evaluationNo;
  }

  public String getUserIp() {
    return userIp;
  }

  public void setUserIp(String userIp) {
    this.userIp = userIp;
  }

  public LikeyDTO(){}
  
  public LikeyDTO(String userId, int evaluationNo, String userIp) {
    this.userId = userId;
    this.evaluationNo = evaluationNo;
    this.userIp = userIp;
  }
  
  
}
