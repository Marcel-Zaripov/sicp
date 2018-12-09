; Exercise 2.14. Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions.
; Make some intervals A and B, and use them in computing the expressions A/A and A/B.
; You will get the most insight by using intervals whose width is a small percentage of the center value.
; Examine the results of the computation in center-percent form (see exercise 2.12).

; SOLUTION

(define (par1 r1 r2)
   (div-interval (mul-interval r1 r2)
                 (add-interval r1 r2)))

(define (par2 r1 r2)
   (let ((one (make-interval 1 1)))
      (div-interval one
                    (add-interval (div-interval one r1)
                                  (div-interval one r2)))))


(define (print-interval i)
  (display "[")
  (display (lower-bound i))
  (display " . ")
  (display (upper-bound i))
  (display "]")
  (newline)
)

(define A (make-center-width 100 .05))
(define B (make-center-width 200 .02))
(define AA (div-interval A A)) ; should be one, but is not
(define AB (div-interval A B))
(define APB1 (par1 A B))
(define APB2 (par2 A B))

(print-interval A)
(print-interval B)
(print-interval AA) ; confirms that calculation with a variable depended on itself yields incorrect results
;                     this expression should result into interval with center at one
(print-interval AB)
(print-interval APB1) ;---\
;                          }---> both those expressions should yield equal results 
(print-interval APB2) ;---/      as they are both calculated from algebraic expressions,
;                                but the results are not equal 
