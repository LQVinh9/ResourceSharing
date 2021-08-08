/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDao;
import dto.User;
import dto.UserError;
import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import verifiEmail.SendEmailActive;

/**
 *
 * @author Vinh
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

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
    private static final String REGISTER = "register.jsp";
    private static final String MAIN_CONTROLLER = "MainController";

    private static final Logger LOGGER = Logger.getLogger(RegisterController.class);

    private static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final SecureRandom RND = new SecureRandom();

    private boolean isValidEmail(String email) {
        String regex = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
        return email.matches(regex);
    }

    private boolean isValidPhone(String email) {
        String regex = "^[0-9]*$";
        return email.matches(regex);
    }

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
            String action = request.getParameter("action");

            if (action != null && action.equals("active")) {
                String email = request.getParameter("email");
                String codeRegister = request.getParameter("codeRegister");
                String status = "Active";

                User user = new User(email, codeRegister, status);

                UserDao userDao = new UserDao();
                userDao.updateUser(user);

                URL = MAIN_CONTROLLER;
            } else {
                UserDao userDao = new UserDao();

                String email = request.getParameter("email").trim();
                String password = request.getParameter("pass").trim();
                String passwordConfirm = request.getParameter("passwordConfirm").trim();
                String name = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String address = request.getParameter("address").trim();
                String role = request.getParameter("role").trim();

                boolean check = true;
                UserError userError = new UserError();

                if (isValidEmail(email) == false) {
                    check = false;
                    userError.setEmail("Email không đúng định dạng");
                }
                if (email.length() > 100) {
                    check = false;
                    userError.setEmail("Email không lớn hơn 100 kí tự");
                }
                if (userDao.getUserByID(email) != null) {
                    check = false;
                    userError.setEmail("Email đã tồn tại trước đó");
                }

                if (password.length() < 8) {
                    check = false;
                    userError.setPassword("Password phải lớn hơn 8 kí tự");
                }
                if (password.length() > 50) {
                    check = false;
                    userError.setPassword("Password phải bé hơn 50 kí tự");
                }
                if (!password.equals(passwordConfirm)) {
                    check = false;
                    userError.setPasswordConfirm("Password không khớp nhau");
                }

                if (isValidPhone(phone) == false) {
                    check = false;
                    userError.setPhone("Phone phải là số");
                }
                if (phone.length() < 10 || phone.length() > 12) {
                    check = false;
                    userError.setPhone("Phone phải từ 10 đến 12 số");
                }

                if (address.length() > 300) {
                    check = false;
                    userError.setAddress("Address phải bé hơn 300 kí tự");
                }

                if (check == true) {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();

                    String status = "New";
                    String codeRegister = randomString(8);
                    String dateCreate = dtf.format(now);
                    User user = new User(email, name, password, phone, address, dateCreate, codeRegister, status, role);
                    if (userDao.createUser(user) == true) {
                        SendEmailActive sendEmail = new SendEmailActive();
                        sendEmail.sendEmailVerify(email, codeRegister);
                    }

                    URL = MAIN_CONTROLLER;
                } else {
                    request.setAttribute("userError", userError);

                    URL = REGISTER;
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
