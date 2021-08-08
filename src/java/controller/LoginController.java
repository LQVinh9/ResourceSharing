/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDao;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import recaptcha.VerifyRecaptcha;

/**
 *
 * @author Vinh
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "login.jsp";
    private static final String MAIN_CONTROLLER = "MainController";
    private static final String WELCOME = "welcome.jsp";

    private static final Logger LOGGER = Logger.getLogger(LoginController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String URL = ERROR;

        try {
            String actionLogin = request.getParameter("actionLogin");

            HttpSession session = request.getSession();

            if (actionLogin != null && actionLogin.equals("logout")) {
                session.removeAttribute("user");
                session.removeAttribute("order");
                URL = MAIN_CONTROLLER;
            } else {
                UserDao userDao = new UserDao();

                String email = request.getParameter("email");
                if (email != null) {
                    User user = userDao.checkLoginGoogle(email);
                    if (user != null) {
                        session.setMaxInactiveInterval(3000);
                        session.setAttribute("user", user);

                        URL = WELCOME;
                    } else {
                        String errorLoginGoogle = "Wrong";
                        request.setAttribute("errorLoginGoogle", errorLoginGoogle);

                        URL = LOGIN;
                    }
                } else {
                    String userID = request.getParameter("userID");
                    String password = request.getParameter("password");

                    String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
                    boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

                    if (verify == false) {
                        String errorVerify = "You missed the Captcha";
                        request.setAttribute("errorVerify", errorVerify);

                        URL = LOGIN;
                    } else {
                        User user = userDao.checkLoginAccountNotActivated(userID, password);
                        if (user != null) {
                            String errorAccount = "Account not activated";
                            request.setAttribute("errorAccount", errorAccount);

                            URL = LOGIN;
                        } else {
                            user = userDao.checkLogin(userID, password);
                            if (user == null) {
                                String error = "Login fail";
                                request.setAttribute("error", error);

                                URL = LOGIN;
                            } else {
                                session.setMaxInactiveInterval(3000);
                                session.setAttribute("user", user);

                                URL = WELCOME;
                            }
                        }
                    }
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
