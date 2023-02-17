package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {
    private int userId;
    private String account;
    private String password;
    private String fullName;
    private int age;
    private String email;
    private int role;
    private String position;
    private boolean status;
}
