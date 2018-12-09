; Exercise 2.3. Implement a representation for rectangles in a plane.
; (Hint: You may want to make use of exercise 2.2.)
; In terms of your constructors and selectors, create procedures that
; compute the perimeter and the area of a given rectangle.
; Now implement a different representation for rectangles.
; Can you design your system with suitable abstraction barriers,
; so that the same perimeter and area procedures will work using either representation?

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

(define (square x) (* x x))

(define (seg-len s)
  (sqrt (+
    (square (- (x-coord (seg-end s)) (x-coord (seg-start s))))
    (square (- (y-coord (seg-end s)) (y-coord (seg-start s)))))))

; lightweight implementation
; good for computation, but probably won't work for drawing
(define (rect start-point wid len) (cons start-point (cons wid len)))
(define (r-wid r) (car (cdr r)))
(define (r-len r) (cdr (cdr r)))

; rectangle built from segments
(define (rect a b) (cons a b))
(define (wid-seg r) (car r))
(define (len-seg r) (cdr r))
(define (r-wid r) (seg-len (wid-seg r)))
(define (r-len r) (seg-len (len-seg r)))

; implementing area and perimeter procedures in terms of width and length scalars
(define (area r)
  (* (r-wid r) (r-len r))

(define (perim r)
  (+ (* 2 (r-wid r)) (* 2 (r-len r))))
