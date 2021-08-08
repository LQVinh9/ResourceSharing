/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BookingDao;
import dto.Booking;
import dto.BookingDetail;
import dto.ItemOrder;
import dto.Order;
import dto.User;
import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {

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

    private static final Logger LOGGER = Logger.getLogger(BookingController.class);

    private static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final SecureRandom RND = new SecureRandom();

    private String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(AB.charAt(RND.nextInt(AB.length())));
        }
        return sb.toString();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            HttpSession session = request.getSession();
            Order order = (Order) session.getAttribute("order");
            List<ItemOrder> listItems = null;
            if (order != null) {
                listItems = order.getItemOrder();
            }

            String[] quantityOfItems = request.getParameterValues("quantity");
            String[] dateBooking = request.getParameterValues("dateBooking");

            for (int i = 0; i < listItems.size(); i++) {
                listItems.get(i).setQuantity(Integer.parseInt(quantityOfItems[i]));
                listItems.get(i).setDate(dateBooking[i]);
            }

            BookingDao bookingDao = new BookingDao();

            User user = (User) session.getAttribute("user");

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
            LocalDateTime now = LocalDateTime.now();

            boolean check = true;
            for (ItemOrder itemOrder : listItems) {
                itemOrder.setError(null);
                int numberOfProductsAvailable = itemOrder.getItem().getQuantity() - bookingDao.getQuantityItemAccepted(itemOrder.getItem().getItemID(), itemOrder.getDate());
                if (itemOrder.getQuantity() > numberOfProductsAvailable) {
                    itemOrder.setError("Chỉ còn lại " + numberOfProductsAvailable + " sản phẩm trong ngày này!");
                    check = false;
                }
                if (itemOrder.getDate().compareTo(dtf.format(now)) >= 0 || itemOrder.getQuantity() < 1 || itemOrder.getQuantity() > 99) {
                    check = false;
                }
            }
            if (check == false) {
                request.setAttribute("listItems", listItems);

                URL = LIST_CART;
                request.getRequestDispatcher(URL).forward(request, response);
            } else {
                Booking booking = null;
                String bookingID;
                do {
                    bookingID = randomString(5);
                    booking = bookingDao.getBookingByID(bookingID);
                } while (booking != null);
                String date = dtf.format(now);
                String userID = user.getUserID();

                booking = new Booking(bookingID, date, userID);
                bookingDao.createBooking(booking);

                for (ItemOrder itemOrder : listItems) {
                    BookingDetail bookingDetail = null;

                    String bookingDetailID = randomString(5);
                    do {
                        bookingDetailID = randomString(5);
                        bookingDetail = bookingDao.getBookingDetailByID(bookingDetailID);
                    } while (bookingDetail != null);
                    int quantity = itemOrder.getQuantity();
                    String dateBorrow = itemOrder.getDate();
                    String statusRequest = "New";
                    String status = "True";
                    String itemID = itemOrder.getItem().getItemID();

                    bookingDetail = new BookingDetail(bookingDetailID, quantity, dateBorrow, statusRequest, status, itemID, bookingID);
                    bookingDao.createBookingDetail(bookingDetail);
                }

                session.removeAttribute("order");

                URL = MAIN_CONTROLLER + "?notification=bookingSuccessful";
                response.sendRedirect(URL);
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
