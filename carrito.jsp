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


        <style>
            .card {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                padding: 10px;
                border: 1px solid #ccc;
            }

            .card img {
                width: 60%;
                margin-right: 10%;
            }

            .card-info {
                flex-grow: 1;
            }

            .boton-eliminar {
                margin-left: auto;
            }

            #contenedor-total {
                margin-top: 20px;
                text-align: right;
            }

            #boton-pagar {
                margin-top: 10px;
            }

            #imagen-vacia {
                display: none;
                width: 30%;
                height: 100%;
                margin-left: 35%
            }

            .mensaje-vacio {
                text-align: center;
            }

            .card {
                border: 1px solid #ccc;
                border-radius: 5px;
                overflow: hidden;
                width: 50%;
            }
        </style>


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

                <a href="ofertas-dia.jsp"><i class="fas fa-tags"></i></a>
            </div>
        </nav>
        <br>
        <div class="container">
            <h2 style="text-align: center">Lista de Productos</h2>
            <br>
            <div class="container-fluid">
                <div>
                    <div class="row">
                        <div class="col-md-8">
                            <div id="contenedor-productos"></div>
                        </div>
                        <div class="col-md-4">
                            <div id="contenedor-total" style="display: none;">
                                <p style="font-size: xx-large">Total a pagar: $<span id="total-a-pagar">0</span></p>
                                <button   class="btn btn-success" id="boton-pagar" style="width: 100%">Pagar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <img id="imagen-vacia" src="IMG/FHsVhJ6hJV.gif" alt="Lista vacía">
            <p id="mensaje-vacio" class="mensaje-vacio">No hay productos disponibles</p>

            <script>
                // Datos de ejemplo
 var totalGeneral=0;
                var rutaJson = "http://localhost:8080/SMARTH_GLASSES/RESOURSES/catalogo-lentes_1.json";
                //var rutaJson = "https://montseosorio.github.io/lentes/RESOURSES/catalogo-lentes_1.json";
                var listaProductos = [];
                var solicitud = new XMLHttpRequest();
                solicitud.open('GET', rutaJson, true);

                solicitud.onload = function () {
                    if (solicitud.status >= 200 && solicitud.status < 400) {
                        var objectJSON = JSON.parse(solicitud.responseText);

                        var listaCtalogo = JSON.stringify(objectJSON);
                        localStorage.removeItem("catalogo");
                        localStorage.setItem("catalogo", listaCtalogo);

                        var datosStorage = localStorage.getItem("carrito");
                        if (datosStorage) {
                            var arregloCarrito = JSON.parse(datosStorage);
                            for (var i = 0; i < arregloCarrito.length; i++) {
                                var id = arregloCarrito[i].idProducto;
                                var datos = objectJSON.find(function (elemento) {
                                    return elemento.id === id; // Asumiendo que el campo en objectJSON se llama "id"
                                });
                                listaProductos.push(datos);
                            }
                            console.log(listaProductos);



                        }
                        mostrarProductos();
                    }
                };

                solicitud.onerror = function () {
                    console.log("ERROR");
                };

                solicitud.send();


                // Función para mostrar la lista de productos
                function mostrarProductos() {
                    var contenedorProductos = document.getElementById("contenedor-productos");
                    contenedorProductos.innerHTML = ""; // Limpiar el contenido anterior

                    var total = 0; // Inicializar el total a pagar

                    // Verificar si la lista de productos está vacía
                    if (listaProductos.length === 0) {
                        document.getElementById("imagen-vacia").style.display = "block";
                        document.getElementById("mensaje-vacio").style.display = "block";
                        document.getElementById("contenedor-total").style.display = "none"; // Ocultar el contenedor de total
                    } else {
                        document.getElementById("imagen-vacia").style.display = "none";
                        document.getElementById("mensaje-vacio").style.display = "none";
                        document.getElementById("contenedor-total").style.display = "block"; // Mostrar el contenedor de total

                        // Recorrer la lista de productos y generar el HTML para cada uno
                        listaProductos.forEach(function (producto) {
                            var card = document.createElement("div");
                            card.classList.add("card");

                            var imagen = document.createElement("img");
                            imagen.src = producto.img;
                            card.appendChild(imagen);

                            var cardInfo = document.createElement("div");
                            cardInfo.classList.add("card-info");

                            var nombreProducto = document.createElement("h3");
                            nombreProducto.textContent = producto.nombreProducto;
                            cardInfo.appendChild(nombreProducto);

                            var precio = document.createElement("p");
                            precio.textContent = "Precio: $" + producto.precio;
                            cardInfo.appendChild(precio);

                            card.appendChild(cardInfo);

                            var botonEliminar = document.createElement("button");
                            botonEliminar.textContent = "Eliminar";
                            botonEliminar.classList.add("btn", "btn-danger"); // Agregar las clases "btn" y "btn-danger"
                            botonEliminar.addEventListener("click", function () {
                                // Eliminar el producto de la listaProductos
                                var indice = listaProductos.indexOf(producto);
                                if (indice !== -1) {
                                    listaProductos.splice(indice, 1);
                                    
                                    // Eliminar el elemento del DOM
                                    card.remove();
                                    // Actualizar el total a pagar
                                    total -= producto.precio;
                                    totalGeneral=total;
                                    actualizarTotal(total);
                                    
                                }
                                
                                var nuevaLista = [];
                                for (var i = 0; i < listaProductos.length; i++) {
                                    var id = listaProductos[i].id;
                                    var datoPro = {idProducto:id};
                                    nuevaLista.push(datoPro);
                                }
                                
                                localStorage.removeItem("carrito");
                                var nuevo = JSON.stringify(nuevaLista);
                                localStorage.setItem("carrito",nuevo);
                            });
                            card.appendChild(botonEliminar);

                            contenedorProductos.appendChild(card);

                            // Actualizar el total a pagar
                            total += producto.precio;
                            totalGeneral=total;
                            actualizarTotal(total);
                        });
                    }
                }
               
                // Función para actualizar el total a pagar en el HTML
                function actualizarTotal(total) {
                    var spanTotal = document.getElementById("total-a-pagar");
                    spanTotal.textContent = total;
                    totalGeneral=total;
                }



                // Agregar evento al botón de pagar
                var botonPagar = document.getElementById("boton-pagar");
                botonPagar.addEventListener("click", function () {
                   
                   
                    console.log(totalGeneral);
                    
                    var objeto = {total: totalGeneral};
        var objetoJSON = JSON.stringify(objeto);
        localStorage.setItem("pago", objetoJSON);
                   
                  window.location.replace("pago.html");
                });
            </script>

    </body>
</html>