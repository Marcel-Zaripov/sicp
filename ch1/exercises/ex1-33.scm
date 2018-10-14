; Exercise 1.33. You can obtain an even more general version of accumulate (exercise 1.32) by
; introducing the notion of a filter on the terms to be combined.
; That is, combine only those terms derived from values in the range that satisfy a specified condition.
; The resulting filtered-accumulate abstraction takes the same arguments as accumulate,
; together with an additional predicate of one argument that specifies the filter.
; Write filtered-accumulate as a procedure. Show how to express the following using filtered-accumulate:

; a. the sum of the squares of the prime numbers in the interval a to b
; (assuming that you have a prime? predicate already written)

; b. the product of all the positive integers less than n
; that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).

; SOLUTION:

;dedfining filtered accumulation
;recursive
(define (filtered-accumulate combiner null-value term a next b filter)
    (if (> a b)
        null-value
        (if (filter a)
            (combiner (term a)
                      (filtered-accumulate filter combiner null-value term (next a) next b))
            (combiner null-value (filtered-accumulate filter combiner null-value term (next a) b)))))

;quite interesting that it can actually work without applying combining with null-value in the last clause
;checked against applicative order
(define (filtered-accumulate combiner null-value term a next b filter)
    (if (> a b)
        null-value
        (if (filter a)
            (combiner (term a)
                      (filtered-accumulate filter combiner null-value term (next a) next b))
            (filtered-accumulate filter combiner null-value term (next a) b))))



;iterative
(define (filtered-accumulate1 combiner null-value term a next b filter)
    ((define (iter a result)
        (if (> a b)
            result
            (if (filter a)
                (iter (next a) (combiner (term a) result))
                (iter (next a) result))))))


(define (inc n)
  (+ 1 n))

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

(define (id n)
  n)

(define (relative-prime? a b)
  (= 1 (gcd a b)))

(define (sum-square-prime a b)
  (filtered-accumulate + 0 square a inc b prime?))

(define (product-lt-n-prime n)
  (define (filter x)
    (relative-prime? x n))
  (filtered-accumulate * 1 id 1 inc n filter))
