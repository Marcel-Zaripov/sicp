; Exercise 1.12. The following pattern of numbers is called Pascal's triangle.

;      1
;     1 1
;    1 2 1
;   1 3 3 1
;  1 4 6 4 1
;
; definition:
;            / 1                              , c = 1 or r = c
; f(r, c) = <  
;            \ f(r - 1, c - 1) + f(r - 1, c)  , otherwise
; The numbers at the edge of the triangle are all 1,
; and each number inside the triangle is the sum of the two numbers above it.
; Write a procedure that computes elements of Pascal's triangle by means of a recursive process.

; SOLUTION:

(define (pascal-triangle r c)
  (if (or (= c 1) (= c r))
      1
      (+ (pascal-triangle (- r 1) (- c 1))
         (pascal-triangle (- r 1) c))))