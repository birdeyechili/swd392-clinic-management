package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PatientRecord {
    private int recordId;
    private int patientId;
    private String record;
    private boolean status;

    public PatientRecord(int patientId, String record, boolean status) {
        this.patientId = patientId;
        this.record = record;
        this.status = status;
    }
}
