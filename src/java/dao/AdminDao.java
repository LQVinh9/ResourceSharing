package dao;

import dto.ItemAdmin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import org.apache.log4j.Logger;
import util.DBAmazon;
import util.DBUtil;

public class AdminDao {

    private static final Logger LOGGER = Logger.getLogger(AdminDao.class);

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

    public Vector<ItemAdmin> getAllItemAdmin(int pageNumber, int itemOfPage, String statusRequest) throws SQLException, Exception {

        Vector<ItemAdmin> listItemAdmin = new Vector<ItemAdmin>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,Item.itemID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE statusRequest=? "
                        + "ORDER BY Booking.date DESC "
                        + "OFFSET (?-1)* ?  ROWS "
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, statusRequest);
                ps.setInt(2, pageNumber);
                ps.setInt(3, itemOfPage);
                ps.setInt(4, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemAdmin.add(new ItemAdmin(rs.getString("bookingDetailID"), rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19),
                            rs.getString("userID"), rs.getString("name"), rs.getString("roleName")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemAdmin;
    }

    public int getNumberOfPage(String statusRequest) throws SQLException, Exception {

        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT COUNT(*) FROM ("
                        + "SELECT bookingDetailID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE statusRequest=?) result";

                ps = con.prepareStatement(sql);
                ps.setString(1, statusRequest);
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return count;
    }

    public boolean updateStatusRequestDelete(String bookingDetailID) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "UPDATE BookingDetail SET statusRequest='Delete' WHERE bookingDetailID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, bookingDetailID);
                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, bookingDetailID);
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

    public boolean updateStatusRequestAccept(String bookingDetailID) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "UPDATE BookingDetail SET statusRequest='Accept' WHERE bookingDetailID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, bookingDetailID);
                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, bookingDetailID);
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

    public int getAmountItemAccepted(String itemID, String dateBorrow) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT SUM(quantity) FROM BookingDetail "
                        + "WHERE itemID=? AND statusRequest='Accept' AND dateBorrow=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, itemID);
                ps.setString(2, dateBorrow);
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return count;
    }

    public int getAmountItem(String itemID) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT quantity FROM Item WHERE itemID=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, itemID);
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return count;
    }

    public Vector<ItemAdmin> getAllItemAdminSearchDate(int pageNumber, int itemOfPage, String dateBorrowFrom, String dateBorrowTo) throws SQLException, Exception {

        Vector<ItemAdmin> listItemAdmin = new Vector<ItemAdmin>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,Item.itemID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE dateBorrow >= ? AND dateBorrow <= ? "
                        + "ORDER BY Booking.date DESC "
                        + "OFFSET (?-1)* ?  ROWS "
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, dateBorrowFrom);
                ps.setString(2, dateBorrowTo);
                ps.setInt(3, pageNumber);
                ps.setInt(4, itemOfPage);
                ps.setInt(5, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemAdmin.add(new ItemAdmin(rs.getString("bookingDetailID"), rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19),
                            rs.getString("userID"), rs.getString("name"), rs.getString("roleName")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemAdmin;
    }

    public int getNumberOfPageSearchDate(String dateBorrowFrom, String dateBorrowTo) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT COUNT(*) FROM ("
                        + "SELECT bookingDetailID,Item.itemID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE dateBorrow >= ? AND dateBorrow <= ?) result";

                ps = con.prepareStatement(sql);
                ps.setString(1, dateBorrowFrom);
                ps.setString(2, dateBorrowTo);
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return count;
    }

    public Vector<ItemAdmin> getAllItemAdminSearch(int pageNumber, int itemOfPage, String itemName) throws SQLException, Exception {

        Vector<ItemAdmin> listItemAdmin = new Vector<ItemAdmin>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,Item.itemID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE itemName like ? "
                        + "ORDER BY Booking.date DESC "
                        + "OFFSET (?-1)* ?  ROWS "
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + itemName + "%");
                ps.setInt(2, pageNumber);
                ps.setInt(3, itemOfPage);
                ps.setInt(4, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemAdmin.add(new ItemAdmin(rs.getString("bookingDetailID"), rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19),
                            rs.getString("userID"), rs.getString("name"), rs.getString("roleName")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemAdmin;
    }

    public int getNumberOfPageSearchAdmin(String itemName) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT COUNT(*) FROM ("
                        + "SELECT bookingDetailID,Item.itemID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date, Users.userID, Users.name, Role.roleName FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "INNER JOIN Users ON Users.userID=Booking.userID "
                        + "INNER JOIN Role ON Role.roleID=Users.roleID "
                        + "WHERE itemName like ?) result";

                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + itemName + "%");
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return count;
    }
}
