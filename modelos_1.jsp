
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Catalogo</title>
        <link rel="stylesheet" href="css/segundo.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
         <!-- CSS de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- JavaScript de Bootstrap (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <nav class="navbar">
            <!-- div del logo -->
            <div class="navbar-center">
                <a class="navbar-brand" href="index.html"><img src="assets/img/navbar-logo.png" alt="Logo" style="width: 70px"></a>
            </div>

            <!-- Texto con desplazamiento -->
            <div class="navbar-left">
                <marquee behavior="scroll" direction="left" scrollamount="3">
                    Siempre cerca de ti, sin importar donde estes 
                </marquee>
            </div>

            <div class="navbar-right">
                <a href="registrar.html"><i class="fas fa-user"></i></a>
                <a href="carrito.jsp" class="cart-link">
    <i class="fas fa-shopping-cart" ></i>
</a>
                
                <a href="ofertas-dia.jsp"><i class="fas fa-tags"></i></a>
            </div>
        </nav>
        <br>
        <div class="container">
            <%!
                public JSONArray leerJson(String ruta) throws IOException {
                    StringBuilder contenido = new StringBuilder();
                    try {
                        BufferedReader br = new BufferedReader(new FileReader(ruta));
                        String linea;
                        while ((linea = br.readLine()) != null) {
                            contenido.append(linea);
                        }
                    } catch (Exception e) {
                        System.out.println("error" + e.getMessage());
                    }
                    return new JSONArray(contenido.toString());
                }
            %>

            <%

                String ruta = request.getServletContext().getRealPath("/WEB-INF/RESOURCES/catalogo-lentes.json");
                JSONArray array = leerJson(ruta);
                System.out.println(array);
            %>

            <%
                for (int i = 0; i < array.length(); i++) {
                    JSONObject producto = array.getJSONObject(i);

                    // Si es la primera iteración o una iteración múltiplo de 3, abrimos un nuevo contenedor cards-container
                    if (i == 0 || i % 3 == 0) {
            %>
            <div class="cards-container">
                <%
                    }
                %>
                <div class="card">
                    <img src="<%=producto.getString("img")%>" alt="<%=producto.getString("nombreProducto")%>" style="height: 337px; width:450px;">
                    <div class="card-info">
                        <p></p>
                        <h3><%=producto.getString("nombreProducto")%></h3>
                        <p>Precio: $ <%=producto.getFloat("precio")%></p>
                        <p><%=producto.getString("descripcion")%></p>
                        <p>Calificacion: <%=producto.getString("calificacion")%> <i class="fas fa-star" style="color: gold;"></i></p>
                        <br>
                        <button type="button" class="btn btn-secondary" onclick="guardarObjeto(<%=producto.getInt("id")%>)">
    <i class="fas fa-cart-plus"></i> Añadir
</button>
                    </div>
                    
                </div>
                <%
                    // Si es la tercera iteración o la última, cerramos el contenedor cards-container
                    if ((i + 1) % 3 == 0 || i == array.length() - 1) {
                %>
            </div>
            <br>
            <br>
            <%
                    }
                }
            %>


        </div>
            <script>
                function guardarObjeto(producto) {
        // Parseamos el string JSON a un objeto JavaScript
       
        var iniciar= localStorage.getItem("sesion");
        if(iniciar){
             var arregloCarrito = [];
        var datosStorage = localStorage.getItem("carrito");
        if(datosStorage){
            arregloCarrito = JSON.parse(datosStorage);
            var buscarId = arregloCarrito.find(function (elemento){
                return elemento.idProducto === producto;  
            });
            if(buscarId){
                console.log("YA EXISTE");
            }else{
               var productoObjectoLocal = {idProducto:producto};
               arregloCarrito.push(productoObjectoLocal);
               localStorage.removeItem("carrito");
            }
            
        }else{
           var productoObjecto = {idProducto:producto};
           arregloCarrito.push(productoObjecto); 
        }
        
        var arregloCarritoJson = JSON.stringify(arregloCarrito);
        localStorage.setItem("carrito",arregloCarritoJson);
        }
       else{
           alert("inicia sesion o registrate");
       }
    }
    var enlaceCarrito = document.querySelector(".cart-link");

// Agregar un manejador de eventos clic al enlace
enlaceCarrito.addEventListener("click", function(event) {
    event.preventDefault();
    var iniciar= localStorage.getItem("sesion");
        if(iniciar){
            window.location.replace("carrito.jsp");
            console.log("avanza");
        }else{
            alert("Debes iniciar sesion o registrarte");
        }

    
});
            </script>
    </body>
</html>