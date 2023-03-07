package com.example.swd392_clinic_management.model;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Appointment {
    private int appointId;
    private int patientId;
    private int doctorId;
    private Date time;
    private String note;
    private int status;
}
