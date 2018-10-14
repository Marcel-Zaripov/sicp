; Exercise 1.45. We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of y -> x/y does not converge,
; and that this can be fixed by average damping.
; The same method works for finding cube roots as fixed points of the average-damped y -> x/y2.
; Unfortunately, the process does not work for fourth roots -- 
; a single average damp is not enough to make a fixed-point search for y -> x/y3 converge.
; On the other hand, if we average damp twice (i.e., use the average damp of the average damp of y -> x/y3)
; the fixed-point search does converge.
; Do some experiments to determine how many average damps are required to compute nth roots
; as a fixed-point search based upon repeated average damping of y -> x/yn-1.
; Use this to implement a simple procedure for computing nth roots using fixed-point,
; average-damp, and the repeated procedure of exercise 1.43.
; Assume that any arithmetic operations you need are available as primitives.

; SOLUTION:

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f x)
  (if (= x 1)
      f
      (compose f (repeated f (- x 1)))))

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


;we will implement procedure for finding n-th root of number

(define (nth-root x n)
  (fixed-point
     (average-damp
        (lambda (y) (/ x (expt y (- n 1)))))
     1.0))

;average damping works as we expect and allows us to converge to the answer
;for the roots of power up to 3
(nth-root 100 2)
;10.0
(nth-root 1000 3)
;10.000002544054729

;however, power 4 does not converge
;(nth-root 1000 3)
;this will never stop

;modifying procedure to repeat average damp twice helps with convergence
;for powers up to 8
(define (nth-root x n)
  (fixed-point
     ((repeated average-damp 2)
        (lambda (y) (/ x (expt y (- n 1)))))
     1.0))


(nth-root 10000 4)
;10.0
(nth-root 100000 5)
;9.99999869212542
(nth-root 1000000 6)
;9.999996858149522
(nth-root 10000000 7)
;9.9999964240619

;we can start to notice the pattern that with doubling n we need to add one more average-damping:
(define (nth-root x n)
  (fixed-point
     ((repeated average-damp 3)
        (lambda (y) (/ x (expt y (- n 1)))))
     1.0))


(nth-root 256 8)
;2.0000000000039666
(nth-root 512 9)
;1.9999997106840102
(nth-root 1024 10)
;2.000001183010332
(nth-root 2048 11)
;1.999997600654736
(nth-root 4096 12)
;1.9999976914703093
(nth-root 8192 13)
;2.0000029085658984
(nth-root 16384 14)
;1.9999963265447058
(nth-root 32768 15)
;2.0000040951543023

;we go up to 15 and then 16-th does not converge
;we can see pattern more clearly if we put sequences of n and number of times to call average damp side by side:
;maximum n:      3, 7, 15
;average damps:  1, 2, 3
;meaning for up to power of 3 we need to average damp once, from 3 up to 7 twice, 15 up to 31 3 times and so on.

;to confirm let's try applying average-damp 4 times and computing root of power 31:
(define (nth-root x n)
  (fixed-point
      ((repeated average-damp 4)
         (lambda (y) (/ x (expt y (- n 1)))))
      1.0))

(nth-root 2147483648 31)
;1.9999951809750391

;and as expected it will fail if we try to run it with n=32


;In order to calculate the number of average damps from n, we just need to take the log2 of n then floor the result.

;scheme only provide log operation which is log base e or natural log
;but from the property of log that logn(x) = log(x) / log(n)

(define (log2 x)
  (/ (log x) (log 2)))

;then we can fix nth-root procedure for allowing it to utilze method of flexibly repeating
;average damping based on power of root
(define (nth-root x n)
  (fixed-point
      ((repeated average-damp (floor (log2 n)))
          (lambda (y) (/ x (expt y (- n 1)))))
      1.0))

(nth-root 4294967296 32)
;2.000000000000006
(nth-root 18446744073709551616 64)
;2.0000000000000853
(nth-root 340282366920938463463374607431768211456 128)
;2.0000000000082006
