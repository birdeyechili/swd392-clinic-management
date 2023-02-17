package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Time;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Appointment {
    private int appointId;
    private int patientId;
    private int doctorId;
    private Time time;
    private String note;
    private boolean status;
}
