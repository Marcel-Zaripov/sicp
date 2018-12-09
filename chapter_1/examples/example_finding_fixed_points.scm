;A number x is called a fixed point of a function f if x satisfies the equation f(x) = x.
;For some functions f we can locate a fixed point by beginning with an initial guess and applying f repeatedly

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point cos 1.0)
;.7390822985224023

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
;1.2587315962971173

;finding fixed-point is reminiscent to the process of finding square roots and the whole class of problems
;we need to find y such that y**2 = x, which is y*y = x, or y = x/y [f(y) = x/y, such that f(n) = n]
;translation of sqrt with fixed-point:

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

;but, the problem here is that the guess will not converge here and oscillate about the answer, but never get close
;the solution to this is average damping:

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
