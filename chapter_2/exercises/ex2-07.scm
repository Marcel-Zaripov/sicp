; Exercise 2.7. Alyssa's program is incomplete because
; she has not specified the implementation of the interval abstraction.
; Here is a definition of the interval constructor:

(define (make-interval a b) (cons a b))
; Define selectors upper-bound and lower-bound to complete the implementation.

; SOLUTION

(define (make-interval a b) (cons a b))

(define (lower-bound int) (car int))

(define (upper-bound int) (cdr int))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
