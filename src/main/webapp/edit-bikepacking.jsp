
<%@ page import="com.svalero.ardiyas.dao.Database" %>
<%@ page import="com.svalero.ardiyas.domain.Bikepacking" %>
<%@ page import="com.svalero.ardiyas.dao.BikepackingDao" %>
<%@ page import="com.svalero.ardiyas.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#edit-button").click(function (event) {
            event.preventDefault();
            const form = $("#edit-form")[0];
            const data = new FormData(form);

            $("#edit-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "edit-bikepacking",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#edit-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#edit-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<%
    if (!role.equals("admin")) {
        response.sendRedirect("/club");
    }

    int id;
    Bikepacking bikepacking = null;
    if (request.getParameter("id") == null) {
        // Se accede al formulario para crear una nueva actividad
        id = 0;
    } else {
        // Se accede al formulario para editar una actividad existente
        id = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        bikepacking = Database.jdbi.withExtension(BikepackingDao.class, dao -> dao.getBikepacking(id));
    }
%>

<main>
    <section class="py-5 container">
        <% if (id == 0) {%>
        <h1>Registrar bikepacking</h1>
        <% } else { %>
        <h1>Modificar bikepacking</h1>
        <% } %>
        <form class="row g-3 needs-validation" method="post" enctype="multipart/form-data" id="edit-form">
            <div class="mb-3">
                <label for="name" class="form-label">Bikepacking</label>
                <input type="text" name="name" class="form-control" id="name" placeholder="Nombre del bikepacking"
                    <% if (id !=0) { %> value="<%= bikepacking.getName() %>"<% } %>>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Descripción</label>
                <textarea rows="4" name="description" cols="50" class="form-control" id="description" placeholder="descripción del bikepacking">
<% if (id !=0) { %> <%= bikepacking.getDescription() %><% } %>
     </textarea>
            </div>
            <div class="col-md-4">
                <label for="date" class="form-label">Fecha</label>
                <input type="date" name="date" class="form-control" id="date" placeholder="dd/mm/yyyy"
                    <% if (id !=0) { %> value="<%=DateUtils.format(bikepacking.getDatetime()) %>"<% } %>>
            </div>

            <div class="col-md-4">
                <label for="price" class="form-label">Precio</label>
                <input type="text" name="price" class="form-control" id="price" placeholder="precio"
                    <% if (id !=0) { %> value="<%= bikepacking.getPrice() %>"<% } %>>
            </div>

            <div class="col-md-4">
                <label for="picture" class="form-label">Foto</label>
                <input type="file" name="picture" class="form-control" id="picture">
            </div>
            <div class="col-12">
                <input type="submit" value="Enviar" id="edit-button"/>
            </div>
            <input type="hidden" name="id" value="<%= id %>"/>
        </form>
        <br/>
        <div id="result"></div>
    </section>
</main>

<%@include file="includes/footer.jsp"%>


