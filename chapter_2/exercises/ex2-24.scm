; Exercise 2.24. Suppose we evaluate the expression (list 1 (list 2 (list 3 4))).
; Give the result printed by the interpreter,
; the corresponding box-and-pointer structure,
; and the interpretation of this as a tree (as in figure 2.6).

; SOLUTION:

(list 1 (list 2 (list 3 4)))
; -> (1 (2 (3 4)))

; a pity take on trying to draw box notation in ascii:
;   [#|#] ---> [#|#] ---> [#|#]
;  /          /          /     \
; |          |          |       |
; v          v          v       v
; 1          2          3       4


; and now a take on drawing tree representation:
   ;   (1 (2 (3 4)))
   ;  /             \
   ; |               |
   ; v               v
   ; 1            (2 (3 4))
   ;             /         \
   ;            |           |
   ;            v           v
   ;            2         (3 4)
   ;                     /     \
   ;                    |       |
   ;                    v       v
   ;                    3       4
