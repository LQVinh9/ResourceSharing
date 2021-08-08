/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.User;
import java.io.IOException;
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
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ITEM_FAGE = "ItemPageController";
    private static final String CART_CONTROLLER = "AddToCartController";
    private static final String BOOKING_CONTROLLER = "BookingController";
    private static final String HISTORY_CONTROLLER = "HistoryController";
    private static final String ADMIN_CONTROLLER = "AdminController";
    
    private static final String ERROR = "error.html";
    private static final String LOGIN = "login.jsp";

    private static final Logger LOGGER = Logger.getLogger(MainController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String URL = ERROR;

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                URL = LOGIN;
            } else {
                String action = request.getParameter("action");

                if (action == null) {
                    if (user.getRoleID().equals("M")) {
                        URL = ADMIN_CONTROLLER;
                    } else {
                        URL = ITEM_FAGE;
                    }
                } else if (action.equals("showCart")) {
                    URL = CART_CONTROLLER;
                } else if (action.equals("addToCart")) {
                    URL = CART_CONTROLLER;
                } else if (action.equals("deleteItemCart")) {
                    URL = CART_CONTROLLER;
                } else if (action.equals("booking")) {
                    URL = BOOKING_CONTROLLER;
                } else if (action.equals("search")) {
                    URL = ITEM_FAGE;
                } else if (action.equals("searchDate")) {
                    URL = ITEM_FAGE;
                } else if (action.equals("history")) {
                    URL = HISTORY_CONTROLLER;
                } else if (action.equals("deleteHistory")) {
                    URL = HISTORY_CONTROLLER;
                } else if (action.equals("searchDateHistory")) {
                    URL = HISTORY_CONTROLLER;
                } else if (action.equals("searchNameHistory")) {
                    URL = HISTORY_CONTROLLER;
                } else if (action.equals("admin")) {
                    URL = ADMIN_CONTROLLER;
                } else if (action.equals("deleteRequest")) {
                    URL = ADMIN_CONTROLLER;
                } else if (action.equals("acceptRequest")) {
                    URL = ADMIN_CONTROLLER;
                } else if (action.equals("searchDateAdmin")) {
                    URL = ADMIN_CONTROLLER;
                } else if (action.equals("searchNameAdmin")) {
                    URL = ADMIN_CONTROLLER;
                }
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
