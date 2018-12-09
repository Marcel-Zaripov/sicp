; Exercise 2.22. Louis Reasoner tries to rewrite the first
; square-list procedure of exercise 2.21 so that
; it evolves an iterative process:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Unfortunately, defining square-list this way produces
; the answer list in the reverse order of the one desired. Why?

; Louis then tries to fix his bug by interchanging
; the arguments to cons:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

; This doesn't work either. Explain.

; SOLUTION:

; In the first case, it goes in reverse order,
; because the aggregate answer is put first into cons,
; meaning that we are appending newly squared items at
; the end of the list.
; However if you simple switch the parameters,
; cons will be constructing pairs,
; creating this output:
; -> ((((() . 1) . 4) . 9) . 16)

; to avoid that, we need to use this:
; ; (append (list (car items)) answer)
; or in the procedure:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append (list (car items))
                       answer))))
  (iter items (list)))
