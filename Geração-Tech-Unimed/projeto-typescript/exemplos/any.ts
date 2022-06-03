let valorAny: any;

valorAny = 3;
valorAny = 'olá';
valorAny = true;

//valorAny é uma má prática

let valorString: string = 'teste';
valorString = valorAny;
let valorString2: string = 'textão';
valorString2 = valorAny;

function somarString(string1: string, string2: string) {
    console.log(string1 + string2);
}

somarString(valorString, valorString2);
somarString('Olá', ', como vai?');