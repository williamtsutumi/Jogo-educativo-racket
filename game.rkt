#lang racket
(require rackunit)
(require rackunit/text-ui)


(define quantidade-de-partes 3)
(define primeira-parte 1)

(define enunciados
  (list
   "enunciado1"
   "enunciado2"
   "enunciado3"
   ))

(define dicas
  (list
   (list "Dica 1-1"
         "Dica 1-2"
         "Dica 1-3")
   
   (list "Dica 2-1"
         "Dica 2-2")
   
   (list "Dica 3-1"
         "Dica 3-2")
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
      (displayln "Nao ha mais dicas!")
      (displayln dica)))


; Printa na saida padrao o enunciado da parte "part" do jogo
(define (print-enunciado part)
  (displayln (get-from-list enunciados (sub1 part))))


; Retorna true caso input é a resposta esperada de acordo com o statement1
(define (check-input1 input)
   (and (list? input)
       (= (length input) 7)
       (= (apply + (cdr input)) 30)))


; Retorna true caso input é a resposta esperada de acordo com o statement2
(define (check-input2 input)
  #t)


; Retorna true caso input é a resposta esperada de acordo com o statement3
(define (check-input3 input)
  #t)


; Le da entrada padrao e retorna true se o usuário acertou a resposta
; do enunciado da parte "part", retorna false caso contrario.
(define (parse-input part)
  (define in (read))
  (cond
    [(= part 1) (check-input1 in)]
    [(= part 2) (check-input2 in)]
    [(= part 3) (check-input3 in)]
  ))


; Executa a parte "part" do jogo.
; Retorna true caso o usuário acertou a resposta,
; caso contário, retorna false.
(define (execute part tentativa)
  (begin
    (if (> tentativa 1)
        (display "Resposta incorreta. Tente novamente.\n")
        (if (> part 1)
            (display "Resposta correta! Parabéns!\n")
            (void)))

    (if (= tentativa 1)
        (print-enunciado part)
        (print-dica part tentativa))
    
    (parse-input part)))


; Executa todas as partes do jogo a partir de 'part'
(define (run-program2 part tentativa)
  (if (> part quantidade-de-partes)
      (displayln "Parabains")
      
      (let ([result (execute part tentativa)])
        (if result
            (run-program2 (add1 part) 1)
            (run-program2 part (add1 tentativa))))))


; Executa todas as parte do jogo.
(define run-program
  (run-program2 primeira-parte 1))


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

    #|
  (test-suite "parte2"
  (check-equal? "2"))

  (test-suite "parte3"
  (check-equal? "3"))
  |#
    ))

(define (execute-tests)
  (begin
    (run-tests all-tests)))

(execute-tests)

(provide run-program)
; (+ 5 5 5 5 5 5)