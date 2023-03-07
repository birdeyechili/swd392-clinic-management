package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.model.PatientRecord;
import com.example.swd392_clinic_management.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecordDAO extends DBUtil {
    PreparedStatement ps;
    ResultSet rs;
    Connection connection = getConnection();

    public List<PatientRecord> searchRecords(int patientID) {
        List<PatientRecord> list = new ArrayList<>();
        String query = "select * from [PatientRecord] where patientID = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, patientID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PatientRecord(
                        rs.getInt("recordId"),
                        rs.getInt("patientId"),
                        rs.getString("record"),
                        rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<PatientRecord> getAllRecords() {
        List<PatientRecord> list = new ArrayList<>();
        String query = "select * from [PatientRecord]";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PatientRecord(
                        rs.getInt("recordId"),
                        rs.getInt("patientId"),
                        rs.getString("record"),
                        rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<PatientRecord> getRecordPaging(List<PatientRecord> list, int start, int end) {
        List<PatientRecord> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void addNewRecord(PatientRecord record) {
        String sql = "insert into [PatientRecord] values (?, ?, ?)";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, record.getPatientId());
            ps.setString(2, record.getRecord());
            ps.setBoolean(3, record.isStatus());
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateRecord(PatientRecord patientRecord) {
        String sql = "update PatientRecord set patientId=?, record=?, status=? where recordId=?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, patientRecord.getPatientId());
            ps.setString(2, patientRecord.getRecord());
            ps.setBoolean(3, patientRecord.isStatus());
            ps.setInt(4, patientRecord.getRecordId());

            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public PatientRecord getRecordById(int id) {
        PatientRecord record = null;
        String query = "select * from PatientRecord where recordId=?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                record = new PatientRecord(
                        rs.getInt("recordId"),
                        rs.getInt("patientId"),
                        rs.getString("record"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return record;
    }
}
