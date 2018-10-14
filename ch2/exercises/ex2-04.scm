; Exercise 2.4.  Here is an alternative procedural representation of pairs.

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; For this representation,
; verify that (car (cons x y)) yields x for any objects x and y.

; SOLUTION:

(define (print-pair p)
  (newline)
  (display "(")
  (display (car p))
  (display ",")
  (display (cdr p))
  (display ")"))



(define a (cons 1 2))
(print-pair a) ; -> outputs (1, 2) in the correct order
(car a) ; -> 1
(cdr b) ; -> 2

; according to substitution model
; when calling cons
; (cons 1 2)
; it renders into lambda procedure
; - > (lambda (m) (m 1 2))
; which accepts procedure as argument and applies it to 1 and 2
; 
; in the implementation of car and cdr
; we get the above procedure as argument:
; (car (lambda (m) (m 1 2)))
; which takes it and applies it to another lambda procedure:
; ((lambda (m) (m 1 2)) (lambda (p q) p))
; -> (lambda (lambda (p q) p) (m 1 2))
; rendering that into the body with substitution model:
; -> -> ((lambda (p q) p) 1 2)
; -> -> -> (lambda (1 2) 1)
; thus (car (cons 1 2)) >>> 1
; according implementation of cdr works the same way

