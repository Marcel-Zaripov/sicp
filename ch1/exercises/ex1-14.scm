; Exercise 1.14. Draw the tree illustrating the process generated
; by the count-change procedure of section 1.2.2 in making change for 11 cents.
; What are the orders of growth of the space and number of steps
; used by this process as the amount to be changed increases?

; SOLUTION:

; procedure to compute all possible change variations (next lexicographical premutation):
(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

; as it is hinted in the exercise itself and can be regarded from the fact
; that in the body of cc it does a recursive call of itself twice,
; it is readily observable that procedure will generate tree recursive process (thus shaped as tree)
; on each step, the left hand side node will be getting passed the same amount, but less kinds of coins
; whereas the left hand side will be getting passed the amount deduced by the highest denomenation of
; available coins 
;
;                                 (count-change 11)
;                                        |
;                                    (cc 11 5)
;                                  /           \
;                             (cc 11 4)     (cc -39 5)
;                            /         \ 
;                       (cc 11 3)    (cc -14 4) 
;                      /         \____________________________________________________________________________________________________________________________
;                     /                                                                                                                                       \
;                (cc 11 2)_______________________________________________________                                                                          (cc 1 3)
;               /                                                                \                                                                        /        \
;          (cc 11 1)                                                              (cc 6 2)_________________                                         (cc 1 2)    (cc -9 3)
;         /         \                                                            /                         \                                       /        \
;     (cc 11 0)   (cc 10 1)                                                    (cc 6 1)                (cc  1 2)                                (cc 1 1)   (cc -4 2)
;                /         \                                                   |       |              /         \                              /        \
;           (cc 10 0)     (cc 9 1)                                             |       |          (cc 1 1)   (cc -4 2)                     (cc 1 0)   (cc 0 1)
;                        /        \                                            |       |         /        \
;                    (cc 9 0)   (cc 8 1)                                       |       |     (cc 1 0)   (cc 0 1)
;                              /        \                                      |       |
;                          (cc 8 0)   (cc 7 1)                                 |        \
;                                    /        \                             (cc 6 0)   (cc 5 1) 
;                                (cc 7 0)    (cc 6 1)                                 /        \
;                                           /        \                            (cc 5 0)    (cc 4 1)
;                                       (cc 6 0)   (cc 5 1)                                  /        \
;                                                 /        \                            (cc 4 0)    (cc 3 1)
;                                            (cc 5 0)    (cc 4 1)                                  /        \
;                                                       /        \                            (cc 3 0)    (cc 2 1)
;                                                  (cc 4 0)    (cc 3 1)                                  /        \
;                                                             /        \                            (cc 2 0)    (cc 1 1)
;                                                        (cc 3 0)    (cc 2 1)                                  /        \
;                                                                   /        \                             (cc 1 0)   (cc 0 1)
;                                                              (cc 2 0)    (cc 1 1)
;                                                                         /        \
;                                                                     (cc 1 0)   (cc 0 1)

; ######## Orders of Growth: ########

; Orders of growth will be counted in terms of the input of count-change, thus we are only concerned with amount

; ### Space: ###

; The same as with Fibonacci recursive implementation, the space required should be proportional to the input linearly,
; and as we can see from the max depth of the tree, it will be linear to the amount
; (we only need to keep the previous steps of computation above current node we compute)
; thus we can state that space complexity is O(n)

; ### Number of steps: ###

; As it is readily visible, tree recursion is not very efficient to compute and it does redundant computations of the nodes that
; have already been computed before.
; But let's analyze the process generated by the call to (count-change 11) more closely
; If we take a look at the process branch starting from (cc 11 1) and going down
; we can see the pattern that we decrease amount by 1 every step and accordingly going down to the terminal node we generate the number of steps
; proportional to amount.
; Defining function like T(n, k) to be the number of calls to cc generated by call (cc n k),
; where n is the amount and k is the number of kinds of coins, then we can express this relationship like this:

;                 T(n, 1) = 2n + 1

; translating into Big O notation:

;                 T(n, 1) = O(n)      ## (as constants are not significant in this context)

; Considering the second branch from the left, going from (cc 11 2), we can observe interesting behaviors:
; First, with every step amount is getting reduced by 5, which is denomenation of third kind of coin all the way to terminal node,
; meaning that the number of steps will be growing in n/5 proportion.
; Second, each of the calls to (cc n 2) generates the whole branch of calls to (cc n 1), which can be seen on the left subbranches of the tree.
; That means that we will have:

;                 T(n, 2) = (n/5) * (2n + 1)

; And because we are only interested in multiplications and the highest terms we get:

;                 T(n, 2) = O(n^2)

; The same thing happens with the next branches, where for (cc n 3) we will get reduction by 10, so it will generate n / 10 steps,
; and thus we will be having O(n^3).
; It will go like this all the way up to the O(n^5), since we have 5 kinds of coins.
; Or more generally O(n^m), where m is the number of kinds of coins.