; Exercise 2.17. Define a procedure last-pair that returns the list that
; contains only the last element of a given (nonempty) list:

(last-pair (list 23 72 149 34))
; -> (34)

; SOLUTION:

(define a (list 23 72 149 34))

(define (last-pair items)
  (list-ref items (- (length items) 1)))

(last-pair a)
