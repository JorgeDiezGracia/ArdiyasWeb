<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Race" %>
<%@ page import="com.svalero.ardiyas.dao.RaceDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@ page import="com.svalero.ardiyas.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container"style="display: flex">

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Race race = Database.jdbi.withExtension(RaceDao.class, dao -> dao.getRace(id));
    %>

    <div class="card mb-3" style="width: 18rem;">
        <div class="row g-0">
                <img src="../club_pictures/<%= race.getPicture() %>" class="img-fluid rounded-start"/>
            <div class="col-md-16">
                <div class="card-body">
                    <h5 class="card-title"><%= race.getName()%></h5>
                    <p class="card-text"><%= race.getDescription()%></p>
                    <p class="card-text"><small class="text-body-dark"><%= race.getDistance() + " kilómetros con " + race.getSlope() + " metros positivos" %></small></p>
                    <p class="card-text"><small class="text-body-dark"><%= "Fecha: " + race.getDatetime() %></small></p>
                    <p class="card-text"><small class="text-body-dark"><%= "Importe: " + CurrencyUtils.format(race.getPrice()) %></small></p>
                    <a href="#" class="btn btn-dark">Inscribirse</a>
                </div>
            </div>
        </div>
    </div>
</section>
</main>

<%@include file="includes/footer.jsp"%>
