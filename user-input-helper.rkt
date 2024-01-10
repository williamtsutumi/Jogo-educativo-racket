#lang racket

(define-namespace-anchor anc)

(provide ns)
(define ns (namespace-anchor->namespace anc))


(define (compile-user-code sanitized-code)
  (with-handlers ([exn:fail? (lambda (exn)
                              (displayln (exn-message exn))
                              #f)])
    (eval sanitized-code ns)))

(provide compile-and-run)
(define (compile-and-run user-code)
  (let ([compiled-code (compile-user-code user-code)])
  (if compiled-code
      (apply compiled-code 2)
      (displayln "Invalid code input"))))

(compile-and-run '(define (add a b) (+ a b)))

(define add (void))