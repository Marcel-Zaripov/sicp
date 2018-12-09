; Exercise 1.37. a. An infinite continued fraction is an expression of the form:

; f = n_1 / (d_1 + n_2 / (d_2 + n_3 / (d_3 + ...)))

; As an example, one can show that the infinite continued fraction expansion with
; the Ni and the Di all equal to 1 produces 1/,
; where  is the golden ratio (described in section 1.2.2).
; One way to approximate an infinite continued fraction is to truncate
; the expansion after a given number of terms.
; Such a truncation -- a so-called k-term finite continued fraction -- has the form:

; f = n_1 / (d_1 + n_2 / (d_2 + n_3 / (... + n_k + d_k)))

; Suppose that n and d are procedures of one argument (the term index i) that
; return the Ni and Di of the terms of the continued fraction.
; Define a procedure cont-frac such that evaluating (cont-frac n d k)
; computes the value of the k-term finite continued fraction.
; Check your procedure by approximating 1/phi using

; (cont-frac (lambda (i) 1.0)
;            (lambda (i) 1.0)
;            k)

; for successive values of k.
; How large must you make k in order to get an approximation that is accurate to 4 decimal places?

; b. If your cont-frac procedure generates a recursive process,
; write one that generates an iterative process.
; If it generates an iterative process, write one that generates a recursive process.

; SOLUTION:

;this will generate recursive process
(define (cont-frac n d k)
    ((define (frac i) 
        (if (< i k)
            (/ (n i) (+ (d i) (frac (+ i 1))))
            (/ (n i) (d i))))
    (frac 1)))


;iterative
(define (cont-frac-iter n d k)
   (define (frac-iter i result)
       (if (= i 0)
           result
           (frac-iter (- i 1) (/ (n i) (+ (d i) result)))))
   (frac-iter (- k 1) (/ (n k) (d k))))



; computing approximation of 1/phi
(cont-frac (lambda (i) 1.0)
         (lambda (i) 1.0)
         10)
;0.6179775280898876 ~ 0.61803