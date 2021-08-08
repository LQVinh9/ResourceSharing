/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CategoryDao;
import dao.ItemDao;
import dto.Category;
import dto.Item;
import dto.ItemOrder;
import dto.Order;
import dto.User;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Vinh
 */
@WebServlet(name = "ItemPageController", urlPatterns = {"/ItemPageController"})
public class ItemPageController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String HOME = "home.jsp";
    private static final String ERROR = "error.html";

    private static final Logger LOGGER = Logger.getLogger(ItemPageController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            String action = request.getParameter("action");

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String today = dtf.format(now);

            CategoryDao categoryDao = new CategoryDao();
            ItemDao dao = new ItemDao();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            Order order = (Order) session.getAttribute("order");
            List<ItemOrder> listItems = null;
            int numberOfItem = 0;
            if (order != null) {
                listItems = order.getItemOrder();
                numberOfItem = listItems.size();
            }
            request.setAttribute("numberOfItem", numberOfItem);

            String categoryID = request.getParameter("categoryID");
            Vector<Category> listCategory = categoryDao.getAllCategory();

            String roleName = user.getRoleName();

            int pageNumber;
            String pageNumberRequest = request.getParameter("pageNumber");
            if (pageNumberRequest == null) {
                pageNumber = 1;
            } else {
                pageNumber = Integer.parseInt(pageNumberRequest);
            }
            int itemOfPage = 4;
            int numberOfPage;
            Vector<Item> listItem;

            if (action != null && action.equals("search")) {
                String searchContext = request.getParameter("searchContext");

                listItem = dao.getAllSearchItemByPage(pageNumber, itemOfPage, roleName, searchContext);
                numberOfPage = (int) Math.ceil((double) dao.getNumberOfPageSearch(roleName, searchContext) / itemOfPage);
                request.setAttribute("actionSearch", "search");
            } else if (action != null && action.equals("searchDate")) {
                String dateSearch = request.getParameter("dateSearch");

                listItem = dao.getAllItemSearchDateByPage(pageNumber, itemOfPage, roleName, dateSearch);
                numberOfPage = (int) Math.ceil((double) dao.getNumberOfPageSearchDate(roleName, dateSearch) / itemOfPage);
                request.setAttribute("actionSearch", "searchDate");
            } else if (categoryID != null) {
                listItem = dao.getAllItemOfCategoryByPage(pageNumber, itemOfPage, categoryID, roleName);
                numberOfPage = (int) Math.ceil((double) dao.getNumberOfPageInCategory(categoryID, roleName) / itemOfPage);
                request.setAttribute("categoryID", categoryID);
            } else {
                listItem = dao.getAllItemByPage(pageNumber, itemOfPage, roleName);
                numberOfPage = (int) Math.ceil((double) dao.getNumberOfPage(roleName) / itemOfPage);
            }

            request.setAttribute("numberOfPage", numberOfPage);
            request.setAttribute("pageNumber", pageNumber);
            request.setAttribute("listItem", listItem);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("userName", user.getName());
            request.setAttribute("roleName", user.getRoleName());
            request.setAttribute("today", today);

            URL = HOME;
        } catch (Exception e) {
            request.setAttribute("errorMess", e.toString());
            LOGGER.error(e);
        } finally {
            request.getRequestDispatcher(URL).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
