; Exercise 2.1. Define a better version of make-rat that handles both positive and negative arguments.
; Make-rat should normalize the sign so that if the rational number is positive,
; both the numerator and denominator are positive,
; and if the rational number is negative, only the numerator is negative.

; SOLUTION:

(define (remainder x y)
  (- x (* y (floor (/ x y)))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


; lowest term version of make-rat is used as base
;(define (make-rat n d)
;  (let ((g (gcd n d)))
;    (cons (/ n g) (/ d g))))

(define (make-rat n d)
  (let ((s (/ n d)))
        (let ((num (* (abs n) (/ s (abs s))))
              (den (abs d)))
              (let ((g (gcd num den)))
                    (cons (/ num g) (/ den g))))))

; second option:
(define (make-rat n d)
  (define (sign x)
    (if (< x 0)
        -
        +))
  (let ((g (gcd n d)))
    (cons ((sign (/ n d)) (abs (/ n g)))
          (abs (/ d g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))


(define half (make-rat 3 -6))

(print-rat half)
