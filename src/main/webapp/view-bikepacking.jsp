<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Bikepacking" %>
<%@ page import="com.svalero.ardiyas.dao.BikepackingDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@ page import="com.svalero.ardiyas.util.DateUtils" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container"style="display: flex">

        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Database.connect();
            Bikepacking bikepacking = Database.jdbi.withExtension(BikepackingDao.class, dao -> dao.getBikepacking(id));
        %>

        <div class="card mb-3" style="width: 18rem;">
            <div class="row g-0">
                    <img src="../club_pictures/<%= bikepacking.getPicture() %>" class=img-fluid rounded-start/>
                <div class="col-md-16">
                    <div class="card-body">
                        <h5 class="card-title"><%= bikepacking.getName()%></h5>
                        <p class="card-text"><%= bikepacking.getDescription()%></p>
                        <p class="card-text"><%= CurrencyUtils.format(bikepacking.getPrice())%></p>
                        <p class="card-text"><small class="text-body-dark"><%= bikepacking.getDatetime() %></small></p>
                        <a href="#" class="btn btn-dark">Apuntarse</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@include file="includes/footer.jsp"%>
