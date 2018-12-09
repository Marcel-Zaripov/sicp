; Exercise 1.16. Design a procedure that evolves an iterative exponentiation process
; that uses successive squaring and uses a logarithmic number of steps, as does fast-expt.
; (Hint: Using the observation that (bn/2)2 = (b2)n/2, keep,
; along with the exponent n and the base b, an additional state variable a,
; and define the state transformation in such a way that the product a bn is unchanged
; from state to state.
; At the beginning of the process a is taken to be 1,
; and the answer is given by the value of a at the end of the process.
; In general, the technique of defining an invariant quantity that remains unchanged
; from state to state is a powerful way to think about the design of iterative algorithms.)

; SOLUTION:

;fast expontiation method
;implementer to produce iterative process
; O(log(n)) for both time and space

(define (fast-expt b n)
  (define (fast-iter b counter product)
    (if (= counter 0)
        product
        (if (even? counter)
            (fast-iter (square b) (/ counter 2) product)
            (fast-iter b (- counter 1) (* product b)))))
  (fast-iter b n 1))