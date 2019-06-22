; Exercise 2.38. The accumulate procedure is also known as fold-right,
; because it combines the first element of the sequence with the result of
; combining all the elements to the right. There is also a fold-left, which is similar to fold-right,
; except that it combines elements working in the opposite direction:

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; What are the values of

(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
(fold-left list nil (list 1 2 3))

; Give a property that op should satisfy to guarantee that fold-right and fold-left will produce the same values for any sequence.

; SOLUTION:

; having fold-right and fold-left defined as:

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
    (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; What are the values of

(fold-right / 1 (list 1 2 3))
; -> 1.5

(fold-left / 1 (list 1 2 3))
; -> 0.1666666...

(fold-right list nil (list 1 2 3))
; -> (1 (2 (3 ())))

(fold-left list nil (list 1 2 3))
; -> (((() 1) 2) 3)
