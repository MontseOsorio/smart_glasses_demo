/* global validarCmapo, parentElement */
import { validarCampo, emailRegex, passwordRegex } from "./register.js";
const formLogin=document.querySelector(".form-login");
const inputEmail=document.querySelector(".form-login input[type='email']");
const inputPass=document.querySelector(".form-login input[type='password']");
const alertaError=document.querySelector(".form-login .alerta-error");
const alertaExito=document.querySelector("form-login .alerta-exito");
var yaSeCreo = true;

document.addEventListener("DOMContentLoaded",()=>{
formLogin.addEventListener("submit", e => {
    e.preventDefault();
    enviarFormulario();
});

//acceder

inputEmail.addEventListener("input",() =>{
  validarCampo(emailRegex,inputEmail,"El correo debe contener un @,letras, números, puntos, guiones y guíon bajo."); 

});
inputPass.addEventListener("input",() =>{
  validarCampo(passwordRegex,inputPass,"La contraseña tiene que ser de 4 a 12 dígitos"); 

});

});

function enviarFormulario(){
        var arregloUsuario = [];
    var email = document.getElementById("userEmail").value;
        var pass = document.getElementById("userPassword").value;    

      
        var usuarioStorage = localStorage.getItem("users");
        if(usuarioStorage){
            arregloUsuario = JSON.parse(usuarioStorage);
            var buscarusuario = arregloUsuario.find(function (elemento){
                return elemento.correo === email && elemento.password===pass;  
            });
            if(buscarusuario){
                console.log("YA EXISTE");
                 var objeto = {nombre: buscarusuario.nombre, correo:email, password:pass, sesionActiva:true };
        var objetoJSON = JSON.stringify(objeto);
        localStorage.setItem("sesion", objetoJSON);
        window.location.replace("index.html");
            }else{
               alert("El correo y/o la contraseña no existen");
            } 
       
    }
    }

