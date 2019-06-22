; Exercise 2.33. Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as accumulations:

(define (map p sequence)
  (accumulate (lambda (x y) <??>) nil sequence))
(define (append seq1 seq2)
  (accumulate cons <??> <??>))
(define (length sequence)
  (accumulate <??> 0 sequence))

; SOLUTION:

(define (map p sequence)
  (accumulate (lambda (x y) (cons x (p y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq1 seq2))

(define (length sequence)
  (accumulate (lambda (x) (+ x 1)) 0 sequence))
