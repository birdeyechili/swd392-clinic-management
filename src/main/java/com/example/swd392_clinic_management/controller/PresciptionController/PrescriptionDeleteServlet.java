package com.example.swd392_clinic_management.controller.PresciptionController;

import com.example.swd392_clinic_management.dal.PrescriptionDAO;
import com.example.swd392_clinic_management.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "PrescriptionDeleteServlet", value = "/PrescriptionDeleteServlet")
public class PrescriptionDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
        try {
            boolean check = prescriptionDAO.deletePrescription(id);
            response.sendRedirect("PrescriptionListServlet"+"?message=Successfully deleted prescription");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
