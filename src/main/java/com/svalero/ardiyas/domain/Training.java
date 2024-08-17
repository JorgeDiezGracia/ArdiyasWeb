package com.svalero.ardiyas.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Training {
    private int id;
    private String name;
    private String description;
    private Date datetime;
    private String type;
    private String picture;
}
