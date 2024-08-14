package com.svalero.ardiyas.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class User {

    private int id;
    private String name;
    private String surname;
    private String username;
    private String password;
    private String role;

}
