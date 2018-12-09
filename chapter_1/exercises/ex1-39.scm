;Exercise 1.39. A continued fraction representation of the tangent
; function was published in 1770 by the German mathematician J.H. Lambert:

; tan(r) = r / (1 - r^2 / (3 - r^2 / (5 - ...)))

; where x is in radians.
; Define a procedure (tan-cf x k) that computes an approximation
; to the tangent function based on Lambert's formula.
; K specifies the number of terms to compute, as in exercise 1.37.

; SOLUTION:

(define (square x) (* x x))

(define (tan-cf x k)
   (define (n k)
       (if (= k 1)
           x
           (- (square x))))
   (define (d k)
       (- (* 2 k) 1))
   (cont-frac n d k))


; rule for n -> if i = 1 then n(i) = x, otherwise x**2
; rule for d -> d(i) = 2i - 1


;(tan (/ pi 6))
;0.5773502691896257
;(tan-cf (/ pi 6) 10)
;0.5773502691896257
;(tan (/ pi 4))
;0.9999999999999999
;(tan-cf (/ pi 4) 10)
;1.0
;(tan (/ pi 3))
;1.7320508075688767
;(tan-cf (/ pi 3) 10)
;1.732050807568877