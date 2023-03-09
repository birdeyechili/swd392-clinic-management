package com.example.swd392_clinic_management.controller.UserController;

import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LogOutServlet", value = "/LogOutServlet")
public class LogOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mess;
        mess = request.getParameter("message") != null ? request.getParameter("message") : "";
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("authentication?message="+ mess);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
