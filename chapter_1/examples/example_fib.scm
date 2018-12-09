;recursive
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))


; iterative
(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

;smart work around of iterative
;way of computing to get into O(log(n))
;expressing transformation
;of a = a + b and b = a through general form
;of transformation family
(define (fib n)
   (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
   (cond ((= count 0) b)
         ((even? count)
          (fib-iter a
                    b
                    (+ (* p p) (* q q))     ; compute p'
                    (+ (* 2 p q) (* q q))   ; compute q'
                    (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))



;closed form fibonacci
(define phi
   (/ (+ 1 (sqrt 5)) 2))

