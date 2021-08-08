package dao;

import dto.Item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import org.apache.log4j.Logger;
import util.DBUtil;

public class ItemDao {

    private static final Logger LOGGER = Logger.getLogger(ItemDao.class);

    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

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

    public Vector<Item> getAllItem() throws SQLException, Exception {
        Vector<Item> listItem = new Vector<Item>();

        try {
            con = DBUtil.getConnnection();
            if (con != null) {
                String sql = "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItem.add(new Item(rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"),
                            rs.getInt("quantity"), rs.getString("image"), rs.getString("levelID"), rs.getString("categoryID")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItem;
    }

    public Vector<Item> getAllItemByPage(int pageNumber, int itemOfPage, String roleName) throws SQLException, Exception {
        Vector<Item> listItem = new Vector<Item>();

        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item "
                        + "WHERE " + condition
                        + "ORDER BY (SELECT NULL) \n"
                        + "OFFSET (?-1)*? ROWS \n"
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setInt(1, pageNumber);
                ps.setInt(2, itemOfPage);
                ps.setInt(3, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItem.add(new Item(rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"),
                            rs.getInt("quantity"), rs.getString("image"), rs.getString("levelID"), rs.getString("categoryID")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItem;
    }

    public int getNumberOfPage(String roleName) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM Item "
                        + "WHERE " + condition;

                ps = con.prepareStatement(sql);
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

    public Vector<Item> getAllItemOfCategoryByPage(int pageNumber, int itemOfPage, String categoryID, String roleName) throws SQLException, Exception {
        Vector<Item> listItem = new Vector<Item>();

        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item "
                        + "WHERE categoryID = ? AND " + condition
                        + "ORDER BY (SELECT NULL) \n"
                        + "OFFSET (?-1)*? ROWS\n "
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, categoryID);
                ps.setInt(2, pageNumber);
                ps.setInt(3, itemOfPage);
                ps.setInt(4, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItem.add(new Item(rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"),
                            rs.getInt("quantity"), rs.getString("image"), rs.getString("levelID"), rs.getString("categoryID")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItem;
    }

    public int getNumberOfPageInCategory(String categoryID, String roleName) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM Item "
                        + "WHERE categoryID = ? AND " + condition;
                ps = con.prepareStatement(sql);
                ps.setString(1, categoryID);
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

    public Item getItemByID(String id) throws SQLException, Exception {
        Item item = null;
        try {
            con = DBUtil.getConnnection();

            if (con != null) {
                String sql = "Select itemID,itemName,color,quantity,image,levelID,categoryID "
                        + "From Item Where itemID=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, id);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String itemID = rs.getString("itemID");
                    String itemName = rs.getString("itemName");
                    String color = rs.getString("color");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String levelID = rs.getString("levelID");
                    String categoryID = rs.getString("categoryID");

                    item = new Item(itemID, itemName, color, quantity, image, levelID, categoryID);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return item;
    }

    public Vector<Item> getAllSearchItemByPage(int pageNumber, int itemOfPage, String roleName, String context) throws SQLException, Exception {
        Vector<Item> listItem = new Vector<Item>();

        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item "
                        + "WHERE itemName like ? AND " + condition
                        + "ORDER BY (SELECT NULL) \n"
                        + "OFFSET (?-1)*? ROWS \n"
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + context + "%");
                ps.setInt(2, pageNumber);
                ps.setInt(3, itemOfPage);
                ps.setInt(4, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItem.add(new Item(rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"),
                            rs.getInt("quantity"), rs.getString("image"), rs.getString("levelID"), rs.getString("categoryID")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItem;
    }

    public int getNumberOfPageSearch(String roleName, String context) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM Item "
                        + "WHERE itemName like ? AND " + condition;

                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + context + "%");
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

    public Vector<Item> getAllItemSearchDateByPage(int pageNumber, int itemOfPage, String roleName, String dateSearch) throws SQLException, Exception {
        Vector<Item> listItem = new Vector<Item>();

        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM ("
                        + "SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item WHERE " + condition
                        + "EXCEPT "
                        + "(SELECT itemID,itemName,color,quantity,image,levelID,categoryID FROM Item "
                        + "WHERE quantity <= (SELECT SUM(quantity) FROM BookingDetail "
                        + "WHERE itemID=Item.itemID AND statusRequest='Accept' AND dateBorrow=? AND " + condition + "))) result "
                        + "ORDER BY (SELECT NULL) "
                        + "OFFSET (?-1)* ?  ROWS "
                        + "FETCH NEXT ? ROWS ONLY";

                ps = con.prepareStatement(sql);
                ps.setString(1, dateSearch);
                ps.setInt(2, pageNumber);
                ps.setInt(3, itemOfPage);
                ps.setInt(4, itemOfPage);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listItem.add(new Item(rs.getString("itemID"), rs.getString("itemName"), rs.getString("color"),
                            rs.getInt("quantity"), rs.getString("image"), rs.getString("levelID"), rs.getString("categoryID")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listItem;
    }

    public int getNumberOfPageSearchDate(String roleName, String dateSearch) throws SQLException, Exception {
        int count = 0;
        try {
            con = DBUtil.getConnnection();

            String condition;
            if (roleName.equals("Leader")) {
                condition = "(levelID=1 OR levelID=2) ";
            } else {
                condition = "levelID=1 ";
            }
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM ("
                        + "SELECT * FROM Item "
                        + "WHERE " + condition
                        + "EXCEPT "
                        + "(SELECT * FROM Item "
                        + "WHERE quantity <= (SELECT SUM(quantity) FROM BookingDetail "
                        + "WHERE itemID=Item.itemID AND statusRequest='Accept' AND dateBorrow=? AND " + condition + "))) result";

                ps = con.prepareStatement(sql);
                ps.setString(1, dateSearch);
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
