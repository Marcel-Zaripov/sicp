; Exercise 1.18. Using the results of exercises 1.16 and 1.17,
; devise a procedure that generates an iterative process for multiplying two integers in terms of adding,
; doubling, and halving and uses a logarithmic number of steps.


; SOLUTION:

;and iterative prc here (continueing previous ex)
;O(log(n)) for both time and space


(define (fast-mult a b)
    (define (double x)
      (+ x x))
    (define (halve x)
       (/ x 2))
    (define (mult-iter a b p)
        ((cond ((= b 0) p)
               ((even? b) (mult-iter (double a) (halve b) p))
               (else (mult-iter a (- b 1) (+ a p))))))
    (mult-iter a b 0))

