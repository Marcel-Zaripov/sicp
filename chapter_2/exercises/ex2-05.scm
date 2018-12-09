; Exercise 2.5.
; Show that we can represent pairs of nonnegative
; integers using only numbers and arithmetic operations
; if we represent the pair a and b as the integer that is the product 2^a 3^b.
; Give the corresponding definitions of the procedures cons, car, and cdr.

; SOLUTION:

; We know that both 2 and 3 are primes and
; according to fundamental theorem of arithmetic
; product of 2 and 3 in any power will yield unique result.
; Knowing that, we can count how many times
; the resulting integer is divisable into 2
; and then factor out 2 to this power,
; which will leave us with some exponent of 3
; the same will be done to vise versa to get
; initial values of a and b.

; there is no easy way to factor out 2 from product of its power and 3 to some power,
; only through iteratively dividing the number into 2 and checking remainder
; finally, returning the count of times product is divisable into 2,
; which will be a

; to deal with both cases we will define the general function to factoring a number:
; count the number of times n is evenly divisible by d
(define (num-divs n d)
  (define (iter x result)
    (if (= 0 (remainder x d))
        (iter (/ x d) (+ 1 result))
        result))
  (iter n 0))

; e.g.
(num-divs 23328 2)
; 5
(num-divs 23328 3)
; 6

; definition of cons is straight forward:
(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

; definition of car and cdr:
(define (car x)
  (num-divs x 2))

(define (cdr x)
  (num-divs x 3))

; this definiton of pairs only allows it to use with integer numbers:
; just because you can do something does not mean you should
