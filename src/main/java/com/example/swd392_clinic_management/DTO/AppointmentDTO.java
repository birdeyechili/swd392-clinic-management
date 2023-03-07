package com.example.swd392_clinic_management.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AppointmentDTO {
    private int appointId;
    private String patientName;
    private String doctorName;
    private Date time;
    private String note;
    private int status;
}
