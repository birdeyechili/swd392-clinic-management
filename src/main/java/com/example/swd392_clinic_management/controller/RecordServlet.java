package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.RecordDAO;
import com.example.swd392_clinic_management.model.PatientRecord;
import com.example.swd392_clinic_management.model.User;
import com.example.swd392_clinic_management.util.PaginationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RecordServlet", value = "/recordservlet")
public class RecordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        //TODO: Check only admin can access
//        //Fake user
        HttpSession session = request.getSession();
        User fakeUser = new User(1, "a", "1", "kien", 12, "kien@", 0, "ad", true);
        session.setAttribute("user", fakeUser);

        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) {
            request.setAttribute("error", "You must log in to access!");
            request.getRequestDispatcher("/authentication").forward(request, response);
            return;
        }
        if (loggedUser.getRole() != 0) {    //not admin -> not allow
            request.setAttribute("error", "You must log in as admin to access!");
            request.getRequestDispatcher("/authentication").forward(request, response);
            return;
        }

        //ACTION: add new record
        String tag = request.getParameter("tag");
        if (tag != null && tag.equals("add")) {
            request.getRequestDispatcher("view/record/AddRecord.jsp").forward(request, response);
            return;
        }
        //ACTION: update user
        RecordDAO dao = new RecordDAO();
        if (tag != null && tag.equals("update")) {
            String id = request.getParameter("id");
            PatientRecord patientRecord = dao.getRecordById(Integer.parseInt(id));
            request.setAttribute("record", patientRecord);
            request.getRequestDispatcher("view/record/UpdateRecord.jsp").forward(request, response);
            return;
        }
        //ACTION: view record list
        //1 Get data from db
        String searchInput = request.getParameter("searchInput");

        List<PatientRecord> list;
        if (searchInput != null) {
            request.setAttribute("searchInput", searchInput);
            System.out.println("input: " + searchInput);
            if (!searchInput.matches("[0-9]+")) {
                System.out.println("matched");
                list = dao.searchRecords(-1);
            } else {
                System.out.println("unmatched");
                list = dao.searchRecords(Integer.parseInt(searchInput));
            }
        } else {
            list = dao.getAllRecords();
        }
        System.out.println("list: " + list);

        String rawPageNumber = request.getParameter("curPage");
        PaginationUtil util = PaginationUtil.getStartAndEndIndex(list.size(), 5, rawPageNumber);
        List<PatientRecord> listPaging = dao.getRecordPaging(list, util.getStart(), util.getEnd());

        //2 Set data to jsp
        request.setAttribute("recordList", listPaging);
        request.setAttribute("num", util.getTotalPage());
        request.setAttribute("curPage", util.getCurrentPage());     //current page
        request.getRequestDispatcher("view/record/RecordList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String recordID = request.getParameter("recordId");
        String tag = request.getParameter("tag");
        String patientId = request.getParameter("patientId");
        String record = request.getParameter("record");
        boolean status = request.getParameter("status").equals("1");

        RecordDAO dao = new RecordDAO();

        if (tag.equals("add")) {
            HttpSession session = request.getSession();

            if (!patientId.isEmpty()) {
                PatientRecord patientRecord = new PatientRecord(Integer.parseInt(patientId), record, status);
                dao.addNewRecord(patientRecord);
                response.sendRedirect("recordservlet");
            } else {
                session.setAttribute("error", "Input patientID!");
                response.sendRedirect("recordservlet?tag=add");
            }

        } else if (tag.equals("update")) {
            HttpSession session = request.getSession();
            session.removeAttribute("error");

            if (!patientId.isEmpty()) {
                PatientRecord patientRecord = new PatientRecord(Integer.parseInt(recordID), Integer.parseInt(patientId), record, status);
                dao.updateRecord(patientRecord);
                response.sendRedirect("recordservlet");
            } else {
                session.setAttribute("error", "Input patientID!");
                response.sendRedirect("recordservlet?id="+recordID+"&tag=update");
            }
        }
    }
}
