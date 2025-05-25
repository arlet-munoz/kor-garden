const nav = document.querySelector('.navegador');
const listaBox = document.querySelector('.lista-box');
const listaBoxCaja1 = document.querySelector('.lista-box-caja1');
const listaBoxCaja2 = document.querySelector('.lista-box-caja2');
window.addEventListener('scroll', function () {
    if (window.scrollY > 60) { // Cuando bajas más de 30px
        nav.classList.add('small');
        listaBox.classList.add('small');
        listaBoxCaja1.classList.add('small');
        listaBoxCaja2.classList.add('small');
    } else {
        nav.classList.remove('small');
        listaBox.classList.remove('small');
        listaBoxCaja1.classList.remove('small');
        listaBoxCaja2.classList.add('small');
    }
});