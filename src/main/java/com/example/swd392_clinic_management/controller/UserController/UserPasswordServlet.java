package com.example.swd392_clinic_management.controller.UserController;

import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserPasswordServlet", value = "/UserPasswordServlet")
public class UserPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.getRequestDispatcher("view/user/ChangePassword.jsp").forward(request, response);
        } else {
            response.sendRedirect("authentication");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");
        if (user.getPassword().equals(oldPass) && newPass.equals(confirmPass)) {
            user.setPassword(newPass);
            UserDAO userDAO = new UserDAO();
            boolean check = userDAO.updateUserDetail(user);
            response.sendRedirect("LogOutServlet?message=Password changed successfully!");
        } else {
            response.sendRedirect("UserPasswordServlet?message=Invalid credentials! Check again.");
        }
    }
}
