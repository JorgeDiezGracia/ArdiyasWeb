<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Training" %>
<%@ page import="com.svalero.ardiyas.dao.TrainingDao" %>
<%@ page import="com.svalero.ardiyas.util.CurrencyUtils" %>
<%@ page import="com.svalero.ardiyas.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container"style="display: flex">


        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Database.connect();
            Training training = Database.jdbi.withExtension(TrainingDao.class, dao -> dao.getTraining(id));
        %>

        <div class="card mb-3" style="width: 18rem;">
            <div class="row g-0">
                <!--<div class="col-md-8">-->
                    <img src="../club_pictures/<%= training.getPicture() %>" class=img-fluid rounded-start/>
                    <!--<img src="../club_pictures/ class=img-fluid rounded-start">-->
                <!--</div>-->
                <div class="col-md-16">
                    <div class="card-body">
                        <h5 class="card-title"><%= training.getName()%></h5>
                        <p class="card-text"><%= training.getDescription()%></p>
                        <p class="card-text"><%= training.getType()%></p>
                        <p class="card-text"><small class="text-body-secondary"><%= training.getDatetime() %></small></p>
                        <a href="#" class="btn btn-dark">Descargar entrenamiento</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<%@include file="includes/footer.jsp"%>
