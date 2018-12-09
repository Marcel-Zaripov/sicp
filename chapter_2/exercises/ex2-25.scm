; Exercise 2.25. Give combinations of cars and cdrs that will pick 7 from
; each of the following lists:

; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))

; SOLUTION:

(define a (list 1 3 (list 5 7) 9))
(define b (list (list 7)))
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(cdr (car (cdr (cdr a))))
(car (car b))
(cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c)))))))))))

; the combination of carS and cdrS can be substituted for special proc
; called cadr
; (introduce because it is a common thing to get to the next item and get its value)
(cdr (cadr (cadr (cadr (cadr (cadr c))))))

; same can be done in the first expression, but it is more visible here
