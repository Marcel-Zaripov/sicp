;we can modify example of finding fixed point of square root (in fact any function)
;with application of average damping in more general way and returning the function


;original fixed point finding solution
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


;this procedure will take procedure as input and return procedure
(define (average-damp f)
  (lambda (x) (average x (f x))))


;now, using the above procedure we modify procedure for function x -> x / y
;and find fixed point of that, i.e. where x = f(x)
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))


;helper for the next example
(define (square x)
    (* x x))


;we can apply our new procedure of avg damp to more examples
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))