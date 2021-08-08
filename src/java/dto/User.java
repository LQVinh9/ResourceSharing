package dto;

public class User {

    private String userID;
    private String name;
    private String password;
    private String phone;
    private String address;
    private String createDate;
    private String codeRegister;
    private String status;
    private String roleID;
    private String roleName;

    public User() {
    }

    public User(String userID, String codeRegister, String status) {
        this.userID = userID;
        this.codeRegister = codeRegister;
        this.status = status;
    }

    public User(String userID, String name, String roleID, String roleName) {
        this.userID = userID;
        this.name = name;
        this.roleID = roleID;
        this.roleName = roleName;
    }

    public User(String userID, String name, String password, String phone, String address, String createDate, String codeRegister, String status, String roleID) {
        this.userID = userID;
        this.name = name;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.createDate = createDate;
        this.codeRegister = codeRegister;
        this.status = status;
        this.roleID = roleID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCodeRegister() {
        return codeRegister;
    }

    public void setCodeRegister(String codeRegister) {
        this.codeRegister = codeRegister;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
