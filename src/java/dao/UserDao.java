package dao;

import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import util.DBAmazon;
import util.DBUtil;

public class UserDao {

    private static final Logger LOGGER = Logger.getLogger(UserDao.class);

    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private Connection conAmazon = null;
    
//    private void closeConnectionDBAmazon() throws Exception {
//        if (conAmazon != null) {
//            conAmazon.close();
//        }
//    }

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public User checkLogin(String userID, String password) throws Exception {
        User user = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select userID,name,Users.roleID,roleName From Users \n"
                        + "INNER JOIN Role ON Users.roleID=Role.roleID \n"
                        + "Where userID=? AND password=? AND status='Active'";
                ps = con.prepareStatement(sql);
                ps.setString(1, userID);
                ps.setString(2, password);

                rs = ps.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("userID");
                    String name = rs.getString("name");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    user = new User(email, name, roleID, roleName);
                }
            }
        } finally {
            closeConnection();
        }
        return user;
    }

    public User checkLoginAccountNotActivated(String userID, String password) throws Exception {
        User user = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select userID,name,Users.roleID,roleName From Users \n"
                        + "INNER JOIN Role ON Users.roleID=Role.roleID \n"
                        + "Where userID=? AND password=? AND status='New'";
                ps = con.prepareStatement(sql);
                ps.setString(1, userID);
                ps.setString(2, password);

                rs = ps.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("userID");
                    String name = rs.getString("name");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    user = new User(email, name, roleID, roleName);
                }
            }
        } finally {
            closeConnection();
        }
        return user;
    }

    public User checkLoginGoogle(String email) throws Exception {
        User user = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select userID,name,Users.roleID,roleName From Users \n"
                        + "INNER JOIN Role ON Users.roleID=Role.roleID \n"
                        + "Where userID=? AND status='Active'";
                ps = con.prepareStatement(sql);
                ps.setString(1, email);

                rs = ps.executeQuery();
                if (rs.next()) {
                    String userID = rs.getString("userID");
                    String name = rs.getString("name");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    user = new User(userID, name, roleID, roleName);
                }
            }
        } finally {
            closeConnection();
        }
        return user;
    }

    public boolean createUser(User user) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Insert Users Values(?,?,?,?,?,?,?,?,?)";

                ps = con.prepareStatement(sql);
                ps.setString(1, user.getUserID());
                ps.setString(2, user.getName());
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getPhone());
                ps.setString(5, user.getAddress());
                ps.setString(6, user.getCreateDate());
                ps.setString(7, user.getCodeRegister());
                ps.setString(8, user.getStatus());
                ps.setString(9, user.getRoleID());
                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, user.getUserID());
//                ps.setString(2, user.getName());
//                ps.setString(3, user.getPassword());
//                ps.setString(4, user.getPhone());
//                ps.setString(5, user.getAddress());
//                ps.setString(6, user.getCreateDate());
//                ps.setString(7, user.getCodeRegister());
//                ps.setString(8, user.getStatus());
//                ps.setString(9, user.getRoleID());
//                ps.executeUpdate();
            }
        } catch (Exception e) {
            LOGGER.error(e);
            return check;
        } finally {
            closeConnection();
            //closeConnectionDBAmazon();
        }
        return check;
    }

    public boolean updateUser(User user) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "UPDATE Users SET status=? WHERE userID=? AND codeRegister=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, user.getStatus());
                ps.setString(2, user.getUserID());
                ps.setString(3, user.getCodeRegister());
                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, user.getStatus());
//                ps.setString(2, user.getUserID());
//                ps.setString(3, user.getCodeRegister());
//                ps.executeUpdate();
            }
        } catch (Exception e) {
            LOGGER.error(e);
            return check;
        } finally {
            closeConnection();
            //closeConnectionDBAmazon();
        }
        return true;
    }

    public User getUserByID(String email) throws SQLException, Exception {
        User user = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select userID, name, password, phone, address, createDate, codeRegister, status, roleID "
                        + "From Users Where userID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String userID = rs.getString("userID");
                    String name = rs.getString("name");
                    String password = rs.getString("password");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String createDate = String.valueOf(rs.getDate("createDate"));
                    String codeRegister = rs.getString("codeRegister");
                    String status = rs.getString("status");
                    String roleID = rs.getString("roleID");

                    user = new User(userID, name, password, phone, address, createDate, codeRegister, status, roleID);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return user;
    }
}
