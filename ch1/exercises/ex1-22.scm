; Exercise 1.22. Most Lisp implementations include a primitive called runtime that
; returns an integer that specifies the amount of time the system has been running
; (measured, for example, in microseconds).
; The following timed-prime-test procedure,
; when called with an integer n, prints n and checks to see if n is prime.
; If n is prime, the procedure prints three asterisks followed
; by the amount of time used in performing the test.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Using this procedure,
; write a procedure search-for-primes that checks the primality
; of consecutive odd integers in a specified range.
; Use your procedure to find the three smallest primes larger than 1000;
; larger than 10,000;
; larger than 100,000;
; larger than 1,000,000.
; Note the time needed to test each prime.
; Since the testing algorithm has order of growth of (n),
; you should expect that testing for primes around 10,000 should take about
; 10 times as long as testing for primes around 1000.
; Do your timing data bear this out?
; How well do the data for 100,000 and 1,000,000 support the n prediction?
; Is your result compatible with the notion that programs on your machine run
; in time proportional to the number of steps required for the computation?

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
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


; eg timed prime computation
; test function for prime is from previous example
; and computes with order of growth O(sqrt(n))
; use prime? as black box

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(define (search-for-primes bottom top)
    (define (search-iter cur)
        ((if (<= cur end)
            (timed-prime-test cur))
         (if (<= cur end)
            (search-iter (+ cur 2)))))
    (search-iter (if (even? start)
                     (start)
                     start)))
