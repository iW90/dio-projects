let button = document.getElementById('button'); 
let input1 = document.getElementById('input1');
let input2 = document.getElementById('input2');

function adicionarNumero(numero1: number, numero2: number, devePrintar: boolean, frase: string) {
    let resultado = numero1 + numero2;
    if(devePrintar) {
        console.log(frase + resultado);
    }
    return numero1 + numero2;
}

let devePrintar = true;
let frase = 'O valor é: ';

if (button) {
    button?.addEventListener('click', () => {
        if(input1 && input2) {
            console.log(adicionarNumero(Number(input1), Number(input2), devePrintar, frase));
        }
    });
}
