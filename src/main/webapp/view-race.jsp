<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Race" %>
<%@ page import="com.svalero.ardiyas.dao.RaceDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@ page import="com.svalero.ardiyas.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container">
        <h1>Ver Carrera</h1>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Race race = Database.jdbi.withExtension(RaceDao.class, dao -> dao.getRace(id));
    %>

    <div class="card mb-3" style="max-width: 540px;">
        <div class="row g-0">
            <div class="col-md-8">
                <img src="../club_pictures/<%= race.getPicture() %>" class=img-fluid rounded-start/>
                <!--<img src="../club_pictures/ class=img-fluid rounded-start">-->
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%= race.getName()%></h5>
                    <p class="card-text"><%= race.getDescription()%></p>
                    <p class="card-text"><small class="text-body-secondary"><%= race.getDistance() + " kilómetros con " + race.getSlope() + " metros positivos" %></small></p>
                    <p class="card-text"><small class="text-body-secondary"><%= race.getDatetime() %></small></p>
                    <p class="card-text"><small class="text-body-secondary"><%= CurrencyUtils.format(race.getPrice()) %></small></p>
                    <a href="#" class="btn btn-primary">Inscribirse</a>
                </div>
            </div>
        </div>
    </div>
</section>

</main>

<%@include file="includes/footer.jsp"%>
