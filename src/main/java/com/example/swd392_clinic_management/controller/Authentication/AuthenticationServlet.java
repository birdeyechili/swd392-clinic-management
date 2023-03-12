package com.example.swd392_clinic_management.controller.Authentication;

import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AuthenticationServlet", value = "/authentication")
public class AuthenticationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        User user = (User) request.getSession().getAttribute("user");
//        if (user == null) {
            request.getRequestDispatcher("view/Authentication/Login.jsp").forward(request, response);
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.login(account, password);
            if(user != null){
                request.getSession().setAttribute("user", user);
                response.sendRedirect("home");
            }else{
                request.getRequestDispatcher("view/Authentication/Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
