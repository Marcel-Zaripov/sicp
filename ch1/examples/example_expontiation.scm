; expontiation recursively O(n)
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))


;expontiation iteratively
;also O(n)
(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                (- counter 1)
                (* b product)))) 


;faster expontiation O(log(n))
;recursive
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

;faster expontiation O(log(n))
;iterative
(define (fast-expt b n)
  (define (fast-iter b counter product)
    (if (= counter 0)
        product
        (if (even? counter)
            (fast-iter (square b) (/ counter 2) product)
            (fast-iter b (- counter 1) (* product b)))))
  (fast-iter b n 1))
