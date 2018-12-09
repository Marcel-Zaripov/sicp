;GCD
;Euclid's Algorithm as a procedure
;O(log(n))
;according to Lame's Theorem
;if k is # of steps to compute gcd of a and b
;then b >= fib(k)
;which in turn proves order of growth

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))



;gros as O(sqrt(n))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))



;Fermat test method based on
;Fermat's Little Theorem
;grows as O(log(n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))


(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
