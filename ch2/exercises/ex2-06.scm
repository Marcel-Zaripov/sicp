; Exercise 2.6. In case representing pairs as procedures wasn't mind-boggling enough,
; consider that, in a language that can manipulate procedures,
; we can get by without numbers (at least insofar as nonnegative integers are concerned)
; by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;This representation is known as Church numerals,
; after its inventor, Alonzo Church, the logician who invented the calculus.

; Define one and two directly (not in terms of zero and add-1).
; (Hint: Use substitution to evaluate (add-1 zero)).
; Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).

; SOLUTION:

; first, we will add a concrete function to be passed as f to those Churh representations
; to make it feasible and testable
; the function can be anything and should map into distinct value from a single parameter
; although it can be anything, better use something simple
; so it will be easier to evaluate and test in your head :)

; I am using simple increment by 1 function:
(define (inc x) (+ x 1))

; with this we can test zero and verify that it ideed represents zero:
((zero inc) 0)
; => 0
((zero inc) 1)
; => 0

((zero inc) 2)
; => 0

; as you can see, zero is represented here by zero application of function inc
; this is the main idea and the number, which we pass us indeed irrelevant

; if we do
(define one (add-1 zero))
; then 
((one inc) 0)
; => 1
((one inc) 1)
; => 1
((one inc) 2)
; => 1

; and here we have one expressed like idea of application inc once
; all other Church numerals follow the same idea and representation

; now, let's dig into how it works
; substitution model of evaluation of;
; (add-1 zero)
; => add-1 as applied to zero, first retrive the zero
; (add-1 (lambda (f) (lambda (x) x)))
; => then, get the body of add-1
; ((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) x)))
; => substitute zero for formal parameter of add-1, which is n, put that into add-1 body
; (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x)))
; => zero in its turn, accepts f as formal paramter and applies it to x zero times, yielding just x,
; leaving us with body of one to be:
; (lambda (f) (lambda (x) (f x)))

; thus one can be implemented directly like:
(define (one f) (lambda (x) (f x)))

;Next we can define two by evaluating (add-1 one) using exactly the same principles.
(add-1 one)

; retrieve the body of add-1 and substitute one for its parameter n
; (lambda (f) (lambda (x) (f ((one f) x))))

; retrieve the body of one and substitute
; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
 
; simplify
; (lambda (f) (lambda (x) (f (f x))))

; direct implementation of two:
(define (two f) (lambda (x) (f (f x))))

; helper compose function:
(define (compose a b) (lambda (x) (a (b x))))

; repeat n-times iteratively:
(define (repeated f n)
    (define (iter p i)
        (if (= i n)
            p
            (iter (compose p f) (+ i 1))))
    (iter f 1))

; implementation of Churh numeral two in terms of repeated
(define (two f) (lambda (x) ((repeated f 2) x))


; addition of Churh numerals
; means that if a number implies application of a function n times
; and another number means application of a function m times
; then addition of two representations of numerals means that
; in order to get representation of n + m
; we will need to consecutively apply function n times and then m times
(define (add-church m n)
   (lambda (f) (lambda (x) ((m f) ((n f) x)))))

; tests:
(define three (add-church one two))
(define four (add-church two two))
(define seven (add-church three four))
((three inc) 0)
; 3
((four inc) 0)
; 4
((seven inc) 0)


; very interesting reading on Church numerals:
; Marsel, you need to finish this reading extra urgently !!!!!!
; http://www.cs.unc.edu/~stotts/723/Lambda/church.html