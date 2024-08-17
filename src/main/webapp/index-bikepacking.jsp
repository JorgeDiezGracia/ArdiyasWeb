
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Bikepacking" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.ardiyas.dao.BikepackingDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">Club Ciclista Ardiyas</h1>
                <p class="lead text-body-dark">Próximos bikepackings</p>
                <p>
                    <%
                        if (role.equals("admin")) {
                    %>
                    <a href="edit-bikepacking.jsp" class="btn btn-dark my-2">Añadir bikepacking</a>
                    <%
                        }
                    %>
                    <a href="index-training.jsp" class="btn btn-dark my-2">Consulta entrenamientos</a>

                    <a href="index-bikepacking.jsp" class="btn btn-dark my-2">Próximos bikepackings</a>
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
                    List<Bikepacking> bikepackings = null;
                    if (search.isEmpty()) {
                        bikepackings = Database.jdbi.withExtension(BikepackingDao.class, dao -> dao.getAllBikepackings());
                    } else {
                        final String searchTerm = search;
                        bikepackings = Database.jdbi.withExtension(BikepackingDao.class, dao -> dao.getBikepackings(searchTerm));
                    }

                    for (Bikepacking bikepacking : bikepackings) {
                %>

                <div class="col">
                    <div class="card shadow-sm">
                        <img src="../club_pictures/<%= bikepacking.getPicture() %>"/>
                        <div class="card-body">
                            <p class="card-text"><strong><%=bikepacking.getName()%></strong></p>
                            <p class="card-text"><%=bikepacking.getDescription()%></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="view-bikepacking.jsp?id=<%= bikepacking.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Ver</a>
                                    <%
                                        if (role.equals("admin")) {
                                    %>
                                    <a href="edit-bikepacking.jsp?id=<%= bikepacking.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Editar</a>
                                    <a href="remove-bikepacking?id=<%= bikepacking.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Eliminar</a>
                                    <%
                                        }
                                    %>
                                </div>
                                <small class="text-body-dark"><%=bikepacking.getPrice()%></small>

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

