programa {
  funcao inicio() {
    // Declaração de variáveis
    cadeia nome 
    inteiro idade
    real nota1, nota2, media 
    logico status
    caracter turno

    // Entrada de dados
    escreva("\nDigite seu nome: ")
    leia(nome)

    escreva("\nDigite sua idade: ")
    leia(idade)

    escreva("\nDigite seu turno (M para manhã, T para tarde, N para noite): ")
    leia(turno)

    escreva("\nDigite sua nota 1: ")
    leia(nota1)

    escreva("\nDigite sua nota 2: ")
    leia(nota2)

    // Processamento
    media = (nota1 + nota2) / 2
    escreva ("media:", media)
    se (media >= 7) {
      status = verdadeiro
    } senao {
      status = falso
    }

    // Saída de dados
    escreva("\n--- RESULTADO ---\n")
    escreva("Nome: ", nome, "\n")
    escreva("Idade: ", idade, "\n")
    escreva("Turno: ", turno, "\n")
    escreva("Média: ", media, "\n")
    escreva("Status: ")

    se (status) {
      escreva("Aprovado\n")
    } senao {
      escreva("Reprovado\n")
    }
  }
}