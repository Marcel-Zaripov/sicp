; Exercise 2.28. Write a procedure fringe that takes as argument a tree
; (represented as a list) and returns a list whose elements are
; all the leaves of the tree arranged in left-to-right order.
; For example,

(define x (list (list 1 2) (list 3 4)))

(fringe x)
; (1 2 3 4)

(fringe (list x x))
; (1 2 3 4 1 2 3 4)

; SOLUTION:

; recursive
(define (fringe items)
  (if (null? items)
      (list)
      (if (pair? (car items))
          (append (fringe (car items)) (fringe (cdr items)))
          (cons (car items) (fringe (cdr items))))))


; ((1 2) (3 4))
(fringe x)
; -> (1 2 3 4)

(define y (list (list 1 (list 2 3)) (list 4 (list 5) 6)))

; ((1 (2 3)) (4 (5) 6))
(fringe y)
(1 2 3 4 5 6)

; iterative
; Does not work on some interpreters for some reason
(define (fringe items)
  (define (iter it result)
    (if (null? it)
        result
        (if (pair? (car it))
            (iter (cdr it) (append result (fringe (car it))))
            (iter (cdr it) (append result (list (car it)))))))
  (iter items (list))

(fringe x)
