package dao;

import dto.Booking;
import dto.BookingDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import util.DBAmazon;
import util.DBUtil;

public class BookingDao {

    private static final Logger LOGGER = Logger.getLogger(BookingDao.class);

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

    public boolean createBooking(Booking booking) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Insert Booking Values(?,?,?)";

                ps = con.prepareStatement(sql);
                ps.setString(1, booking.getBookingID());
                ps.setString(2, booking.getDate());
                ps.setString(3, booking.getUserID());

                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, booking.getBookingID());
//                ps.setString(2, booking.getDate());
//                ps.setString(3, booking.getUserID());
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

    public boolean createBookingDetail(BookingDetail bookingDetail) throws SQLException, Exception {
        boolean check = false;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Insert BookingDetail Values(?,?,?,?,?,?,?)";

                ps = con.prepareStatement(sql);
                ps.setString(1, bookingDetail.getBookingDetailID());
                ps.setInt(2, bookingDetail.getQuantity());
                ps.setString(3, bookingDetail.getDateBorrow());
                ps.setString(4, bookingDetail.getStatusRequest());
                ps.setString(5, bookingDetail.getStatus());
                ps.setString(6, bookingDetail.getItemID());
                ps.setString(7, bookingDetail.getBookingID());

                check = ps.executeUpdate() > 0;
                
//                conAmazon = DBAmazon.getConnnectionAmazon();
//                
//                ps = conAmazon.prepareStatement(sql);
//                ps.setString(1, bookingDetail.getBookingDetailID());
//                ps.setInt(2, bookingDetail.getQuantity());
//                ps.setString(3, bookingDetail.getDateBorrow());
//                ps.setString(4, bookingDetail.getStatusRequest());
//                ps.setString(5, bookingDetail.getStatus());
//                ps.setString(6, bookingDetail.getItemID());
//                ps.setString(7, bookingDetail.getBookingID());
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

    public int getQuantityItemAccepted(String itemID, String date) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "SELECT SUM(quantity) FROM BookingDetail WHERE itemID=? AND statusRequest='Accept' AND dateBorrow=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, itemID);
                ps.setString(2, date);

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

    public Booking getBookingByID(String bookingID) throws SQLException, Exception {
        Booking booking = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select bookingID, date, userID "
                        + "From Booking Where bookingID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, bookingID);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String id = rs.getString("bookingID");
                    String date = rs.getString("date");
                    String userID = rs.getString("userID");

                    booking = new Booking(id, date, userID);
                }
            }
        } finally {
            closeConnection();
        }
        return booking;
    }

    public BookingDetail getBookingDetailByID(String bookingDetailID) throws SQLException, Exception {
        BookingDetail bookingDetail = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select bookingDetailID, quantity, dateBorrow, statusRequest, status, itemID, bookingID "
                        + "From BookingDetail Where bookingDetailID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, bookingDetailID);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String id = rs.getString("bookingDetailID");
                    int quantity = rs.getInt("quantity");
                    String dateBorrow = rs.getString("dateBorrow");
                    String statusRequest = rs.getString("statusRequest");
                    String status = rs.getString("status");
                    String itemID = rs.getString("itemID");
                    String bookingID = rs.getString("bookingID");

                    bookingDetail = new BookingDetail(bookingDetailID, quantity, dateBorrow, statusRequest, status, itemID, bookingID);
                }
            }
        } finally {
            closeConnection();
        }
        return bookingDetail;
    }
}
