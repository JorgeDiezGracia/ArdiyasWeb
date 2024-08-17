package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Bikepacking;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BikepackingMapper implements RowMapper<Bikepacking> {

    @Override
    public Bikepacking map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Bikepacking(rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDate("datetime"),
                rs.getFloat("price"),
                rs.getString("picture"));
    }
}
