package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.DTO.AppointmentDTO;
import com.example.swd392_clinic_management.model.Appointment;
import com.example.swd392_clinic_management.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class AppointmentDAO extends DBUtil {
    PreparedStatement ps;
    ResultSet rs;
    Connection connection = getConnection();

    public List<AppointmentDTO> getAppointmentDTOPaging(List<AppointmentDTO> list, int start, int end) {
        List<AppointmentDTO> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<AppointmentDTO> getAppointment() {
        List<AppointmentDTO> list = new ArrayList<>();
        String query = "select AppointId, u1.fullname as 'patientName', u2.fullname as 'doctorName', a.time, note, a.status from Appointment a\n" +
                "join Users u1 on u1.userid = a.patientId\n" +
                "join Users u2 on u2.userid = a.doctorId";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new AppointmentDTO(
                        rs.getInt("AppointId"),
                        rs.getString("patientName"),
                        rs.getString("doctorName"),
                        rs.getTimestamp("time"),
                        rs.getString("note"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<AppointmentDTO> getAppointmentDTOByUserId(int userId) {
        List<AppointmentDTO> list = new ArrayList<>();
        String query = "select AppointId, u1.fullname as 'patientName', u2.fullname as 'doctorName', a.time, note, a.status from Appointment a\n" +
                "join Users u1 on u1.userid = a.patientId\n" +
                "join Users u2 on u2.userid = a.doctorId\n" +
                "where patientId = ? or doctorId = ?\n";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new AppointmentDTO(
                        rs.getInt("AppointId"),
                        rs.getString("patientName"),
                        rs.getString("doctorName"),
                        rs.getTimestamp("time"),
                        rs.getString("note"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<AppointmentDTO> searchAppointmentDTO(List<AppointmentDTO> list, String searchKey, int status) {
        return list.stream()
                .filter(a ->
                        (status == -1 || a.getStatus() == status) &&
                                (a.getPatientName().toLowerCase().contains(searchKey.toLowerCase()) ||
                                        a.getDoctorName().toLowerCase().contains(searchKey.toLowerCase()))
                ).collect(Collectors.toList());
    }

    public AppointmentDTO getAppointmentDetails(int appointmentId) {
        AppointmentDTO appointment = null;
        String query = "select AppointId, u1.fullname as 'patientName', u2.fullname as 'doctorName', u2.position, a.time, note, a.status from Appointment a\n" +
                "join Users u1 on u1.userid = a.patientId\n" +
                "join Users u2 on u2.userid = a.doctorId\n" +
                "where a.AppointId = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, appointmentId);
            rs = ps.executeQuery();
            if (rs.next()) {
                appointment = new AppointmentDTO(
                        rs.getInt("AppointId"),
                        rs.getString("patientName"),
                        rs.getString("doctorName"),
                        rs.getTimestamp("time"),
                        rs.getString("note"),
                        rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return appointment;
    }


    public void updateAppointment(Appointment appointment) {
        String query = "update Appointment set doctorId = ?, time = ?, note = ?, status = ? where AppointId = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, appointment.getDoctorId());
            ps.setTimestamp(2, new Timestamp(appointment.getTime().getTime()));
            ps.setString(3, appointment.getNote());
            ps.setInt(4, appointment.getStatus());
            ps.setInt(5, appointment.getAppointId());
            int n = ps.executeUpdate();
//            System.out.println(n);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void requestAppointment(Appointment appointment) {
        String query = "insert into Appointment values (?,?,?,?,?)"; //patientId, docId, time, note, status
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setTimestamp(3, new Timestamp(appointment.getTime().getTime()));
            ps.setString(4, appointment.getNote());
            ps.setInt(5, appointment.getStatus());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
