package com.example.swd392_clinic_management.model;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
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
