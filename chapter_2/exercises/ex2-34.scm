; Exercise 2.34. Evaluating a polynomial in x at a given value of x can be formulated as an accumulation.
; We evaluate the polynomial

; a[n]^x + a[n-1]^x-1 + ... + a[1]^x + a[0]

; using a well-known algorithm called Horner's rule, which structures the computation as
; (...(a[n]x + a[n-1])x + ... a[1])x + a[0]

; In other words, we start with an, multiply by x, add an-1, multiply by x, and so on, until we reach a[0].
; Fill in the following template to produce a procedure that evaluates a polynomial using Horner's rule.
; Assume that the coefficients of the polynomial are arranged in a sequence, from a0 through an.

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) <??>)
              0
              coefficient-sequence))

; For example, to compute 1 + 3x + 5x^3 + x^5 at x = 2 you would evaluate

(horner-eval 2 (list 1 3 0 5 0 1))

; SOLUTION:

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coef (* x higher-terms)))
              0
              coefficient-sequence))


; Computing 1 + 3x + 5x^3 + x^5 at x = 2
(horner-eval 2 (list 1 3 0 5 0 1))
; -> 79

; only possible to work with provided implementation of accumulate:
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
    (accumulate op initial (cdr sequence)))))
      
; and not going to work with iterative (fold-left), because we produce result bottom up here
; whereas horner method does multiplications for the growing coefficients
(define (accumulate-i op initial sequence)
  (if (null? sequence)
      initial
      (accumulate-i op (op initial (car sequence)) (cdr sequence))))
