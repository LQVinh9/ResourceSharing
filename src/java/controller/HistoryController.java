/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.HistoryDao;
import dto.ItemHistory;
import dto.User;
import java.io.IOException;
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
@WebServlet(name = "HistoryController", urlPatterns = {"/HistoryController"})
public class HistoryController extends HttpServlet {

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
    private static final String MAIN_CONTROLLER = "MainController";
    private static final String HISTORY = "history.jsp";

    private static final Logger LOGGER = Logger.getLogger(HistoryController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            String actionHistory = request.getParameter("action");

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            HistoryDao historyDao = new HistoryDao();

            if (actionHistory.equals("history")) {
                Vector<ItemHistory> listItemHistory = historyDao.getAllItemHistory(user.getUserID());
                request.setAttribute("listItemHistory", listItemHistory);

                URL = HISTORY;
            } else if (actionHistory.equals("deleteHistory")) {
                String bookingDetailID = request.getParameter("bookingDetailID");

                historyDao.deleteHistory(bookingDetailID);

                URL = MAIN_CONTROLLER + "?action=history";
            } else if (actionHistory.equals("searchDateHistory")) {
                String dateBorrowFrom = request.getParameter("dateHistoryFrom");
                String dateBorrowTo = request.getParameter("dateHistoryTo");

                if (dateBorrowFrom.compareTo(dateBorrowTo) > 0) {
                    String date = dateBorrowFrom;
                    dateBorrowFrom = dateBorrowTo;
                    dateBorrowTo = date;
                }

                Vector<ItemHistory> listItemHistory = historyDao.getAllItemHistoryByDate(dateBorrowFrom, dateBorrowTo, user.getUserID());
                request.setAttribute("listItemHistory", listItemHistory);

                URL = HISTORY;
            } else if (actionHistory.equals("searchNameHistory")) {
                String nameHistory = request.getParameter("nameHistory");

                Vector<ItemHistory> listItemHistory = historyDao.getAllItemHistoryByName(nameHistory, user.getUserID());
                request.setAttribute("listItemHistory", listItemHistory);

                URL = HISTORY;
            }
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
