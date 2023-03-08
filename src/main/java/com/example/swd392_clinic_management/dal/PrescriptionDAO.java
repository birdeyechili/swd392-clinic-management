package com.example.swd392_clinic_management.dal;

import com.example.swd392_clinic_management.model.Prescription;
import com.example.swd392_clinic_management.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO {
    public Prescription getPrescriptionById(int presId) throws SQLException{
        try(Connection connection = new DBUtil().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT appointId,pres,note,status FROM Prescriptions WHERE presId = ?")){
            preparedStatement.setInt(1,presId);
            try(ResultSet resultSet = preparedStatement.executeQuery()){
                if(resultSet.next()){
                    int appointId = resultSet.getInt("appointId");
                    String pres = resultSet.getString("pres");
                    String note = resultSet.getString("note");
                    int status = resultSet.getInt("status");
                    return new Prescription(presId,appointId,pres,note,status);
                }else return null;
            }
        }
    }

    public boolean addPrescription(Prescription prescription) throws SQLException{
        try(Connection connection = new DBUtil().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO Prescriptions (appointId,pres,note,status)" +
                    "VALUES (?,?,?,?)");){
            preparedStatement.setInt(1,prescription.getAppointId());
            preparedStatement.setString(2,prescription.getPres());
            preparedStatement.setString(3,prescription.getNote());
            preparedStatement.setInt(4,prescription.getStatus());
            return preparedStatement.executeUpdate()>0;
        }
    }

    public boolean updatePrescription(Prescription prescription) throws SQLException{
        try(Connection connection = new DBUtil().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE Prescriptions SET " +
                    "appointId=?,pres=?,note=?,status=? " +
                    "WHERE presId = ?");){
            preparedStatement.setInt(1,prescription.getAppointId());
            preparedStatement.setString(2,prescription.getPres());
            preparedStatement.setString(3,prescription.getNote());
            preparedStatement.setInt(4,prescription.getStatus());
            preparedStatement.setInt(5,prescription.getPresId());
            return preparedStatement.executeUpdate()>0;
        }
    }

    public List<Prescription> getAllPrescriptions() throws SQLException {
        try(Connection connection = new DBUtil().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT presId,appointId,pres,note,status FROM Prescriptions")){
            try(ResultSet resultSet = preparedStatement.executeQuery()){
                List<Prescription> prescriptionList = new ArrayList<>();
                while (resultSet.next()){
                    int presId = resultSet.getInt("presId");
                    int appointId = resultSet.getInt("appointId");
                    String pres = resultSet.getString("pres");
                    String note = resultSet.getString("note");
                    int status = resultSet.getInt("status");
                    prescriptionList.add(new Prescription(presId,appointId,pres,note,status));
                }
                return prescriptionList;
            }
        }
    }
}
