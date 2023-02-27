package com.example.swd392_clinic_management.controller;

import com.example.swd392_clinic_management.dal.UserDAO;
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

@WebServlet(name = "UserServlet", value = "/userlist")
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        //TODO: Check only admin can access
        //Fake user
        HttpSession session = request.getSession();
        User fakeUser = new User(1, "a", "1", "kien", 12, "kien@", 0, "ad", true);
        session.setAttribute("loggedUser", fakeUser);

        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            request.setAttribute("error", "You must log in to access!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        if (loggedUser.getRole() != 0) {    //not admin -> not allow
            request.setAttribute("error", "You must log in as admin to access!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        //ACTION: add new user
        String tag = request.getParameter("tag");
        if (tag != null && tag.equals("add")){
            request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
            return;
        }
        //ACTION: update user
        UserDAO dao = new UserDAO();
        if (tag != null && tag.equals("update")){
            String id = request.getParameter("id");
            User user = dao.getUserById(Integer.parseInt(id));
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/user/UserDetail.jsp").forward(request, response);
            return;
        }
        //ACTION: view user list
        //1 Get data from db
        String searchName = request.getParameter("searchName");
        String role_raw = request.getParameter("role");

        List<User> list;
        if (searchName != null || role_raw != null){
            int role = -1;
            if (!role_raw.equals("") && role_raw != null) {
                role = Integer.parseInt(role_raw);
                request.setAttribute("role", role);
            }
            if (searchName == null) searchName = "";
            else request.setAttribute("searchName", searchName);
            list = dao.searchUser(searchName, role);
        } else {
            list = dao.getAllUsers();
        }

        String rawPageNumber = request.getParameter("curPage");
        PaginationUtil util = PaginationUtil.getStartAndEndIndex(list.size(), 6, rawPageNumber);
        List<User> listPaging = dao.getUserPaging(list, util.getStart(), util.getEnd());

        //2 Set data to jsp
        request.setAttribute("userList", listPaging);
        request.setAttribute("num", util.getTotalPage());
        request.setAttribute("curPage", util.getCurrentPage());     //current page
        request.getRequestDispatcher("view/user/UserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String userId_raw = request.getParameter("userId");
        String tag = request.getParameter("tag");
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        int role = Integer.parseInt(request.getParameter("role"));
        String position = request.getParameter("position");
        boolean status = request.getParameter("status").equals("1");

        UserDAO dao = new UserDAO();

        if (tag.equals("add")){
            if (dao.emailExisted(-1, email)) {
                addUserInputToRequest(request, account, name, age, email, position, role, status);
                request.setAttribute("error", "Email existed");
                request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
                return;
            }
            if (dao.accountExisted(-1, account)){
                addUserInputToRequest(request, account, name, age, email, position, role, status);
                request.setAttribute("error", "Account existed");
                request.getRequestDispatcher("view/user/AddNew.jsp").forward(request, response);
                return;
            }

            User user = User.builder()
                    .account(account)
                    .fullName(name)
                    .age(age)
                    .email(email)
                    .role(role)
                    .position(position)
                    .status(status)
                    .build();

            dao.addNewUser(user);
            response.sendRedirect("userlist");

        } else if (tag.equals("update")) {
            HttpSession session = request.getSession();
            session.removeAttribute("error");
            int userId = Integer.parseInt(userId_raw);
            if (dao.emailExisted(userId, email)) {
                session.setAttribute("error", "Email existed");
                response.sendRedirect("userlist?id="+userId_raw+"&tag=update");
                return;
            }
            if (dao.accountExisted(userId, account)){
                session.setAttribute("error", "Email existed");
                response.sendRedirect("userlist?id="+userId_raw+"&tag=update");
                return;
            }
            User user = User.builder()
                    .userId(userId)
                    .account(account)
                    .password(password)
                    .fullName(name)
                    .age(age)
                    .email(email)
                    .role(role)
                    .position(position)
                    .status(status)
                    .build();

            dao.updateUser(user);
            response.sendRedirect("userlist");
        }
    }

    private void addUserInputToRequest(HttpServletRequest request, String account, String name, int age, String email, String position, int role, boolean status){
        request.setAttribute("account", account);
        request.setAttribute("name", name);
        request.setAttribute("age", age);
        request.setAttribute("email", email);
        request.setAttribute("position", position);
        request.setAttribute("role", role);
        request.setAttribute("status", status);
    }
}
