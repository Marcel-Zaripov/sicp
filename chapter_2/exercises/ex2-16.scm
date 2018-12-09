; Exercise 2.16. Explain, in general, why equivalent algebraic expressions may lead to different answers.
; Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible? (Warning: This problem is very difficult.)

; SOLUTION

; In short: No. There does not exist a single project that definitively solves dependency problem out there in the wild.
; In general, the question of error variation in equivalent algebraic expressions and dependency problem are rooting as deeply as computability.
; There is a direct link to Entscheidungsproblem
; (a challenge to provide general algorithm for resolving statements of a first-order logic and answer 'Yes' or 'No' for whether the statement is valid or not.).
; Both Alan Turing and Alonzo Churh prooved, with implementation through general Turing Maching and lambda calculus respectively, that it is impossible
; to achive with general solution.
; This means that we cannot possible say that two equivalent algebraic expressions in interval arithmetics are to produce the same result in a general way.
; Also, the way of proving Church-Turing thesis, dependency problem is revealed and it is obvious that it is a computation paradox.
; https://en.wikipedia.org/wiki/Entscheidungsproblem
; https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis
