Exercise 2.35. Redefine count-leaves from section 2.2.2 as an accumulation:

(define (count-leaves t)
  (accumulate <??> <??> (map <??> <??>)))

; SOLUTION:

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) enumerate-tree t)))
