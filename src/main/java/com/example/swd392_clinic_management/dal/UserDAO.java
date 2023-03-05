package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.model.User;
import com.example.swd392_clinic_management.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserDAO extends DBUtil {
    PreparedStatement ps;
    ResultSet rs;
    Connection connection = getConnection();

    public List<User> getUserList() {
        List<User> list = new ArrayList<>();
        String query = "select * from Users order by [Role]";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("userid"),
                        rs.getString("account"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getInt("age"),
                        rs.getString("email"),
                        rs.getInt("role"),
                        rs.getString("position"),
                        rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<User> getUserPaging(List<User> list, int start, int end) {
        List<User> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void addNewUser(User user) {
        String sql = "insert into Users values (?, ?, ?, ?, ?, ?, ?, ?)";

        String defaultPassword = "123";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, user.getAccount());
            ps.setString(2, defaultPassword);
            ps.setString(3, user.getFullName());
            ps.setInt(4, user.getAge());
            ps.setString(5, user.getEmail());
            ps.setInt(6, user.getRole());
            ps.setString(7, user.getPosition());
            ps.setBoolean(8, user.isStatus());

            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean updateUserDetail(User user) {
        String sql = "update Users set account=?, password=?, fullname=?, age=?, email=?, role=?, position=?, status=? where userid=?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, user.getAccount());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setInt(4, user.getAge());
            ps.setString(5, user.getEmail());
            ps.setInt(6, user.getRole());
            ps.setString(7, user.getPosition());
            ps.setBoolean(8, user.isStatus());
            ps.setInt(9, user.getUserId());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean emailExisted(int userId, String email){
        String sql = "select * from Users where email=?";
        if (userId != -1) sql = sql.concat(" and userid!=" + Integer.toString(userId));

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);

            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return true;
    }

    public boolean accountExisted(int userId, String account){
        String sql = "select * from Users where account=?";
        if (userId != -1) sql = sql.concat(" and userid!=" + Integer.toString(userId));

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, account);

            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return true;
    }

    public User getUserDetail(int id) {
        User user = null;
        String query = "select * from Users where userid=?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("userid"),
                        rs.getString("account"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getInt("age"),
                        rs.getString("email"),
                        rs.getInt("role"),
                        rs.getString("position"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public List<User> searchUser(String name, int role) {
        List<User> list = new ArrayList<>();
        String query = "select * from Users where fullname collate SQL_Latin1_General_CP1_CI_AS like ?";
        try {
            if (role != -1) query += " and role = " + role;
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("userid"),
                        rs.getString("account"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getInt("age"),
                        rs.getString("email"),
                        rs.getInt("role"),
                        rs.getString("position"),
                        rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
