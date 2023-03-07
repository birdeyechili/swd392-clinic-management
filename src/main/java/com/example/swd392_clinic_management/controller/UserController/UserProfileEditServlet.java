package com.example.swd392_clinic_management.controller.UserController;

import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserProfileEditServlet", value = "/UserProfileEditServlet")
public class UserProfileEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.getRequestDispatcher("view/user/EditProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (request.getParameter("fullname") != null) {
            String fullName = request.getParameter("fullName");
            user.setFullName(fullName);
        }

        if (request.getParameter("email") != null) {
            String email = request.getParameter("email");
            user.setEmail(email);
        }

        if (request.getParameter("age") != null) {
            int age = Integer.parseInt(request.getParameter("age"));
            user.setAge(age);
        }

        UserDAO userDBC = new UserDAO();
        boolean check = userDBC.editProfile(user);
        log("Edit profile: " + check);
        if (check) {
            // do shit
        } else {
            // do other shit
        }
    }
}
