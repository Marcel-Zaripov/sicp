; Exercise 2.32. We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists.
; For example, if the set is (1 2 3), then the set of all subsets is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)).
; Complete the following definition of a procedure that generates the set of
; subsets of a set and give a clear explanation of why it works:

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map <??> rest)))))

; SOLUTION:

; recur
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset) (append (car s) subset)) rest)))))
; -> (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

; iter
(define (subsets set)
  (define (iter set rest)
    (define (add-car s)
      (append (list (car set)) s))
    (if (null? set)
        rest
        (iter (cdr set) (append rest (map add-car rest)))))
  (iter set (list nil))
)
; outputs the sequence in a different order:
(subsets (list 1 2 3))
; -> (() (1) (2) (2 1) (3) (3 1) (3 2) (3 2 1))


; EXPLANATION:
; the idea of constructing all the subsets is in the fact that for each subset, we can choose to either include
; an element or not. From this point of choice, we need to explore all possibilities coming out from this choice.
; For example, in the set (1 2 3), if we construct the set of length 2 and we decided to include 1,
; we have two possibilities left: either including 2 or 3. That yields us two possible sets of length 2 and
; starting with 1: (1 2) and (1 3). We will need to keep exploring, while we have not exhausted our possibilities.

; We can express it in the following way:
;    1. Start with an empty set in the superset - ((),). (empty set is a subset of any set)
;    2. Take all items that are already in the superset and append current item to them.
;    3. Include this resulting sets in our superset.
;    4. Continue till not exhausted all values in the input

; This approach works because when we are at the item, our current state of the superset represents all the possibilities
; when we opted out of choosing this current item. So when we at the item, we will append it to all the things we have in the
; superset and have it as our choice to include this item. Then, we include these possibilities to superset and continue on
; to the next item.
