package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.model.PatientRecord;
import com.example.swd392_clinic_management.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecordDAO extends DBUtil{
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
}
