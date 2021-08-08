/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ItemDao;
import dto.Item;
import dto.ItemOrder;
import dto.Order;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

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
    private static final String LIST_CART = "listCart.jsp";

    private static final Logger LOGGER = Logger.getLogger(AddToCartController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String today = dtf.format(now);

            String action = request.getParameter("action");

            int quantity = 1;
            String id;
            ItemDao itemDao = new ItemDao();

            if (action != null && action.equals("addToCart")) {
                if (request.getParameter("itemID") != null) {
                    id = request.getParameter("itemID");
                    Item item = itemDao.getItemByID(id);
                    if (item != null) {
                        if (request.getParameter("quantity") != null) {
                            quantity = Integer.parseInt(request.getParameter("quantity"));
                        }
                        HttpSession session = request.getSession();
                        if (session.getAttribute("order") == null) {
                            Order order = new Order();
                            List<ItemOrder> listItems = new ArrayList<ItemOrder>();
                            ItemOrder itemOder = new ItemOrder();
                            itemOder.setQuantity(quantity);
                            itemOder.setItem(item);
                            listItems.add(itemOder);
                            order.setItemOrder(listItems);
                            session.setAttribute("order", order);
                        } else {
                            Order order = (Order) session.getAttribute("order");
                            List<ItemOrder> listItems = order.getItemOrder();

                            boolean check = false;
                            for (ItemOrder itemOrder : listItems) {
                                if (itemOrder.getItem().getItemID().equals(item.getItemID())) {
                                    itemOrder.setQuantity(itemOrder.getQuantity() + quantity);
                                    check = true;
                                }
                            }
                            if (check == false) {
                                ItemOrder itemOder = new ItemOrder();
                                itemOder.setQuantity(quantity);
                                itemOder.setItem(item);
                                listItems.add(itemOder);
                            }
                            session.setAttribute("order", order);
                        }
                    }
                }

                URL = MAIN_CONTROLLER;
                response.sendRedirect(URL);
                return;
            } else if (action.equals("showCart")) {
                HttpSession session = request.getSession();
                Order order = (Order) session.getAttribute("order");
                List<ItemOrder> listItems = null;
                if (order != null) {
                    listItems = order.getItemOrder();
                }

                request.setAttribute("listItems", listItems);
                request.setAttribute("today", today);

                URL = LIST_CART;
                request.getRequestDispatcher(URL).forward(request, response);
            } else if (action.equals("deleteItemCart")) {
                String itemID = request.getParameter("itemID");

                HttpSession session = request.getSession();
                Order order = (Order) session.getAttribute("order");
                List<ItemOrder> listItems = order.getItemOrder();

                for (ItemOrder itemOrder : listItems) {
                    if (itemOrder.getItem().getItemID().equals(itemID)) {
                        listItems.remove(itemOrder);
                        break;
                    }
                }

                request.setAttribute("listItems", listItems);
                request.setAttribute("today", today);

                URL = LIST_CART;
                request.getRequestDispatcher(URL).forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMess", e.toString());
            LOGGER.error(e);
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
