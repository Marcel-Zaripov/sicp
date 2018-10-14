(define (sqrt x)

  ((define (square x)
      (* x x))

  (define (isGoodEnough g x)
      (< (abs (- (square g) x)) (/ g 10000)))

  (define (avg x y)
      (/ (+ x y) 2))

  (define (improvedGuess g x)
      (avg g (/ x g)))

  (define (sqrt-iter g x)
      (if (isGoodEnough g x)
          g
          (sqrt-iter (improvedGuess g x) x)))

  (sqrt-iter 1.0 x)))