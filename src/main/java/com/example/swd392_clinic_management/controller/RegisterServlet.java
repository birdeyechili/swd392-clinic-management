package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

@WebServlet(name = "RegisterServlet", value = "/registration")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/user/AddNew.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");
        String fullName = request.getParameter("fullName");
        String dob_raw = request.getParameter("dob");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        int age;

        try{
            LocalDate dob = LocalDate.parse(dob_raw);
            age = Period.between(dob,LocalDate.now()).getYears();
        }catch (DateTimeParseException e){
            addUserInputToRequest(request, account, fullName, dob_raw, email, position);
            request.setAttribute("error", "Error parsing date");
            request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        if(!password.equals(rePassword)){
            addUserInputToRequest(request, account, fullName, dob_raw, email, position);
            request.setAttribute("error", "Password fields don't match each other");
            request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
        }else if (dao.emailExisted(-1, email)) {
            addUserInputToRequest(request, account, fullName, dob_raw, email, position);
            request.setAttribute("error", "Email existed");
            request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
        }else if (dao.accountExisted(-1, account)){
            addUserInputToRequest(request, account, fullName, dob_raw, email, position);
            request.setAttribute("error", "Account existed");
            request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
        }else{
            User user = User.builder()
                    .account(account)
                    .fullName(fullName)
                    .age(age)
                    .email(email)
                    .role(2)
                    .position(position)
                    .status(true)
                    .build();

            dao.addNewUser(user);
            response.sendRedirect("home");
        }

    }

    private void addUserInputToRequest(HttpServletRequest request, String account, String fullName, String dob, String email, String position){
        request.setAttribute("account", account);
        request.setAttribute("fullName", fullName);
        request.setAttribute("dob", dob);
        request.setAttribute("email", email);
        request.setAttribute("position", position);
    }
}
