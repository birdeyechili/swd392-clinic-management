package com.example.swd392_clinic_management.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Config {

    private String [] listRole = {"admin", "patient", "doctor"};
    private String [] listAppointStatus = {"accept", "process", "deny", "finish"};
    private String [] prescriptionStatus = {"Inactive","Active"};

}
