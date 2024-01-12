#lang racket
(require rackunit)
(require rackunit/text-ui)


(define quantidade-de-partes 5)
(define primeira-parte 1)

(define contexto-geral
  "Certo dia você estava programando tranquilamente, navegando na internet e decidiu que queria aprender uma linguagem nova. Assim, como sempre, foi pesquisar no google para achar algo interessante. Entao achou documentos relacionados a uma linguagem chamada racket e acabou clicando em um link duvidoso e tudo derrepente apagou...\n\nQuando voce percebeu estava acabando de acordar em uma maca, provavelmente tinha desmaiado. Você se assusta pois vem em sua direção um sátiro e ele te fala\n- Vem Percy a gente precisa da sua ajuda com a criptografia\nNovamente você se assusta e ao se olhar no espelho enquanto corria atrás do sátiro você percebe estar no filme PERCY JACKSON e ser o protagonista. Apesar de ser muito estranho e o filme não parecer com aquele que passou na sessão da tarde outro dia, você acaba se conformando e vai ajudar\n")

(define enunciados
  (list
   "Ao chegar em uma sala o sátiro(que é o seu melhor amigo grover) te diz\n- Olha é isso que ta aparecendo faz tempo. 'Nós sabemos que roubastes o raio de Zeus Percy Jackson filho de Poseidon. Entregue-o nessas coordenadas: 37.8102° N 22.     ° E Como a ultima coordenada foi cortada precisamos achar uma aproximação de onde poderia ser, achando os numeros perdidos\nPara ajuda-los e encontrar a coordenada mais proxima possivel responda o seguinte desafio.\nFaça a soma de uma sequência de seis números de 1 dígito para obter 30.\n"
   "Após conseguir a localização você, seu melhor amigo grover (o sátiro), e annabeth, filha de atena, partem em uma jornada para que possam encontrar o raio e devolvê-lo para os deuses. Acreditando que o raio esteja com hades, o deus do submundo, vocês vão em busca da entrada do submundo, porem são avisados de que antes teriam que encontrar as pérolas mágicas pois uma vez no submundo, conseguirão sair de la apenas com tais perolas. Luke, um amigo do acamamento lhe entrega um escudo, e o mapa de onde podem encontrar as perolas, além disso você também carrega consigo uma caneca mágica que se transforma em uma espada. A primeira perola está localizada em uma floricultura, o que parece ser muito facil para algo mágico.\n\nAo chegarem la voces percebem que tal floricultura é tambem onde se encontra medusa e ela é quem protege a perola. Após muita luta e dificuldades vocês derrotam a medusa e se deparam com a perola protegida em uma caixa magica e para abri-la vocês têm que responder corretamente a seguinte questão\nDesafio 1: O que representa o primeiro elemento de uma expressão simbólica em Racket?\nA) Um operando\nB) Uma função ou operador\nC) Um comentário\n"
   "Então depois disso seguem para o proximo local do mapa que seria um cassino. Chegando no cassino, você e seus amigos são muito bem recebidos(até demais) e são entregues flores, como biscoitinhos para vocês comerem, todos experimentam e acham muito gostosos.\nDepois de um tempo só aproveitando o cassino e tudo nele e comendo as flores você escuta uma voz em sua cabeça dizendo\n- Percy pare de comer essas flores elas estão te drogando e fazendo você perder a noção do tempo.\nAo ouvir isso você acredita ser seu pai, poseidon, falando te avisando sobre os perigos do local e sendo assim para de comer os biscoitos. Ao parar é perceptível que eles oferecem a todo momento esses biscoitos e voce vai atrás de seus amigos para q eles parem de comer também e voltem para a realidade.\n Voltando para a realidade voces lembram que este é o outro local em que existe uma perola escondida, correndo procurando por todo o local voces encontram uma porta com um desafio.\nDesafio: Qual é a principal vantagem de utilizar macros em Racket?\nA) Redução de erros de sintaxe\nB)  Possibilidade de criar novas construções de linguagem\nC) Melhoria na eficiência de execução\n"
   "Desafio: Em Racket, por que as estruturas de dados são geralmente imutáveis por padrão?\nA) Para aumentar a complexidade do código\nB)  Para facilitar a clareza do código e evitar efeitos colaterais inesperados\nC) Para melhorar o desempenho da execução\n"
   "Desafio: Considere a seguinte lista em Racket: (define minha-lista '(1 2 3 4 5)). Como pode ser adicionado o numero 6 no comeco dessa lista?\nA) (append minha-lista 6)\nB)  (cons 6 minha-lista)\nC) (add-final minha-lista 6)\n"
   ))

(define mensagens-questao-correta
  (list
   "\nVoce acertou, Parabens! O operador + pode ser utilizado com um numero variado de operandos\n\n"
   "\nVoce acertou, Parabens! O racket utiliza a notacao prefixada\n\n"
   "\nVoce acertou, Parabens! Macros sao uma abstracao de alto nivel, permitindo estender a linguagem\n\n"
   "\nVoce acertou, Parabens! Imutabilidade nao gera efeitos colaterais, tornando o codigo praticamento sem efeitos inesperados\n\n"
   "\nVoce acertou, Parabens!\n\n"
   ))

(define dicas
  (list
   
   (list "Para realizar uma soma, utilize o operador +\n"
         "Separe os elementos a serem somados por um espaco\n"
         "A linguagem reconhecera a soma dos elementos apenas se houver um parenteses indicando o inicio e fim da soma\n")
   
   (list "Lembre-se que a linguagem Racket utiliza a notacao prefixada"
         "Na notacao prefixada, os operandos aparecem apos o operador")
   
   (list "Imagine macros como uma forma de complementar o compilador\n")
   
   (list "Em linguagens nao funcionais as mudancas de estado sao um grandes causadores de erros no codigo.\n"
         "O paradigma funcional tenta resolver esse problema.\n")
   
   (list "Voce pode criar uma nova lista para realizar esta acao.\n"
         "Utilize o operador cons")
   ))


