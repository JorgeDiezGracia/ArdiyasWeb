package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Bikepacking;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface BikepackingDao {

    @SqlQuery("SELECT * from bikepackings")
    @UseRowMapper(BikepackingMapper.class)
    List<Bikepacking> getAllBikepackings();

    @SqlQuery("SELECT * FROM bikepacking WHERE name LIKE CONCAT('%',:searchTerm,'%') " +
            "OR name LIKE CONCAT('%',:searchTerm,'%') OR description LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(BikepackingMapper.class)
    List<Bikepacking> getBikepackings(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM bikepackings WHERE id = ?")
    @UseRowMapper(BikepackingMapper.class)
    Bikepacking getBikepacking(int id);

    @SqlUpdate("INSERT INTO bikepackings (name, description, datetime, price, picture) VALUES (?, ?, ?, ?, ?)")
    int addBikepacking(String name, String description, Date date, float price, String picture);

    @SqlUpdate("UPDATE bikepackings SET name = ?, description = ?, datetime = ?, price = ?, picture = ? WHERE id = ?")
    int updateBikepacking(String name, String description, Date date, float price, String picture, int id);


    @SqlUpdate("DELETE FROM bikepackings WHERE id = ?")
    int removeBikepacking(int id);


}
