; Exercise 1.13. Prove that Fib(n) is the closest integer to phi^n / sqrt(5),
; where phi = (1 + sqrt(5)) / 2. Hint: Let psy = (1 - sqrt(5)) / 2.
; Use induction and the definition of the Fibonacci numbers
; (see section 1.2.2) to prove that Fib(n) = (phi^n - psy^n) / sqrt(5).

; SOLUTION:

; The latter expression is actually the closed form of Fibonacci.

; Whereas the quantity expressed by (1 + sqrt(5)) / 2 is golden ratio
; (if two numbers are in golden ratio, it means that ratio between them
; equals to ratio between their sum and the biggest of two numbers).

; This mathimatical constant possesses many interesting properties,
; among which some will be of use for further induction:

;                         phi^2 = phi + 1
;                         1/phi + 1 = phi

; Second constant introduced in hint - psy, having value (1 - sqrt(5)) / 2,
; shares those properties:

;                         psy^2 = psy + 1
;                         1/psy + 1 = psy


; Fibonacci sequence is constituent of following numbers:
; 0, 1, 1, 2, 3, 5, 8, 13, 21, ...

; where each number is the sum of preceding two.

; Our task is to prove that Fib(n) is the closest integer
; to phi^n / sqrt(5), thus we can first put this expression
; in the form of procedure and evaluate that for several
; positions of beginning of Fibonacci sequence and compare those results
; with numbers from this sequence.


(define phi (/ (+ 1 (sqrt 5)) 2))

(define (exp base exponent)
    (define (iter expo acc)
        (if (= expo 0)
            acc
            (iter (- expo 1) (* acc base))))
    (iter exponent 1))

(define (f n) (/ (exp phi n) (sqrt 5)))

; (f 0)
; => 0.4472135954999579
; (f 1)
; => 0.7236067977499789
; (f 2)
; => 1.1708203932499368
; (f 3)
; => 1.8944271909999157
; (f 4)
; => 3.0652475842498528
; (f 5)
; => 4.959674775249769
; (f 6)
; => 8.024922359499621
; (f 7)
; => 12.984597134749391
; (f 8)
; => 21.009519494249012


; the above evaluation demonstrates that the assortion that Fib(n) is closest integer to phi^n/sqrt(5)
; is indeed reasonable and proof-worthy, but by no means it is itself is a sufficient proof.

; ## The inductive proof

; Let's begin with proving the next relationship:

;                         Fib(n) = (phi^n - psy^n) / sqrt(5)

; Knowing the recursive definition of the Fibonacci sequence and
; several of the first terms:

;                         Fib(0) = 0
;                         Fib(1) = 1
;                         Fib(2) = Fib(1) + Fib(0) = 1

; We can use substitution and evaluate aforemention equation to be proved:

; For n = 0:
;                         (phi^n - psy^n) / sqrt(5) =
;                         (phi^0 - psy^0) / sqrt(5) =
;                         (1 - 1) / sqrt(5) = 
;                         0 / sqrt(5) =
;                         0

; For n = 1:
;                         (phi^n - psy^n) / sqrt(5) =
;                         (phi^1 - psy^1) / sqrt(5) =
;                         (((1 + sqrt(5))/2) - ((1 - sqrt(5))/2)) / sqrt(5) =
;                         (2*sqrt(5) / 2) / sqrt(5) =
;                         sqrt(5) / sqrt(5) =
;                         1

; For n = 2:
;                         (phi^n - psy^n) / sqrt(5) =
;                         (phi^2 - psy^2) / sqrt(5) =
;                         ### KNOWING THAT BOTH phi and psy have property: phi^2 = phi + 1
;                         ((phi + 1) - (psy + 1)) / sqrt(5) =
;                         (phi - psy) / sqrt(5) =
;                         ((1 + sqrt(5)) / 2 - (1 - sqrt(5)) / 2) / sqrt(5) =
;                         (2*sqrt(5) / 2) / sqrt(5) =
;                         sqrt(5) / sqrt(5) =
;                         1

; Having proved that relationship holds for n = 0 and 1, we can postulate and thus assume that it
; holds for both n and n-1:
;                         Fib(n) = (phi^n - psy^n) / sqrt(5)
;                         Fib(n-1) = (phi^n-1 - psy^n-1) / sqrt(5)

; And from that we can try to find out if this:
;                         Fib(n+1) = (phi^n+1 - psy^n+1) / sqrt(5)

; is true in accordance with the above assumption.

; We will try to induce that from recursive definition:
;                         Fib(n+1) = Fib(n) + Fib(n-1)

; Knowing to what Fib(n) and Fib(n-1) can be assigned equal we can transform this into:
;                         Fib(n+1) = (phi^n - psy^n) / sqrt(5) + (phi^n-1 - psy^n-1) / sqrt(5) =
;                         (phi^n - psy^n + phi^n-1 - psy^n-1) / sqrt(5) =
;                         (phi^n + phi^n-1 - psy^n - psy^n-1) / sqrt(5) =
;                         ((phi^n + phi^n-1) - (psy^n + psy^n-1)) / sqrt(5) =
;                         (phi^n+1 * (phi^-1 + phi^-2) + psy^n+1 * (psy^-1 + psy^-2)) / sqrt(5) =
;                         (phi^n+1 * phi^-1 * (1 + phi^-1) + psy^n+1 * psy^-1 * (1 + psy^-1)) / sqrt(5) =
;                         (phi^n+1 * 1 / phi * (1 + 1 / phi) + psy^n+1 * 1 / psy * (1 + 1 / psy)) / sqrt(5) =
;                         ## We introduced above the following property of both phi and psy:
;                         1/phi + 1 = phi
;                         1/psy + 1 = psy
;                         ## thus we can substitute this in our equation:
;                         (phi^n+1 * 1 / phi * phi + psy^n+1 * 1 / psy * psy) / sqrt(5) =
;                         (phi^n+1 + psy^n+1) / sqrt(5)

; This proves that Fib(n) = (phi^n + psy^n) / sqrt(5).

; Drawing on the proof above, we can now rearrange this equation in order to help
; the proof of relationship that Fib(n) is the closest integer to phi^n / sqrt(5):

; First, let's do the following rearrangements:

;                         Fib(n) = (phi^n + psy^n) / sqrt(5) =>
;                         Fib(n) = phi^n / sqrt(5) + psy^n / sqrt(5) =>
;                         Fib(n) - phi^n / sqrt(5) = psy^n / sqrt(5)

; In proving that the Fib(n) is close to phi^n / sqrt(5), we will be trying to prove
; that mathimatical relationship

;                         Fib(n) - phi^n / sqrt(5) <= 0.5

; In the form to which the above equality has just been transformed,
; we only need to prove that

;                         psy^n / sqrt(5) <= 1 / 2,

; which we can readily do, because psy is defined as (1 - sqrt(5)) / 2, we can simply compute that:

;                         psy = -0.618304...

; Since n in the Fib(n) is an index of the sequence element, it will always be whole or natural numbers:

;                         n >= 0

; Thus,

;                         psy^n <= 1

; Now, further transforming inequality:

;                         psy^n <= sqrt(5) / 2

; We can simply compute the right part of this:

;                         sqrt(5) / 2 = 1.118...

; Since,

;                         sqrt(5) / 2 > 1

; And

;                         psy^n <= 1

; We can safely conclude that:

;                         psy^n < sqrt(5)

; And

;                         psy^n / sqrt(5) <= 1 / 2

; and therefore:

;                         Fib(n) - phi^n / sqrt(5) <= 0.5

; holds true, meaning that Fib(n) is indeed closest integer to phi^n / sqrt(5).

; QED
