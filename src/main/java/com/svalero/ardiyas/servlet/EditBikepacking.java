package com.svalero.ardiyas.servlet;

import com.svalero.ardiyas.dao.Database;
import com.svalero.ardiyas.dao.BikepackingDao;
import com.svalero.ardiyas.util.DateUtils;
import org.apache.commons.lang3.math.NumberUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.UUID;

import static com.svalero.ardiyas.util.ErrorUtils.sendError;
import static com.svalero.ardiyas.util.ErrorUtils.sendMessage;

@WebServlet("/edit-bikepacking")
@MultipartConfig

public class EditBikepacking extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") != null) {
            if (!currentSession.getAttribute("role").equals("admin")) {
                response.sendRedirect("/club");
            }
        }

        try {
            if (hasValidationErrors(request, response))
                return;
            int id = 0;
            if (request.getParameter("id") != null) {
                id = Integer.parseInt(request.getParameter("id"));
            }

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Date date = DateUtils.parse(request.getParameter("date"));
            float price = Float.parseFloat(request.getParameter("price"));
            Part picturePart = request.getPart("picture");

            String imagePath = request.getServletContext().getInitParameter("image-path");
            String filename = null;
            if (picturePart.getSize() == 0) {
                filename = "no-image.jpg";
            } else {
                filename = UUID.randomUUID() + ".jpg";
                InputStream fileStream = picturePart.getInputStream();
                Files.copy(fileStream, Path.of(imagePath + File.separator + filename));
            }

            Database.connect();
            final String finalFilename = filename;
            if (id == 0) {
                int affectedRows = Database.jdbi.withExtension(BikepackingDao.class,
                        dao -> dao.addBikepacking(name, description, date, price, finalFilename));
                sendMessage("Actividad registrada correctamente", response);
            } else {
                final int finalId = id;
                int affectedRows = Database.jdbi.withExtension(BikepackingDao.class,
                        dao -> dao.updateBikepacking(name, description, date, price, finalFilename, finalId));
                sendMessage("Actividad modificada correctamente", response);
            }
        } catch (ParseException pe) {
            pe.printStackTrace();
            sendError("El formato de fecha o precio no es correcto", response);
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            sendError("Internal Server Error", response);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            sendError("Error conectando con la base de datos", response);
        }
    }

    private boolean hasValidationErrors(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean hasErrors = false;
        try {
            String name = request.getParameter("name");
            if ( name.trim().length() ==0) {
                sendError("El nombre es un campo obligatorio", response);
                hasErrors = true;
                return hasErrors;
            }
            DateUtils.parse(request.getParameter("date"));

            if (!DateUtils.validate(request.getParameter("date"))) {
                sendError("Formato de fecha no válida", response);
                hasErrors = true;
                return hasErrors;
            }

            if (!NumberUtils.isCreatable(request.getParameter("price"))) {
                sendError("Formato de precio no válido", response);
                hasErrors = true;
                return hasErrors;
            }

            if (Float.parseFloat(request.getParameter("price")) < 0) {
                sendError("El precio no puede ser negativo", response);
                hasErrors = true;
                return hasErrors;
            }
        } catch (ParseException pe) {
            sendError("Formato de fecha no válido", response);
            hasErrors = true;
        }
        return hasErrors;
    }
}
