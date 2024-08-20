
<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Race" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.ardiyas.dao.RaceDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>

<%@include file="includes/header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light"><strong>Club Ciclista Ardiyas</strong></h1>
        <p class="lead text-body-dark"><strong>Variedad de marchas cicloturistas no competitivas</strong></p>
        <p>
          <%
            if (role.equals("admin")) {
          %>
          <a href="edit-race.jsp" class="btn btn-dark my-2">Añadir marcha</a>
          <%
            }
          %>
          <a href="index-training.jsp" class="btn btn-dark my-2">Entrenamientos</a>

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
          List<Race> races = null;
          if (search.isEmpty()) {
            races = Database.jdbi.withExtension(RaceDao.class, dao -> dao.getAllRaces());
          } else {
            final String searchTerm = search;
            races = Database.jdbi.withExtension(RaceDao.class, dao -> dao.getRaces(searchTerm));
          }

          for (Race race : races) {
        %>

        <div class="col" style="display: flex">
          <div class="card shadow-sm" style="width: 24rem;">
            <img src="../club_pictures/<%= race.getPicture() %>" style="height: 16rem;"/>
            <div class="card-body">
              <p class="card-text"><strong><%=race.getName()%></strong></p>
              <p class="card-text"><%=race.getDescription()%></p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="view-race.jsp?id=<%= race.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Ver</a>
                  <%
                    if (role.equals("admin")) {
                  %>
                  <a href="edit-race.jsp?id=<%= race.getId() %>" type="button" class="btn btn-sm btn-outline-dark">Editar</a>
                  <a href="remove-race?id=<%= race.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
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