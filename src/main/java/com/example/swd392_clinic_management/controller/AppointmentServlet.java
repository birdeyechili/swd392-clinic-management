package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.AppointmentDAO;
import com.example.swd392_clinic_management.dal.UserDAO;
import com.example.swd392_clinic_management.DTO.AppointmentDTO;
import com.example.swd392_clinic_management.model.Appointment;
import com.example.swd392_clinic_management.model.User;
import com.example.swd392_clinic_management.util.PaginationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AppointmentServlet", value = "/appointment")
public class AppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        User loggedUser = (User) request.getSession().getAttribute("user");

        if (loggedUser == null) {
            request.setAttribute("error", "You must log in as admin to access!");
            request.getRequestDispatcher("/authentication").forward(request, response);
            return;
        }

        //Check action by param 'tag'
        String tag = request.getParameter("tag");
        // ACTION: View all appointment
        if (tag == null) {
            List<AppointmentDTO> appointments;
            if (loggedUser.getRole() == 0) { //admin
                appointments = appointmentDAO.getAppointment();
            } else {        //doctor or patient
                appointments = appointmentDAO.getAppointmentDTOByUserId(loggedUser.getUserId());
            }
            //get search params (by name or by status)
            String searchKey = request.getParameter("searchKey");
            String rawSearchStatus = request.getParameter("searchStatus");
            if (searchKey != null || rawSearchStatus != null) {
                int status = -1;
                if (!rawSearchStatus.equals("")) {
                    status = Integer.parseInt(rawSearchStatus);
                    request.setAttribute("searchStatus", status);
                }
                if (searchKey == null) searchKey = "";
                else request.setAttribute("searchKey", searchKey);
                appointments = appointmentDAO.searchAppointmentDTO(appointments, searchKey, status);
            }

            String rawPageNumber = request.getParameter("curPage");
            PaginationUtil util = PaginationUtil.getStartAndEndIndex(appointments.size(), 6, rawPageNumber);
            List<AppointmentDTO> listPaging = appointmentDAO.getAppointmentDTOPaging(appointments, util.getStart(), util.getEnd());

            // Set data to jsp
            request.setAttribute("list", listPaging);
            request.setAttribute("num", util.getTotalPage());
            request.setAttribute("curPage", util.getCurrentPage());     //current page
            request.getRequestDispatcher("view/appoint/AppointList.jsp").forward(request, response);
        }
        // ACTION: Update appointment
        else if (tag.equals("update")) {
            //Get appoint by id
            String id = request.getParameter("id");
            AppointmentDTO appointment = appointmentDAO.getAppointmentDetails(Integer.parseInt(id));
            request.setAttribute("appointment", appointment);

            //Get doctor list
            List<User> doctorList = userDAO.searchUser("", 2);
            request.setAttribute("doctorList", doctorList);
            request.getRequestDispatcher("view/appoint/AppointDetail.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String tag = request.getParameter("tag");
        if (tag != null && tag.equals("update")) {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            int doctorId = Integer.parseInt(request.getParameter("doctor"));
            String rawTime = request.getParameter("time");
            SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd-MM-yyyy");
            Date time = null;
            String note = request.getParameter("note");
            try {
                time = formatter.parse(rawTime);
            } catch (ParseException e) {
                AppointmentDTO appointment = appointmentDAO.getAppointmentDetails(appointmentId);
                request.setAttribute("doctorId", doctorId);
                request.setAttribute("appointment", appointment);

                request.setAttribute("error", "Please input time in right format!");
                List<User> doctorList = userDAO.searchUser("", 2);
                request.setAttribute("doctorList", doctorList);
                request.getRequestDispatcher("view/appoint/AppointDetail.jsp").forward(request, response);
                return;
            }
            int status = Integer.parseInt(request.getParameter("status"));

            Appointment appointment = Appointment.builder()
                    .appointId(appointmentId)
                    .doctorId(doctorId)
                    .time(time)
                    .note(note)
                    .status(status)
                    .build();
            appointmentDAO.updateAppointment(appointment);

            response.sendRedirect("appointment");
        }

    }

}
