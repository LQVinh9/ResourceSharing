/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.AdminDao;
import dto.ItemAdmin;
import dto.User;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "error.html";
    private static final String ADMIN_PAGE = "admin.jsp";

    private static final Logger LOGGER = Logger.getLogger(AdminController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            String actionAdmin = request.getParameter("action");

            String statusRequest = request.getParameter("statusRequest");
            if (statusRequest == null) {
                statusRequest = "New";
            }

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String dateNow = dtf.format(now);

            AdminDao adminDao = new AdminDao();

            int pageNumber;
            String pageNumberRequest = request.getParameter("pageNumber");
            if (pageNumberRequest == null) {
                pageNumber = 1;
            } else {
                pageNumber = Integer.parseInt(pageNumberRequest);
            }
            int itemOfPage = 4;
            int numberOfPage = 0;

            Vector<ItemAdmin> listItemAdmin = null;

            if (actionAdmin != null) {
                if (actionAdmin.equals("deleteRequest")) {
                    String bookingDetailID = request.getParameter("bookingDetailID");
                    adminDao.updateStatusRequestDelete(bookingDetailID);
                    request.setAttribute("deleteMessage", "delete success");

                    listItemAdmin = adminDao.getAllItemAdmin(pageNumber, itemOfPage, statusRequest);
                    numberOfPage = (int) Math.ceil((double) adminDao.getNumberOfPage(statusRequest) / itemOfPage);
                } else if (actionAdmin.equals("acceptRequest")) {
                    String bookingDetailID = request.getParameter("bookingDetailID");
                    String itemID = request.getParameter("itemID");
                    String dateBorrow = request.getParameter("dateBorrow");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    int amountItemAccepted = adminDao.getAmountItemAccepted(itemID, dateBorrow);
                    int amountItem = adminDao.getAmountItem(itemID);
                    if (quantity <= (amountItem - amountItemAccepted)) {
                        adminDao.updateStatusRequestAccept(bookingDetailID);
                        request.setAttribute("successMessage", "Accept success");
                    } else {
                        request.setAttribute("failureMessage", "Accept failure");
                    }

                    listItemAdmin = adminDao.getAllItemAdmin(pageNumber, itemOfPage, statusRequest);
                    numberOfPage = (int) Math.ceil((double) adminDao.getNumberOfPage(statusRequest) / itemOfPage);
                } else if (actionAdmin.equals("searchDateAdmin")) {
                    String dateFrom = request.getParameter("dateFrom");
                    String dateTo = request.getParameter("dateTo");

                    if (dateFrom.compareTo(dateTo) > 0) {
                        String date = dateFrom;
                        dateFrom = dateTo;
                        dateTo = date;
                    }

                    listItemAdmin = adminDao.getAllItemAdminSearchDate(pageNumber, itemOfPage, dateFrom, dateTo);
                    numberOfPage = (int) Math.ceil((double) adminDao.getNumberOfPageSearchDate(dateFrom, dateTo) / itemOfPage);
                } else if (actionAdmin.equals("searchNameAdmin")) {
                    String nameAdmin = request.getParameter("nameAdmin");

                    listItemAdmin = adminDao.getAllItemAdminSearch(pageNumber, itemOfPage, nameAdmin);
                    numberOfPage = (int) Math.ceil((double) adminDao.getNumberOfPageSearchAdmin(nameAdmin) / itemOfPage);
                }
            } else {
                listItemAdmin = adminDao.getAllItemAdmin(pageNumber, itemOfPage, statusRequest);
                numberOfPage = (int) Math.ceil((double) adminDao.getNumberOfPage(statusRequest) / itemOfPage);
            }

            request.setAttribute("listItemAdmin", listItemAdmin);

            request.setAttribute("dateNow", dateNow);
            request.setAttribute("userName", user.getName());
            request.setAttribute("roleName", user.getRoleName());
            request.setAttribute("numberOfPage", numberOfPage);
            request.setAttribute("pageNumber", pageNumber);

            URL = ADMIN_PAGE + "?statusRequest=" + statusRequest;
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
