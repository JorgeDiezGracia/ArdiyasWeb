
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Training" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.ardiyas.dao.TrainingDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light"><strong>Club Ciclista Ardiyas</strong></h1>
                <p class="lead text-body-dark"><strong>Entrenamientos de resistencia, potencia, fuerza y agilidad </strong></p>
                <p>
                    <%
                        if (role.equals("admin")) {
                    %>
                    <a href="edit-training.jsp" class="btn btn-dark my-2">Añadir entrenamiento</a>
                    <%
                        }
                    %>
                    <a href="index.jsp" class="btn btn-dark my-2">Carreras</a>

                    <a href="index-bikepacking.jsp" class="btn btn-dark my-2">Bikepackings</a>
                </p>
            </div>
        </div>
        <form class="row g-2" id="search-form" method="GET">
            <div class="mb-1">
                <input type="text" class="form-control" placeholder="Búsqueda" name="search" id="search-input">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-dark mb-3" id="search-button">Buscar</button>
            </div>
        </form>
    </section>

    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <%
                    String search = "";
                    if (request.getParameter("search") != null)
                        search = request.getParameter("search");

                    Database.connect();
                    List<Training> trainings = null;
                    if (search.isEmpty()) {
                        trainings = Database.jdbi.withExtension(TrainingDao.class, dao -> dao.getAllTrainings());
                    } else {
                        final String searchTerm = search;
                        trainings = Database.jdbi.withExtension(TrainingDao.class, dao -> dao.getTrainings(searchTerm));
                    }

                    for (Training training : trainings) {
                %>

                <div class="col" style="display: flex";>
                    <div class="card shadow-sm" style="width: 24rem;">
                        <img src="../club_pictures/<%= training.getPicture() %>" style="height: 15rem;"/>
                        <div class="card-body">
                            <p class="card-text"><strong><%=training.getName()%></strong></p>
                            <p class="card-text"><%=training.getDescription()%></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="view-training.jsp?id=<%= training.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Ver</a>
                                    <%
                                        if (role.equals("admin")) {
                                    %>
                                    <a href="edit-training.jsp?id=<%= training.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Editar</a>
                                    <a href="remove-training?id=<%= training.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                                    <%
                                        }
                                    %>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            </div>
        </div>
</main>

<%@include file="includes/footer.jsp"%>
