def solicitar_quantidade(tipo_pao):
    while True:
        try:
            entrada = input(f"Digite a quantidade de {tipo_pao}: ")
            qtd = int(entrada)
            if qtd >= 0:
                return qtd
            else:
                print("❌ Digite um número positivo.")
        except ValueError:
            print("❌ Valor inválido. Tente novamente.")

def main():

    preco_frances = 1.04
    preco_integral = 1.04
    preco_doce_liso = 1.08
    preco_doce_farofa = 1.11
    preco_forma = 0.95

    qtd_frances = qtd_integral = qtd_doce_liso = qtd_doce_farofa = qtd_forma = 0

    while True:
        print("""
------------ PADARIA ------------
[1] Pão Francês     - R$ 1.04
[2] Pão Integral    - R$ 1.04
[3] Pão Doce Liso   - R$ 1.08
[4] Pão Doce Farofa - R$ 1.11
[5] Pão de Forma    - R$ 0.95
[6] Finalizar Compra
---------------------------------
        """)

        escolha = input("Escolha sua opção (1 a 6): ")

        if not escolha.isdigit():
            print("❌ Digite um número válido.")
            continue

        opcao = int(escolha)

        if opcao == 1:
            qtd_frances += solicitar_quantidade("Pão Francês")
        elif opcao == 2:
            qtd_integral += solicitar_quantidade("Pão Integral")
        elif opcao == 3:
            qtd_doce_liso += solicitar_quantidade("Pão Doce Liso")
        elif opcao == 4:
            qtd_doce_farofa += solicitar_quantidade("Pão Doce Farofa")
        elif opcao == 5:
            qtd_forma += solicitar_quantidade("Pão de Forma")
        elif opcao == 6:
            print("Finalizando compra...\n")
            break
        else:
            print("⚠️ Opção inválida.")

    val_frances = qtd_frances * preco_frances
    val_integral = qtd_integral * preco_integral
    val_doce_liso = qtd_doce_liso * preco_doce_liso
    val_doce_farofa = qtd_doce_farofa * preco_doce_farofa
    val_forma = qtd_forma * preco_forma

    total = val_frances + val_integral + val_doce_liso + val_doce_farofa + val_forma

    print("------------ RECIBO ------------")
    if qtd_frances > 0:
        print(f"{qtd_frances} x Pão Francês     = R$ {val_frances:.2f}")
    if qtd_integral > 0:
        print(f"{qtd_integral} x Pão Integral    = R$ {val_integral:.2f}")
    if qtd_doce_liso > 0:
        print(f"{qtd_doce_liso} x Pão Doce Liso   = R$ {val_doce_liso:.2f}")
    if qtd_doce_farofa > 0:
        print(f"{qtd_doce_farofa} x Pão Doce Farofa = R$ {val_doce_farofa:.2f}")
    if qtd_forma > 0:
        print(f"{qtd_forma} x Pão de Forma     = R$ {val_forma:.2f}")
    print(f"\nTOTAL A PAGAR: R$ {total:.2f}")
    print("--------------------------------")

if __name__ == "__main__":
    main()
