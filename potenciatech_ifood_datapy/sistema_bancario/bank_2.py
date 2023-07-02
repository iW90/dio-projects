import textwrap

def menu():
	menu_options = {
		"d": "Depositar",
		"s": "Sacar",
		"e": "Extrato",
		"nc": "Nova conta",
		"lc": "Listar contas",
		"nu": "Novo usuário",
		"q": "Sair"
	}

	print("\n================ MENU ================")
	for key, value in menu_options.items():
		print(f"[{key}]\t{value}")

	return input("=> ")


def main():
	LIMITE_SAQUES = 3
	AGENCIA = "0001"

	saldo = 0
	limite = 500
	extrato = ""
	numero_saques = 0
	usuarios = []
	contas = []

	menu_options = {
		"d": lambda: depositar(saldo, float(input("Informe o valor do depósito: ")), extrato),
		"s": lambda: sacar(saldo=saldo, valor=float(input("Informe o valor do saque: ")),
						extrato=extrato, limite=limite, numero_saques=numero_saques,
						limite_saques=LIMITE_SAQUES),
		"e": lambda: exibir_extrato(saldo, extrato=extrato),
		"nc": lambda: nova_conta(AGENCIA, usuarios, contas),
		"lc": lambda: listar_contas(contas),
		"nu": lambda: criar_usuario(usuarios)
	}

	while True:
		opcao = menu()

		if opcao in menu_options:
			menu_options[opcao]()
		elif opcao == "q":
			break
		else:
			print("Operação inválida, por favor selecione novamente a operação desejada.")


def depositar(saldo, valor, extrato):
	if valor > 0:
		saldo += valor
		extrato += f"Depósito:\tR$ {valor:.2f}\n"
		print("\n=== Depósito realizado com sucesso! ===")
	else:
		print("\n@@@ Operação falhou! O valor informado é inválido. @@@")

	return saldo, extrato

def sacar(*, saldo, valor, extrato, limite, numero_saques, limite_saques):
	excedeu_saldo = valor > saldo
	excedeu_limite = valor > limite
	excedeu_saques = numero_saques >= limite_saques

	if excedeu_saldo:
		print("\n@@@ Operação falhou! Você não tem saldo suficiente. @@@")
	elif excedeu_limite:
		print("\n@@@ Operação falhou! O valor do saque excede o limite. @@@")
	elif excedeu_saques:
		print("\n@@@ Operação falhou! Número máximo de saques excedido. @@@")
	elif valor > 0:
		saldo -= valor
		extrato += f"Saque:\t\tR$ {valor:.2f}\n"
		numero_saques += 1
		print("\n=== Saque realizado com sucesso! ===")
	else:
		print("\n@@@ Operação falhou! O valor informado é inválido. @@@")

	return saldo, extrato

def exibir_extrato(saldo, /, *, extrato):
	print("\n================ EXTRATO ================")
	print("Não foram realizadas movimentações." if not extrato else extrato)
	print(f"\nSaldo:\t\tR$ {saldo:.2f}")
	print("=========================================")

def criar_usuario(usuarios):
	cpf = input("Informe o CPF (somente número): ")
	usuario = filtrar_usuario(cpf, usuarios)

	if usuario:
		print("\n@@@ Já existe usuário com esse CPF! @@@")
		return

	nome = input("Informe o nome completo: ")
	data_nascimento = input("Informe a data de nascimento (dd-mm-aaaa): ")
	endereco = input("Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): ")

	usuarios.append({"nome": nome, "data_nascimento": data_nascimento, "cpf": cpf, "endereco": endereco})

	print("=== Usuário criado com sucesso! ===")

def filtrar_usuario(cpf, usuarios):
	usuarios_filtrados = [usuario for usuario in usuarios if usuario["cpf"] == cpf]
	return usuarios_filtrados[0] if usuarios_filtrados else None

def criar_conta(agencia, numero_conta, usuarios):
	cpf = input("Informe o CPF do usuário: ")
	usuario = filtrar_usuario(cpf, usuarios)

	if usuario:
		print("\n=== Conta criada com sucesso! ===")
		return {"agencia": agencia, "numero_conta": numero_conta, "usuario": usuario}

	print("\n@@@ Usuário não encontrado, fluxo de criação de conta encerrado! @@@")

def listar_contas(contas):
	for conta in contas:
		linha = f"""\
			Agência:\t{conta['agencia']}
			C/C:\t\t{conta['numero_conta']}
			Titular:\t{conta['usuario']['nome']}
		"""
		print("=" * 100)
		print(textwrap.dedent(linha))

def nova_conta(agencia, usuarios, contas):
	numero_conta = len(contas) + 1
	conta = criar_conta(agencia, numero_conta, usuarios)

	if conta:
		contas.append(conta)

main()