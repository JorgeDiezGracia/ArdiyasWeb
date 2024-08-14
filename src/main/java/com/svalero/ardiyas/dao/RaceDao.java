package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Race;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface RaceDao {

    @SqlQuery("SELECT * from races")
    @UseRowMapper(RaceMapper.class)
    List<Race> getAllRaces();

    @SqlQuery("SELECT * FROM races WHERE name LIKE CONCAT('%',:searchTerm,'%') " +
            "OR name LIKE CONCAT('%',:searchTerm,'%') OR description LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(RaceMapper.class)
    List<Race> getRaces(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM races WHERE id = ?")
    @UseRowMapper(RaceMapper.class)
    Race getRace(int id);

    @SqlUpdate("INSERT INTO races (name, description, distance, slope, datetime, price, picture) VALUES (?, ?, ?, ?, ?, ?, ?)")
    int addRace(String name, String description, String distance, String slope, Date date, float price, String picture);

    @SqlUpdate("UPDATE races SET name = ?, description = ?, distance = ?, slope = ?, datetime = ?, price = ?, picture = ? WHERE id = ?")
    int updateRace(String name, String description, String distance, String slope, Date date, float price, String picture, int id);


    @SqlUpdate("DELETE FROM races WHERE id = ?")
    int removeRace(int id);

}
