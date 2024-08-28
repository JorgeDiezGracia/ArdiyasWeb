package com.svalero.ardiyas.dao;

import com.svalero.ardiyas.domain.Training;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface TrainingDao {

    @SqlQuery("SELECT * from trainings")
    @UseRowMapper(TrainingMapper.class)
    List<Training> getAllTrainings();

    @SqlQuery("SELECT * FROM trainings WHERE name LIKE CONCAT('%',:searchTerm,'%') " +
            "OR name LIKE CONCAT('%',:searchTerm,'%') OR description LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(TrainingMapper.class)
    List<Training> getTrainings(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM trainings WHERE id = ?")
    @UseRowMapper(TrainingMapper.class)
    Training getTraining(int id);

    @SqlUpdate("INSERT INTO trainings (name, description, datetime, type, picture) VALUES (?, ?, ?, ?, ?)")
    int addTraining(String name, String description, Date date, String type, String picture);

    @SqlUpdate("UPDATE trainings SET name = ?, description = ?, datetime = ?, type = ?, picture = ? WHERE id = ?")
    int updateTraining(String name, String description, Date date, String type, String picture, int id);

    @SqlUpdate("DELETE FROM trainings WHERE id = ?")
    int removeTraining(int id);


}
