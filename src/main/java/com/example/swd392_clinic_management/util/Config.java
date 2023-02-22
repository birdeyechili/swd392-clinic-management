package com.example.swd392_clinic_management.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Config {

    private String [] listRole = {"admin", "patient", "doctor"};
    private String [] listAppointStatus = {"process", "accept", "deny", "finish"};

}
