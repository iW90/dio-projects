menu = """
[d] Depositar
[s] Sacar
[e] Extrato
[q] Sair
=> """

saldo = 0
limite = 500
extrato = ""
numero_saques = 500
LIMITE_SAQUES = 3

while True:
	opcao = input(menu)
	if opcao == "d":
		valor = float(input("Informe o valor do depósito: \n"))
	
		if valor > 0:
			saldo += valor
			extrato = f"deposito: R$ {valor:.2f}\n"
		else:
			print("Valor inválido.")
	elif opcao == "s":
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
			extrato == f"Saque: R$ {valor:.2f}\n"
			numero_saques + 1
		else:
			print("Operação inválida.")
	elif opcao == "e":
		center = "EXTRATO"
		print(center.center(50,"-"))
		print("Não foram realizadas movimentações." if not extrato else extrato)
		print(f"Saldo: R$ {saldo:.2f}")
		center = ""
		print(center.center(50,"-"))
	elif opcao == "q":
		break
	else:
		print("Operação invalida, por favor, selecione a operação desejada.")


# Fonte: Fórum DIO.