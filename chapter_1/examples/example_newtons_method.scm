;Newton's method:
;if x -> g(x) is a differnetiable funciton, then solution of the equation g(x) = 0 is a fixed point
;of function x -> f(x), where f(x) = r - g(x) / Dg(x) : Dg(x) is the derivative of g evaluated at x
; to implement Newton's method we have to define procedure for getting derivative

(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))


;e.g. of usage
(define (cube x) (* x x x))
((deriv cube) 5)
;75.00014999664018


;With the aid of deriv, we can express Newton's method as a fixed-point process:
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;with this new approach we can re-implement our square root function in more general way
(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))


;furthermore, we can notice that implementation of newtons method procedure can be abstracted to be even more general
;into the procedure of finding fixed point of transformed procedure
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))


;and then we can approach the problem of finding square root in two ways:
;one with average damping:
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

;and another with newtons method:
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))
