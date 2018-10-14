; Exercise 2.2. Consider the problem of representing line segments in a plane.
; Each segment is represented as a pair of points: a starting point and an ending point.
; Define a constructor make-segment and selectors start-segment and
; end-segment that define the representation of segments in terms of points.
; Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate.
; Accordingly, specify a constructor make-point and selectors x-point and y-point that define this representation.
; Finally, using your selectors and constructors, define a procedure midpoint-segment that
; takes a line segment as argument and returns its midpoint
; (the point whose coordinates are the average of the coordinates of the endpoints).
; To try your procedures, you'll need a way to print points:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; SOLUTION:

; point api
(define (point x y) (cons x y))
(define (x-coord p) (car p))
(define (y-coord p) (cdr p))

; point printer
(define (print-point p)
  (display "(")
  (display (x-coord p))
  (display ",")
  (display (y-coord p))
  (display ")"))

; line segment api
(define (line-seg start end) (cons start end))
(define (seg-start l) (car l))
(define (seg-end l) (cdr l))

; line segment printer
(define (print-line l)
    (print-point (seg-start l))
    (display " - ")
    (print-point (seg-end l)))

; lines for printers
(define (nline p)
    (lambda (x)
        (p x)
        (newline)))

; helper for midpoint
(define (average x y) (/ (+ x y) 2))

; actual implemenation
(define (mid-point line)
    (point (average (x-coord (seg-end line)) (x-coord (seg-start line)))
           (average (y-coord (seg-end line)) (y-coord (seg-start line)))))


; usage
(define p1 (point 1 2))
(define p2 (point 4 7))
(define s1 (line-seg p1 p2))

(define m (mid-point s1))


((nline print-line) s1)
((nline print-point) m)
