; Exercise 1.26. Louis Reasoner is having great difficulty doing exercise 1.24.
; His fast-prime? test seems to run more slowly than his prime? test.
; Louis calls his friend Eva Lu Ator over to help. When they examine Louis's code,
; they find that he has rewritten the expmod procedure to use an explicit multiplication,
; rather than calling square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; ``I don't see what difference that could make,'' says Louis.
; ``I do.'' says Eva. ``By writing the procedure like that,
; you have transformed the (log n) process into a (n) process.'' Explain.



; SOLUTION:

; Passing recursive call square function, instead of using * operator explicitly
; implies that, according to eval/apply model, before actually calling square
; the expmod call gets evaluated, thus making a step in a recursive process, while detering square operation for future.
; Although, before calling *, we also evaluate expmod, we do that evaluation twice for each argument, and on each
; step of the recursive process mentioned earlier, making extensive redundant computations.
; Thus, we generate tree recursion instead of linear one.
