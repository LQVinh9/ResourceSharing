package dao;

import dto.ItemHistory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import org.apache.log4j.Logger;
import util.DBAmazon;
import util.DBUtil;

public class HistoryDao {

    private static final Logger LOGGER = Logger.getLogger(HistoryDao.class);

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

    public Vector<ItemHistory> getAllItemHistory(String userID) throws SQLException, Exception {

        Vector<ItemHistory> listItemHistory = new Vector<ItemHistory>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "WHERE status='True' AND BookingDetail.bookingID IN ("
                        + "SELECT bookingID FROM Booking "
                        + "WHERE userID = ?) "
                        + "ORDER BY Booking.date DESC";

                ps = con.prepareStatement(sql);
                ps.setString(1, userID);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemHistory.add(new ItemHistory(rs.getString("bookingDetailID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19)));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemHistory;
    }

    public boolean deleteHistory(String bookingDetailID) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "UPDATE BookingDetail SET status = 'False' WHERE bookingDetailID = ?";
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

    public Vector<ItemHistory> getAllItemHistoryByDate(String dateBorrowFrom, String dateBorrowTo, String userID) throws SQLException, Exception {

        Vector<ItemHistory> listItemHistory = new Vector<ItemHistory>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "WHERE status='True' AND dateBorrow >= ? AND dateBorrow <= ? AND BookingDetail.bookingID IN ("
                        + "SELECT bookingID FROM Booking "
                        + "WHERE userID = ?) "
                        + "ORDER BY Booking.date DESC";

                ps = con.prepareStatement(sql);
                ps.setString(1, dateBorrowFrom);
                ps.setString(2, dateBorrowTo);
                ps.setString(3, userID);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemHistory.add(new ItemHistory(rs.getString("bookingDetailID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19)));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemHistory;
    }

    public Vector<ItemHistory> getAllItemHistoryByName(String itemName, String userID) throws SQLException, Exception {

        Vector<ItemHistory> listItemHistory = new Vector<ItemHistory>();

        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT bookingDetailID,itemName,color,image,BookingDetail.quantity,dateBorrow,statusRequest,Booking.date FROM BookingDetail "
                        + "INNER JOIN Item ON Item.itemID=BookingDetail.itemID "
                        + "INNER JOIN Booking ON Booking.bookingID=BookingDetail.bookingID "
                        + "WHERE status='True' AND itemName like ? AND BookingDetail.bookingID IN ("
                        + "SELECT bookingID FROM Booking "
                        + "WHERE userID = ?) "
                        + "ORDER BY Booking.date DESC";

                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + itemName + "%");
                ps.setString(2, userID);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItemHistory.add(new ItemHistory(rs.getString("bookingDetailID"), rs.getString("itemName"), rs.getString("color"), rs.getString("image"),
                            rs.getInt("quantity"), rs.getString("dateBorrow"), rs.getString("statusRequest"), rs.getString("date").substring(0, 19)));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItemHistory;
    }
}
