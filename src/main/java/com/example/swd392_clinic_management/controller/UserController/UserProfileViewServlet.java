package com.example.swd392_clinic_management.controller.UserController;

import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserProfileViewServlet", value = "/UserProfileViewServlet")
public class UserProfileViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.getRequestDispatcher("view/user/ViewProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
