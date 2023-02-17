package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Payment {
    private int paymentId;
    private int appointId;
    private String method;
    private float total;
    private String note;
    private boolean status;
}
