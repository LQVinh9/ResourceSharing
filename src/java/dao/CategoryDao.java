package dao;

import dto.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import org.apache.log4j.Logger;
import util.DBUtil;

public class CategoryDao {

    private static final Logger LOGGER = Logger.getLogger(CategoryDao.class);

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

    public Vector<Category> getAllCategory() throws SQLException, Exception {
        Vector<Category> listCategory = new Vector<Category>();
        try {
            con = DBUtil.getConnnection();
            if (con != null) {
                String sql = "SELECT categoryID,categoryName FROM Category";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    listCategory.add(new Category(rs.getString("categoryID"), rs.getString("categoryName")));
                }
            }
        } catch (Exception e) {
            LOGGER.error(e);
        } finally {
            closeConnection();
        }
        return listCategory;
    }
}
