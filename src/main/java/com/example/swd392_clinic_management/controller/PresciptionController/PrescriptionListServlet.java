package com.example.swd392_clinic_management.controller.PresciptionController;

import com.example.swd392_clinic_management.dal.PrescriptionDAO;
import com.example.swd392_clinic_management.model.Prescription;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "PrescriptionListServlet", value = "/PrescriptionListServlet")
public class PrescriptionListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Prescription> list = new ArrayList<>();
        PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
        list = prescriptionDAO.getAllPrescription();
        request.setAttribute("presList", list);
        request.getRequestDispatcher("view/prescriptions/PrescriptionList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
