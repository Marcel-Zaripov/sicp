; Exercise 2.29. A binary mobile consists of two branches,
; a left branch and a right branch. Each branch is a rod of a certain length,
; from which hangs either a weight or another binary mobile.
; We can represent a binary mobile using compound data by constructing it from
; two branches (for example, using list):

; (define (make-mobile left right)
;   (list left right))

; A branch is constructed from a length (which must be a number)
; together with a structure, which may be either a number
; (representing a simple weight) or another mobile:

; (define (make-branch length structure)
;   (list length structure))

; a. Write the corresponding selectors left-branch and right-branch,
; which return the branches of a mobile, and branch-length and
; branch-structure, which return the components of a branch.

; b. Using your selectors, define a procedure total-weight that
; returns the total weight of a mobile.

; c. A mobile is said to be balanced if the torque applied by
; its top-left branch is equal to that applied by
; its top-right branch (that is, if the length of the left rod
; multiplied by the weight hanging from that rod is equal to
; the corresponding product for the right side) and
; if each of the submobiles hanging off its branches is balanced.
; Design a predicate that tests whether a binary mobile is balanced.

; d. Suppose we change the representation of mobiles so that
; the constructors are

; (define (make-mobile left right)
;   (cons left right))
; (define (make-branch length structure)
;   (cons length structure))

; How much do you need to change your programs to convert to
; the new representation?

; SOLUTION:


(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; if there is no cadr available:
; (define (cadr items)
;     (car (cdr items)))

; a) selectors:
(define left-branch car)
(define right-branch cadr)
(define branch-length left-branch)
(define branch-structure right-branch)

; for testing:
(define a (make-branch 2 2))
(define b (make-branch 4 5))
(define sub-mobile (make-mobile a b))

(define c (make-branch 6 sub-mobile))
(define d (make-branch 5 3))
(define a-mobile (make-mobile d c))

a-mobile
;-> ((5 3) (6 ((2 2) (4 5)))) : the whole mobile

(left-branch a-mobile)
;-> (5 3) : one simple branch

(branch-length (left-branch a-mobile))
;-> 5 : simple length of a branch

(branch-structure (left-branch a-mobile))
;-> 3 : simple weight of a branch

(right-branch a-mobile)
;-> (6 ((2 2) (4 5))) : right branch of a mobile, that has sub-mobile as its structure

(branch-length (right-branch a-mobile))
;-> 6 : right branch weight

(branch-structure (right-branch a-mobile))
;-> ((2 2) (4 5)) : right branch structue, which is a mobile

; b) total weight procedure:
; recursive - generates tree recursive process
(define (total-weight mobile)
  (if (null? mobile)
      0
      (let ((left (branch-structure (left-branch mobile)))
            (right (branch-structure (right-branch mobile))))
           (+ (if (pair? left)
                  (total-weight left)
                  left)
              (if (pair? right)
                  (total-weight right)
                  right)))))

(total-weight a-mobile)
;-> 10

; c) balanced predicate procedure
(define (torque branch)
  (let ((struct (branch-structure branch)))
      (* (branch-length branch)
         (if (pair? struct)
             (total-weight struct)
             struct))))

(define (balanced? mobile)
  (if (null? mobile)
      #t
      (let ((left (left-branch mobile))
            (right (right-branch mobile)))
           (and (= (torque left)
                   (torque right))
                (if (pair? (branch-structure left))
                    (balanced? (branch-structure left))
                    #t)
                (if (pair? (branch-structure right))
                    (balanced? (branch-structure right))
                    #t)))))



(define balanced-mobile
    (make-mobile (make-branch 4
                              3)
                 (make-branch 3
                              (make-mobile (make-branch 2 2)
                                           (make-branch 2 2)))))

; ((5 3) (6 ((2 2) (4 5))))
(balanced? a-mobile)
;-> #f

; ((4 3) (3 ((2 2) (2 2))))
(balanced? balanced-mobile)
; -> #t

; d) changing to implementation with
; pairs should only affect the lowest level, selectors