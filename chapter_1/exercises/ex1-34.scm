; Exercise 1.34. Suppose we define the procedure

(define (f g)
  (g 2))

; Then we have

(f square)
4

(f (lambda (z) (* z (+ z 1))))
6

; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

; SOLUTION:

(define (f g)
  (g 2))

; the procedure call is as follows:
(f f)
(f 2)
(2 2)
; when evaluating (2 2), the interpreter will raise an error,
; since 2 is not applicable