; Exercise 1.27. Demonstrate that the Carmichael numbers
; listed in footnote 47 really do fool the Fermat test.
; That is, write a procedure that takes an integer n and tests whether an is congruent
; to a modulo n for every a<n, and try your procedure on the given Carmichael numbers.

; SOLUTION:

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (test a)
    (= (expmod a n n) a))
  (define (iter a)
    (if (< a n)
        (if (test a)
            (iter (+ a 1))
            #f)
        #t))
  (iter 1))


; we can successfully fool fermat-test with Carmichael numbers
; > (fermat-full 561)
; #t
; > (fermat-full 1105)
; #t
; > (fermat-full 1729)
; #t
; > (fermat-full 2465)
; #t
; > (fermat-full 2821)
; #t
; > (fermat-full 6601)
; #t