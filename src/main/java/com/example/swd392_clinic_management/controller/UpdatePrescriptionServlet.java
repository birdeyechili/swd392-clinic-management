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

@WebServlet(name = "UpdatePrescriptionServlet", value = "/updateprescription")
public class UpdatePrescriptionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        String presId_raw = request.getParameter("presId");
        try{
            int presId = Integer.parseInt(presId_raw);
            PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
            request.setAttribute("prescription",prescriptionDAO.getPrescriptionById(presId));
            request.setAttribute("appointmentList",appointmentDAO.getAppointment());
            request.setAttribute("statusList",new Config().getPrescriptionStatus());
            request.getRequestDispatcher("view/prescription/UpdatePrescription.jsp").forward(request,response);
        }catch (NumberFormatException e){
            System.out.println(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String presId_raw = request.getParameter("presId");
        String appointmentId_raw = request.getParameter("appointmentId");
        String pres = request.getParameter("pres");
        String note = request.getParameter("note");
        String status_raw = request.getParameter("status");

        try {
            int presId = Integer.parseInt(presId_raw);
            int appointmentId = Integer.parseInt(appointmentId_raw);
            int status = Integer.parseInt(status_raw);
            Prescription prescription = new Prescription(presId,appointmentId,pres,note,status);
            PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
            prescriptionDAO.updatePrescription(prescription);
            response.sendRedirect("updateprescription?presId="+presId+"&message=Successfully updated prescription");
        }catch (NumberFormatException e){
            System.out.println(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
