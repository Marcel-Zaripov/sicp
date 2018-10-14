; Exercise 1.29. Simpson's Rule is a more accurate method of numerical integration
; than the method illustrated above.
; Using Simpson's Rule, the integral of a function f between a and b is approximated as

; h/3 * [y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_n-2 + 4y_n-1 + y_n]

; where h = (b - a)/n, for some even integer n, and yk = f(a + kh).
; (Increasing n increases the accuracy of the approximation.)
; Define a procedure that takes as arguments f, a, b,
; and n and returns the value of the integral, computed using Simpson's Rule.
; Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000),
; and compare the results to those of the integral procedure shown above.

; SOLUTION:

; simpson's rule to compute integral
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (cube x) (* x x x))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (yk k)
    (f (+ a (* k h))))
  (define (term k)
    (* (cond ((= 0 k) 1)
          ((= n k) 1)
          ((even? k) 2)
          (else 4)) 
       (yk k)))
  (define (inc x)
    (+ 1 x))
  (/ (* h (sum term 0 inc n)) 3))
