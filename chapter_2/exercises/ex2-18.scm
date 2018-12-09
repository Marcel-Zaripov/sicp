; Exercise 2.18. Define a procedure reverse that
; takes a list as argument and returns a list of
; the same elements in reverse order:

(reverse (list 1 4 9 16 25))
; -> (25 16 9 4 1)

; SOLUTION:

; recursive
(define (reverse items)
  (if (null? items)
      (list)
      (append (reverse (cdr items)) (list (car items)))))

; iterative
(define (reverse items)
  (define (rev-iter i r)
    (if (null? i)
        r
        (rev-iter (cdr i) (append (list (car i)) r))))
  (rev-iter items (list)))


(reverse (list 1 4 9 16 25))
; -> (25 16 9 4 1)

