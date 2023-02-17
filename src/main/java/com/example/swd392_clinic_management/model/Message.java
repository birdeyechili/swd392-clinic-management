package com.example.swd392_clinic_management.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Message {
    private int messId;
    private int senderId;
    private int receiverId;
    private String text;
    private boolean status;
}
