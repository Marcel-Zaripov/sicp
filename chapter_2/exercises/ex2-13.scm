; Exercise 2.13. Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage
; tolerance of the product of two intervals in terms of the tolerances of the factors.
; You may simplify the problem by assuming that all numbers are positive.

; SOLUTION

; [a,b] × [c,d] = [min (ac, ad, bc, bd), max (ac, ad, bc, bd)]
; ignoring signs:
; [a,b] × [c,d] = [ac, bd]
; representing interval in terms of perc:
; i = [c_i - c_i*p_i, c_i + c_i*p_i]
; i = [c_i*(1 - p_i), c_i*(1 + p_i)]
; substitute that to multiplying:
; [c_x * (1 - p_x) * c_y * (1 - p_y), c_x * (1 + p_x) * c_y * (1 + p_y)]
; multiply the breakets out:
; (1 - p_x) * (1 - p_y) = 1 - p_y - p_x + p_x*p_y = 1 - (p_y + p_x) + p_x*p_y
; (1 + p_x) * (1 + p_y) = 1 + p_y + p_x + p_x*p_y = 1 + (p_y + p_x) + p_x*p_y
; let's put it back in the interval notation:
; xy = [c_x * c_y * (1 - (p_y + p_x) + p_x*p_y), c_x * c_y * (1 + (p_y + p_x) + p_x*p_y)]
; knowking that we operate on very small tolerance quantities and we only want approximation
; we can assume that p_x*p_y are indifferently small (e.g. .05 * .05 = .0025 and getting smaller for smaller values)
; thus, we will drop it from formulas
; xy = [c_x * c_y * (1 - (p_y + p_x)), c_x * c_y * (1 + (p_y + p_x))]
; Here, c_x * c_y gives us the center of new interval
; then, (p_y + p_x) gives the tolerance of new interval.
; Thus, the new tolerance is the sum of tolerances of products.

