; Exercise 1.35. Show that the golden ratio  (section 1.2.2) is a fixed point of
; the transformation x   1 + 1/x,
; and use this fact to compute  by means of the fixed-point procedure.

; SOLUTION:

;fixed point procedure
(define tolerance 0.000001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;phi or golden ratio can be found as fixed point of f(x) = 1 + 1/x
;If we multiply both sides by x we get:
;x^2 = x + 1
;x^2 - x - 1 = 0
;which is quadratic equation and can be solved to have roots:
;x = (-b +- sqrt(b**2 - 4ac)) / 2a }}}---->>> x = (1 +- sqrt(5)) / 2
;so there are two roots
;to find fixed point of it, ie f(x) = x
;we simply apply fixed-point to the function:
(define phi (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))