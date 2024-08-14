package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Race;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RaceMapper implements RowMapper<Race> {

    @Override
    public Race map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Race(rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getString("distance"),
                rs.getString("slope"),
                rs.getDate("datetime"),
                rs.getFloat("price"),
                rs.getString("picture"));
    }
}
