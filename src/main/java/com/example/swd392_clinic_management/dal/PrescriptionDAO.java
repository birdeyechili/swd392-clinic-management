package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.model.PatientRecord;
import com.example.swd392_clinic_management.model.Prescription;
import com.example.swd392_clinic_management.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PrescriptionDAO extends DBUtil {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection = getConnection();
    public ArrayList<Prescription> getAllPrescription() {
        ArrayList<Prescription> list = new ArrayList<>();
        String sql = "SELECT * FROM Prescriptions";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Prescription p = new Prescription();
                p.setPresId(rs.getInt("presId"));
                p.setAppointId(rs.getInt("AppointId"));
                p.setNote(rs.getString("note"));
                p.setPres(rs.getString("pres"));
                p.setStatus(rs.getInt("status"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return list;
    }

}
