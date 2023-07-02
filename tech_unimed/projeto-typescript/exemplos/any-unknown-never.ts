let anyEstaDeVolta: any;
anyEstaDeVolta = 3;
anyEstaDeVolta = 'teste';
anyEstaDeVolta = 5;

let stringTeste: string = 'verificar';
stringTeste = anyEstaDeVolta;

let unknowwnValor: unknown;
unknowwnValor = 3;
unknowwnValor = 'opa';
unknowwnValor = true;
unknowwnValor = 'vai sim';

let stringTeste2: string = 'agora vai';
// stringTeste2 = unknowwnValor;

if (typeof unknowwnValor === 'string') {
	stringTeste2 = unknowwnValor ;
}

//

function jogaErro(erro: string, codigo: number): never {
    throw {error: erro, code: codigo}
}

jogaErro('deu erro', 500);