package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.AppointmentDAO;
import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.DTO.AppointmentDTO;
import com.example.swd392_clinic_management.model.Appointment;
import com.example.swd392_clinic_management.model.User;
import com.example.swd392_clinic_management.util.PaginationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "RequestServlet", value = "/request")
public class RequestServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private UserDAO userDAO = new UserDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        //Fake user
        HttpSession session = request.getSession();
        User fakeUser = new User(13, "a", "1", "Mai", 12, "kien@", 1, "Benh nhan", true);
        session.setAttribute("loggedUser", fakeUser);

        // Check loggedUser
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            request.setAttribute("error", "You must log in to access!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        List<User> doctorList = userDAO.searchUser("", 2);
        request.setAttribute("doctorList", doctorList);

        request.getRequestDispatcher("view/appoint/Request.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String rawPatientId = request.getParameter("patientId");
        int patientId = Integer.parseInt(rawPatientId);
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String rawTime = request.getParameter("time");
        String note = request.getParameter("note").strip();
        Date time = null;
        try {
            time = new SimpleDateFormat("HH:mm dd-MM-yyyy").parse(rawTime);
        } catch (ParseException e) {
            request.setAttribute("doctorId", doctorId);
            request.setAttribute("time", rawTime);
            request.setAttribute("note", note);
            request.setAttribute("error", "Please input in right format!");
            List<User> doctorList = userDAO.searchUser("", 2);
            request.setAttribute("doctorList", doctorList);
            request.getRequestDispatcher("view/appoint/Request.jsp").forward(request, response);
            return;
        }
        Appointment appointment = Appointment.builder()
                .patientId(patientId)
                .doctorId(doctorId)
                .time(time)
                .note(note)
                .status(1)
                .build();

        appointmentDAO.requestAppointment(appointment);
        response.sendRedirect("appointment");
    }

}
