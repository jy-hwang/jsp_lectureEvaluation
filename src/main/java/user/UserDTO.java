package user;

public class UserDTO {

  private int userNo;

  private String userId;

  private String userPassword;

  private String userName;

  private String userEmail;

  private String userEmailHash;

  private boolean userEmailChecked;

  private String createdDate;

  private String updatedDate;

  public int getUserNo() {
    return userNo;
  }

  public void setUserNo(int userNo) {
    this.userNo = userNo;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getUserPassword() {
    return userPassword;
  }

  public void setUserPassword(String userPassword) {
    this.userPassword = userPassword;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getUserEmail() {
    return userEmail;
  }

  public void setUserEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  public String getUserEmailHash() {
    return userEmailHash;
  }

  public void setUserEmailHash(String userEmailHash) {
    this.userEmailHash = userEmailHash;
  }

  public boolean isUserEmailChecked() {
    return userEmailChecked;
  }

  public void setUserEmailChecked(boolean userEmailChecked) {
    this.userEmailChecked = userEmailChecked;
  }

  public String getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(String createdDate) {
    this.createdDate = createdDate;
  }

  public String getUpdatedDate() {
    return updatedDate;
  }

  public void setUpdatedDate(String updatedDate) {
    this.updatedDate = updatedDate;
  }

  public UserDTO() {

  }

  public UserDTO(String userId, String userPassword, String userEmail, String userEmailHash) {
    this.userId = userId;
    this.userPassword = userPassword;
    this.userEmail = userEmail;
    this.userEmailHash = userEmailHash;
  }


}
