programa {
  funcao inicio() {
    //declaração de variáveis e atribuição de tipo
    cadeia nome 
    inteiro idade
    real nota1, nota2, media 
    logico status
    caracter turno 
    // atribuição de valores as variáveis 
    nome ="Mariana"
    idade = 27 
    nota1 = 9 
    nota2 = 10 
    turno = 'm'
    media= (nota1+nota2)/2
    status = (media>=7)
    // exibição de resultado no console
    escreva ("nome: ", nome)
    escreva ("\nIdade: ", idade, " anos") // \n= quebra de linha 
    escreva ("\nNota 1:", nota1, " pontos" )
    escreva("\nNota 2:",nota2, " pontos ")
    escreva("\nMédia: ",media, " pontos")
    escreva("\nTurno: ", turno )
    se(status){
      escreva ("\nstatus: Aprovado!")
    }senao{ 
      escreva ("\nstatus: Reprovado!")
  }
  }
}