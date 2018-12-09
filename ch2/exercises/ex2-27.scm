; Exercise 2.27. Modify your reverse procedure of exercise 2.18 to
; produce a deep-reverse procedure that takes a list as argument and
; returns as its value the list with its elements reversed and with
; all sublists deep-reversed as well. For example,

(define x (list (list 1 2) (list 3 4)))

x
; ((1 2) (3 4))

(reverse x)
; ((3 4) (1 2))

(deep-reverse x)
; ((4 3) (2 1))

; SOLUTION:

; recursive
(define (deep-reverse items)
  (if (null? items)
      (list)
      (append (reverse (cdr items))
              (list (if (pair? (car items))
                        (reverse (car items))
                        (car items))))))
(deep-reverse x)

; iterative
(define (deep-reverse items)
  (define (rev-iter i r)
    (if (null? i)
        r
        (rev-iter (cdr i)
            (append (list (if (pair? (car i))
                              (deep-reverse (car i))
                              (car i)))
                    r))))
  (rev-iter items (list)))

(deep-reverse x)
; ((4 3) (2 1))
