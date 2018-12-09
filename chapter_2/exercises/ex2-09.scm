; Exercise 2.9. The width of an interval is half of the difference between its upper and lower bounds.
; The width is a measure of the uncertainty of the number specified by the interval.
; For some arithmetic operations the width of the result of combining two intervals is a function only of
; the widths of the argument intervals, whereas for others the width of the combination is not a function of
; the widths of the argument intervals.
; Show that the width of the sum (or difference) of two intervals is a function only of
; the widths of the intervals being added (or subtracted).
; Give examples to show that this is not true for multiplication or division.

; SOLUTION

(define (width-interval int) (/ (- (upper-bound int) (lower-bound int)) 2))

; in some cases
; (width-interval (operation int-x int-y)) == (operation (width-interval int-x) (width-interval int-y))
; this does work out in case of addition and subtruction, but not in muliplication and division
; e.g.
; [a, b] and [c, d] are intervals
; then,
; [a + c, b + d] is their sum
; then,
; width[a + c, b + d] =
; ((b + d) - (a + c)) / 2
; let's try to take the sum of width of both intervals:
; width[a, b] + width[c, d] =
; (b - a) / 2 + (d - c) / 2 =
; (b - a + d - c) / 2 =
; (b + d - a - c) / 2 =
; ((b + d) - (a + c)) / 2
; which equals to the width of sum of intervals.

; this does not work with products:
; counter example:
(define a (make-interval 2 4))
(define b (make-interval 5 10))
(define c (make-interval 10 15))
(mul-interval a b)
; (10 . 40)
(mul-interval a c)
; (20 . 60)

; intervals b and c have the same widths, but multiplying them by interval gives us different intervals,
; which means we cannot dervie the width of product interval from the product of widths (or any function of widths)