; Retorna o elemento de índice n da lista, sendo 0 o primeiro índice.
; n deve ser nao negativo.
(define (get-from-list lista n)
  (if (empty? lista)
      (void)
      (if (= n 0)
          (first lista)
          (get-from-list (rest lista) (sub1 n)))))


; Retorna a dica, dado a parte do jogo e a tentativa.
; Caso não haja mais dicas, printa uma mensagem amigavel.
(define (print-dica parte tentativa)
  (define dica (get-from-list (get-from-list dicas (sub1 parte)) (- tentativa 2)))
  (if (eq? dica (void))
      (display "Nao ha mais dicas!\n")
      (begin
        (display "Dica: ")
        (display dica))))


; Printa na saida padrao o enunciado da parte "part" do jogo
(define (print-enunciado part)
  (display (get-from-list enunciados (sub1 part))))


; Retorna true caso input é a resposta esperada de acordo com o enunciado 1
(define (check-input1 input)
  (and (list? input)
       (= (length input) 7)
       (= (apply + (cdr input)) 30)))

; Retorna true caso input é a resposta esperada de acordo com o enunciado 2
(define (check-input2 input)
  (or (equal? input 'B) (equal? input 'b)))


; Retorna true caso input é a resposta esperada de acordo com o enunciado 3
(define (check-input3 input)
  (or (equal? input 'B) (equal? input 'b)))

; Retorna true caso input é a resposta esperada de acordo com o enunciado 4
(define (check-input4 input)
  (or (equal? input 'B) (equal? input 'b)))

; Retorna true caso input é a resposta esperada de acordo com o enunciado 5
(define (check-input5 input)
  (or (equal? input 'B) (equal? input 'b)))


; Le da entrada padrao e retorna true se o usuário acertou a resposta
; do enunciado da parte "part", retorna false caso contrario.
(define (parse-input part)
  (define in (read))
  (cond
    [(= part 1) (check-input1 in)]
    [(= part 2) (check-input2 in)]
    [(= part 3) (check-input3 in)]
    [(= part 4) (check-input4 in)]
    [(= part 5) (check-input5 in)]
  ))


; Executa a parte "part" do jogo.
; Retorna true caso o usuário acertou a resposta,
; caso contário, retorna false.
(define (execute part tentativa)
  (begin
    (if (= tentativa 1)
        (print-enunciado part)
        (print-dica part tentativa))
    
    (define result (parse-input part))
    
    (if result
        (display (get-from-list mensagens-questao-correta (sub1 part)))
        (display "Resposta incorreta. Tente novamente.\n"))
    
    result))


; Executa todas as partes do jogo a partir de 'part'
(define (run-program2 part tentativa)
  (if (> part quantidade-de-partes)
      (displayln "Parabens, voce passou por todas as fases!")
      (let ([result (execute part tentativa)])
        (if result
            (run-program2 (add1 part) 1)
            (run-program2 part (add1 tentativa))))))


; Executa todas as parte do jogo.
(define run-program
  (begin
    (display contexto-geral)
    (run-program2 primeira-parte 1)))


(define all-tests
  (test-suite "all"
    (test-suite "outros"
      (check-equal? (get-from-list '(10 12 25 94 87 59) 0) 10)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 1) 12)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 2) 25)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 3) 94)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 4) 87)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 5) 59)
      (check-equal? (get-from-list '(10 12 25 94 87 59) 6) (void))
      )
    (test-suite "parte1"
      (check-equal? (check-input1 '(+ 5 5 5 5 5 5)) #t)
      (check-equal? (check-input1 '(+ 5 7 3 5 6 4)) #t)
      (check-equal? (check-input1 '(+ 5 5 5 5 5 1)) #f)
      (check-equal? (check-input1 '(+ 5 5 5 5 5 4 1)) #f)
      (check-equal? (check-input1 '(5 5 5 5 5 5)) #f)
      (check-equal? (check-input1 '()) #f)
      (check-equal? (check-input1 '(+ 10)) #f)
      (check-equal? (check-input1 '10) #f)
      )
    (test-suite "questoes-alternativas"
      (check-equal? (check-input2 'b) #t)
      (check-equal? (check-input2 'B) #t)
      (check-equal? (check-input2 'a) #f)
      (check-equal? (check-input2 'y) #f)
      (check-equal? (check-input2 '(+ 5 5)) #f)

      (check-equal? (check-input3 'b) #t)
      (check-equal? (check-input3 'B) #t)
      (check-equal? (check-input3 'a) #f)
      (check-equal? (check-input3 'y) #f)
      (check-equal? (check-input3 '(+ 5 5)) #f)

      (check-equal? (check-input4 'b) #t)
      (check-equal? (check-input4 'B) #t)
      (check-equal? (check-input4 'a) #f)
      (check-equal? (check-input4 'y) #f)
      (check-equal? (check-input4 '(+ 5 5)) #f)

      (check-equal? (check-input5 'b) #t)
      (check-equal? (check-input5 'B) #t)
      (check-equal? (check-input5 'a) #f)
      (check-equal? (check-input5 'y) #f)
      (check-equal? (check-input5 '(+ 5 5)) #f)
      )
    ))

(run-tests all-tests)

(provide run-program)
; (+ 5 5 5 5 5 5)