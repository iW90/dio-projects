# Operações
def depositar(saldo, extrato):
	valor = float(input("Informe o valor do depósito: \n"))
	if valor > 0:
		saldo += valor
		extrato += f"Depósito: R$ {valor:.2f}\n"
	else:
		print("Valor inválido.")
	return saldo, extrato

def sacar(saldo, extrato, limite, numero_saques):
	valor = float(input("Informe o valor de saque: "))
	excedeu_saldo = valor > saldo
	excedeu_limite = valor > limite
	excedeu_saques = numero_saques >= LIMITE_SAQUES

	if excedeu_saldo:
		print("Você não possui saldo suficiente.")
	elif excedeu_limite:
		print("Você excedeu o limite de saque.")
	elif excedeu_saques:
		print("Você excedeu a quantidade de saques.")
	elif valor > 0:
		saldo -= valor
		extrato += f"Saque: R$ {valor:.2f}\n"
		numero_saques += 1
	else:
		print("Operação inválida.")
	return saldo, extrato, numero_saques

def extrato_bancario(saldo, extrato):
	center = "EXTRATO"
	print(center.center(50, "-"))
	print("Não foram realizadas movimentações." if not extrato else extrato)
	print(f"Saldo: R$ {saldo:.2f}")
	center = ""
	print(center.center(50, "-"))

# Dicionário mapeando as operações para suas funções correspondentes
opcoes = {
	"d": depositar,
	"s": sacar,
	"e": extrato_bancario
}

saldo = 0
limite = 500
extrato = ""
numero_saques = 0
LIMITE_SAQUES = 3

while True:
	menu = """
	[d] Depositar
	[s] Sacar
	[e] Extrato
	[q] Sair
	=> """
	
	opcao = input(menu)
	if opcao == "q":
		break
	elif opcao in opcoes:
		saldo, extrato, numero_saques = opcoes[opcao](saldo, extrato, limite, numero_saques)
	else:
		print("Operação inválida, por favor, selecione a operação desejada.")
