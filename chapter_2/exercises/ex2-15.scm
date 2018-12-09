; Exercise 2.15. Eva Lu Ator, another user, has also noticed the different intervals computed by different
; but algebraically equivalent expressions. She says that a formula to compute with intervals using
; Alyssa's system will produce tighter error bounds if it can be written in such a form that no variable that
; represents an uncertain number is repeated. Thus, she says, par2 is a ``better'' program for parallel resistances than par1. Is she right? Why?

; SOLUTION

; It is true that lowering the number of repeated dependant variables will produce less error. It is true for several reasons:
; - it is true for multiplication and division, because doing those operations changes the uncertainty, i.e. the intervals are mutated in length.
; However it is easy to account for, since we can postulate (more or less accurate) that the uncertainty is summing in case of multiplication.
; - the biggest problem is actually dependency problem, which opens the gateway to questioning computability.
; In short it means that dependant variables (like R1 and R2, inputs to formula), which introduce uncertainty,
; will cause error with cases when they depend on themselves through multiplication/division or repeat.
; The issue with this dependency is visible in exercise 2.14, when we divide interval by itself. 
; [95 . 105] / [95 . 105] ~ [0.9047619047619049 . 1.1052631578947367]
; where center is > (center aa) -> 1.0050125313283207 instead of 1
; (In reality it is even hard to define what interval divided by itself should be, interval with center at 1, or interval with width 1, or with distance between boundries 1?).
; As we consider expressions:  R1*R2 / (R1 + R2) and 1 / (1/R1 + 1/R2) as algebraicallly equal, we should be able to perform transformations to come from one form to another
; e.g. comming from R1*R2 / (R1 + R2) we would do following transformations:
; R1*R2 / (R1 + R2) =>
; R1*R2 / R1*R2 * (R1/R1*R2 + R2/R1*R2) =>
; now, under assumption that resistance divided by itself equates to 1:
;       this               this           and this         brakets are supposed to be equal to 1,
;        ^                  ^                ^
; (R1*R2 / R1*R2) * 1 / ((R1/R1) * 1/R2 + (R2/R1) * 1/R2)
;  thus
; 1 / (1/R1 + 1/R2),
; which confirms that those expressions are algebraicallly equivalent.
; However, as it is obvious here, we take an assumption that division of a variable by itself should equate to 1, but as we saw in the ex. 2.14 it is not true for intervals.
; Thus, the expressions are not equal in interval expression.
; This explains why the answers to those two are not equal, but does not emphasise which one of those is more accurate.

; However, through invastigation of two expressions:
; R1*R2 / (R1 + R2) and 1 / (1/R1 + 1/R2)

; we can spot (also the conversion above emphasises) that in the first expression there is division of recurring variables by themselves, meaning that each such division introduces error.
; Accordingly, if we minimize the number of recurring dependant variables we minimize the error.
