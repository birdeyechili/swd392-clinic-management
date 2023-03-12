package com.example.swd392_clinic_management.controller.PresciptionController;

import com.example.swd392_clinic_management.dal.PrescriptionDAO;
import com.example.swd392_clinic_management.model.Prescription;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PrescriptionListServlet", value = "/prescriptionList")
public class PrescriptionListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Prescription> list = new ArrayList<>();
        PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
        try {
            list = prescriptionDAO.getAllPrescriptions();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        log(list.size() + " items");
        request.setAttribute("presList", list);
        request.getRequestDispatcher("view/prescription/PrescriptionList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("searchInput"));
        List<Prescription> list = new ArrayList<>();
        PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
        try {
            Prescription p = prescriptionDAO.getPrescriptionById(id);
            if (p != null) {
                list.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        log(list.size() + " items");
        request.setAttribute("presList", list);
        request.getRequestDispatcher("view/prescription/PrescriptionList.jsp").forward(request, response);
    }
}
