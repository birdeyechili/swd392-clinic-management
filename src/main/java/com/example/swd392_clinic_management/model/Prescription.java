package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Prescription {
    private int presId;
    private int appointId;
    private String pres;
    private String note;
    private int status;
}
