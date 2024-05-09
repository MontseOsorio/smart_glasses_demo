/* global validarCmapo, parentElement */

const formRegister = document.querySelector(".form-register");
        const inputUser = document.querySelector(".form-register input[type='text']");
        const inputEmail = document.querySelector(".form-register input[type='email']");
        const inputPass = document.querySelector(".form-register input[type='password']");
        const alertaError = document.querySelector(".alerta-error");
        const alertaExito = document.querySelector(".alerta-exito");
        var yaSeCreo = true;
        const userNameRegex = /^[a-zA-Z0-9\_\-]{4,16}$/;
export const emailRegex = /^[a-zA-Z0-9_.+-]*@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
export const passwordRegex = /^.{4,12}$/;
        const estadoValidacionCampos = {
        userName:false,
                userEmail:false,
                userPassword:false,
                };
        document.addEventListener("DOMContentLoaded", () => {
        formRegister.addEventListener("submit", e => {
        e.preventDefault();
                enviarFormulario();
                });
//acceder
                inputUser.addEventListener("input", () => {
                validarCampo(userNameRegex, inputUser, "El usuario debe ser de 4 a 16 digitos y no puede contener guiones bajos");
                        });
                inputEmail.addEventListener("input", () => {
                validarCampo(emailRegex, inputEmail, "El correo debe contener un @,letras, números, puntos, guiones y guíon bajo.");
                        });
                inputPass.addEventListener("input", () => {
                validarCampo(passwordRegex, inputPass, "La contraseña tiene que ser de 4 a 12 dígitos");
                        });
                });
export function validarCampo(regularExpresion, campo, mensaje){
const validarCampo = regularExpresion.test(campo.value);
        console.log("ALERTA" + campo.value);
        console.log("regex" + regularExpresion);
        if (validarCampo){
eliminarAlerta(campo.parentElement.parentElement);
        estadoValidacionCampos[campo.name] = true;
        campo.parentElement.classList.remove("error");
        return;
}

estadoValidacionCampos[campo.name] = false;
        mostrarAlerta(campo.parentElement.parentElement, mensaje);
        campo.parentElement.classList.add("error");
}


function mostrarAlerta(referencia, mensaje){
eliminarAlerta(referencia);
        const alertaDiv = document.createElement("div");
        alertaDiv.classList.add("alerta");
        alertaDiv.textContent = mensaje;
        referencia.appendChild(alertaDiv);
        }
function eliminarAlerta(referencia){
const alerta = referencia.querySelector(".alerta");
        if (alerta){
alerta.remove();
}
}
function enviarFormulario(){
//aqui se va a validar el envio del formulario
if (estadoValidacionCampos.userName && estadoValidacionCampos.userEmail && estadoValidacionCampos.userPassword){
alertaExito.classList.add("alertaExito");
        alertaError.classList.remove("alertaError");
        var user = inputUser.value;
        var email = document.getElementById("correo").value;
        var pass = document.getElementById("password").value;
        formRegister.reset();
        setTimeout(() => {
        alertaExito.classList.remove("alertaExito");
        }, 3000);
        var objeto = {nombre: user, correo:email, password:pass, sesionActiva:true };
        var objetoJSON = JSON.stringify(objeto);
        localStorage.setItem("sesion", objetoJSON);
               window.location.replace("index.html");
        return;
}
alertaError.classList.add("alertaError");
        alertaExito.classList.remove("alertaExito");
        setTimeout (() => {
        alertaError.classList.remove("alertaError");
        }, 3000);
        }


    // Obtener la casilla de verificación y el botón de envío del formulario
    var checkbox = document.getElementById("flexCheckDefault");
    var botonEnviar = document.getElementById("botonEnviar");

    // Agregar un evento de cambio a la casilla de verificación
    checkbox.addEventListener("change", function() {
        // Si la casilla está marcada, habilitar el botón de envío del formulario
        if (checkbox.checked) {
            botonEnviar.disabled = false;
        } else {
            // Si la casilla no está marcada, deshabilitar el botón de envío del formulario
            botonEnviar.disabled = true;
        }
    });





