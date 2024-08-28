package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Training;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TrainingMapper implements RowMapper<Training> {
    @Override
    public Training map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Training(rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDate("datetime"),
                rs.getString("type"),
                rs.getString("picture"));
    }
}
