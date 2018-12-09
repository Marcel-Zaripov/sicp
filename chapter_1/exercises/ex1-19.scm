; Exercise 1.19. There is a clever algorithm for computing the Fibonacci numbers
; in a logarithmic number of steps.
; Recall the transformation of the state variables a and b
; in the fib-iter process of section 1.2.2: a <- a + b and b <- a.
; Call this transformation T, and observe that applying T over and over again n times,
; starting with 1 and 0, produces the pair Fib(n + 1) and Fib(n).
; In other words, the Fibonacci numbers are produced by applying Tn,
; the nth power of the transformation T, starting with the pair (1,0).
; Now consider T to be the special case of p = 0 and q = 1 in a family of transformations Tpq,
; where Tpq transforms the pair (a,b) according to a <- bq + aq + ap and b <- bp + aq.
; Show that if we apply such a transformation Tpq twice,
; the effect is the same as using a single transformation Tp'q' of the same form,
; and compute p' and q' in terms of p and q.
; This gives us an explicit way to square these transformations,
; and thus we can compute Tn using successive squaring, as in the fast-expt procedure.
; Put this all together to complete the following procedure, which runs in a logarithmic number of steps:

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   <??>      ; compute p'
                   <??>      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

; SOLUTION:

; We're reminded of the transformation of the state variables a and b in the original fib-iter procedure from section 1.2.2: a ← a + b and b ← a. If these state changes are labeled transformation T, then applying T repeatedly for n iterations starting with a = 1 and b = 0 produces the pair a = Fib(n + 1) and b = Fib(n). So the Fibonacci numbers are produced by the nth power of the transformation T, or Tn, starting with the pair (1, 0).

; We are then asked to consider the family of transformations Tpq which transforms the pair (a, b) according to the following rules:

; a ← bq + aq + ap
; b ← bp + aq

; We can verify by quick substitution that the original transformation T is just a special case of Tpq, where p = 0 and q = 1.

; a ← b(1) + a(1) + a(0)
; a ← b + a

; b ← b(0) + a(1)
; b ← a

; We are asked to show that if we apply Tpq twice, the effect is the same as using a single transformation Tp'q' of the same form, and compute p' and q' in terms of p and q. This will give us an explicit way to square these transformations, which we can use to compute Tn using successive squaring, just like the fast-expt procedure from exercise 1.16.

; We can apply Tpq twice by defining new variables and using substitution. Let's define a1 and b1 as the results of applying transformation Tpq once

; a1 = bq + aq + ap
; b1 = bp + aq

; The next step is to define a2 and b2 and apply the tranformation a second time, this time using a1 and b1 in place of a and b.

; a2 = b1q + a1q + a1p
; b2 = b1p + a1q

; Now that we have a system of equations defined, we can use substitution on our way to simplifying.

; a2 = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; b2 = (bp + aq)p + (bq + aq + ap)q

; The second equation is shorter, so it should be easier to manipulate. Remember, we're trying to find p' and q', so we need to rewrite the equation to fit the form

; b2 = bp' + aq'

; where p' and q' can be computed in terms of q and p.

; b2 = (bp + aq)p + (bq + aq + ap)q
; = (bpp + apq) + (bqq + aqq + apq)
; = bpp + apq + bqq + aqq + apq
; = (bpp + bqq) + (2apq + aqq)
; = b(pp + qq) + a(2qp + qq)

; From this we can see that p' and q' can be computed using the following equations:

; p' = p2 + q2
; q' = 2pq + q2

; Manipulating the equation for a2 in the same way, we can verify those results. This time we're trying to fit the form

; a2 = bq' + aq' + ap'

; The groupings required for this manipulation are made even easier by the fact that we now already know the formulas for p' and q'.

; a2 = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; = (bpq + aqq) + (bqq + aqq + apq) + (bpq + apq + app)
; = bpq + aqq + bqq + aqq + apq + bpq + apq + app
; = (bpq + bpq + bqq) + (apq + apq + aqq) + (app + aqq)
; = b(pq + pq + qq) + a(pq + pq + qq) + a(pp + qq)
; = b(2pq + qq) + a(2pq + qq) + a(pp + qq)

; Now that we've verified the formulas for p' and q' in terms of p and q, we can use them to complete the procedure we were given.


(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))     ; compute p'
                   (+ (* 2 p q) (* q q))   ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))