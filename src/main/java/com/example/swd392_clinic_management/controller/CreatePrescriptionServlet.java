package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.AppointmentDAO;
import com.example.swd392_clinic_management.dal.PrescriptionDAO;
import com.example.swd392_clinic_management.model.Prescription;
import com.example.swd392_clinic_management.util.Config;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CreatePrescriptionServlet", value = "/createprescription")
public class CreatePrescriptionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        request.setAttribute("appointmentList",appointmentDAO.getAppointment());
        request.setAttribute("statusList",new Config().getPrescriptionStatus());
        request.getRequestDispatcher("view/prescription/CreatePrescription.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appointmentId_raw = request.getParameter("appointmentId");
        String pres = request.getParameter("pres");
        String note = request.getParameter("note");
        String status_raw = request.getParameter("status");

        try {
            int appointmentId = Integer.parseInt(appointmentId_raw);
            int status = Integer.parseInt(status_raw);
            Prescription prescription = new Prescription(0,appointmentId,pres,note,status);
            PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
            prescriptionDAO.addPrescription(prescription);
            response.sendRedirect("createprescription?message=Successfully created prescription");
        }catch (NumberFormatException e){
            response.sendRedirect("createprescription?message=An error occurred while parsing number");
        } catch (SQLException e) {
            response.sendRedirect("createprescription?message=An error occurred while connecting to database");
        }
    }
}
