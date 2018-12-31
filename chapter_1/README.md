# Building Abstractions with Procedures

- [1.1 The Elements of Programming](#The-Elements-of-Programming)  
- [1.2 Procedures and the Processes They Generate](#Procedures-and-the-Processes-They-Generate)  
- [1.3 Formulating Abstractions with Higher-Order Procedures](#Formulating-Abstractions-with-Higher-Order-Procedures)  

---
Computer Science is not whole a lot about computers and they are not the essence of this science (in fact lectures of SICP even question the fact that it science in itself). Computers are only beginning of it, the rudimental instrument in the formalizing of declarative knowledge, alike geometry, which was initially used to measure land in Egypt. Whereas Computer Science is really more about starting to figure out and formalize intuition about process, developing knowledge of how-to instead of what is true.

There is fundamental difference between declarative (what is true) and imperative (how to find it) knowledge. Example: mathematical definition of square root is a piece of declarative knowledge: square root of X is such number Y that Y squared is X and Y is more than 0.

Whereas algorithm for finding square root of X due to Heron of Alexandria is imperative: make a guess, improve it by averaging guess and X / guess and eventually you arrive to answer.  
*Important distinction is made between declarative and imperative knowledge.*

The latter is a method. It is exactly the opposite of the declarative knowledge. This explains the process of acquiring square root. This is exactly the subject of this chapter and the book as a whole: the process, formal description of the process, and evolution of the process.

Through mastering this book, it is possible to acquire knowledge required to design programs in such a way that one can be reasonably sure that the resulting processes will perform the tasks intended.

In this chapter, we learn:
- Elements and components of programming and programming language, how they relate;
- Basic rules of composition and abstraction;
- How to structure programs to support good level of abstraction (wishful thinking);
- How programs generate processes, how they mutate over time;
- Visualizing and predicting the behavior of the process and the system in overall;
- Formulating further abstractions with higher order procedures.


## The Elements of Programming

The programming language is the means of instructing computer about the task, thus generating process in the computer, but it is also the framework for organizing our ideas. In the latter form it is much important for humans, because computers don't really care if we organize our ideas concisely as long as the instructions lead to desired result. It does matter for us, because the only way to build complex systems is via controlling complexity levels. This is why the property of being a framework for ideas is much more vital. 

Thus, when we judge the power of the language, we look for three mechanisms for accomplishing the powerfulness:

- primitive expressions, which represent the simplest entities the language is concerned with,
- means of combination, by which compound elements are built from simpler ones, and
- means of abstraction, by which compound elements can be named and manipulated as units.

Finally, in programming we deal with two main entities: data and procedures (or operations). In this chapter we deal with simple data, later we will take a look at more complex stuff.

#### 1.1.1 Expressions  

In the simplest form, expressions are just representing some pieces of information. Just like plain text. The best way to see it is just feed several things into interpreter. For example, the following is the expression:  
```lisp
10
```  
This expression represents the number ten (or rather idea of ten in the computer).  
If you type this expression, you see as it is evaluated. *(read-eval-print loop or REPL)*

Another type of expressions, is combinations, like
```lisp
(+ 21 35 12 7)
```
Note convention of placing operation in front and then providing list of operands, it is called prefix notation. This comes from design of the language for punched cards. As it turns out, it is also powerful way to be universal in applying procedures and feeding in parameters to them as we will see it later.

#### 1.1.2 Naming and the Environment 

Critical part about programming is ability to name things. It is the simplest form of abstraction and the very basis of it.
```lisp
(define size 2)
```
Associates the symbol size with value of 2:
```lisp
size
;-> 2
(* 5 size)
;-> 10
```

This allows talking about operations and many other things with semantics.
```lisp
(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))
;-> 314.159
(define circumference (* 2 pi radius))
circumference
;-> 62.8318
```

#### 1.1.3 Evaluating Combinations 

When evaluating combinations, the interpreter follows procedure:
- To evaluate a combination, do the following:
1. Evaluate the subexpressions of the combination.
2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

The idea is very succinct with this recursive definition and can handle the most complex cases. For example, expression
```lisp
(* (+ 2 (* 4 6))
   (+ 3 5 7))
```
will be evaluated through tree recursive process (tree accumulation):
```
      390
   /   |   \
  /    |    \______
 *     |           \
       |            \
       26           15 ---------7
    /  |  \        / | \
   /   |   \      /  |  \
  +    |    \    +   |   \
       |     \       |    \
       2     24      3     5
           /  |  \
          /   |   \
         *    |    \
              4     6 
```
As it is observable in the evaluation pattern above, repeated application of the first step brings us down to primitive expressions, like numbers. We take care of the primitive cases by stipulating that:
- the values of numerals are the numbers that they name,
- the values of built-in operators are the machine instruction sequences that carry out the corresponding operations, and
- the values of other names are the objects associated with those names in the environment.  

Also, it is important to note the role of environment in determining the names, like + or \*, which are part of global namespace.

Additionally, `define` does not follow this evaluation rule. Such expressions are special forms and `define` is one example of them.  

#### 1.1.4 Compound Procedures

As we see lisp provides us with all three components of a powerful language:
- Numbers and arithmetic operations as primitives,
- Nesting of combinations provides a means of combining operations,
- Definitions that associate names with values provide a limited means of abstraction.

With ability to define comes ability to define custom procedures. Procedure definition is much more powerful mean of combination, as we can give name to a compound operations.

General form is
```lisp
(define (<name> <formal parameters>) <body>)
```

which is syntactic sugar for:

```lisp
(define <name> (lambda (<parameters>) <body>))
```

with lambda being special form to create a procedure (*often used to create anonymous procedures*).

For example, the idea of squaring can be put into named procedure:

```lisp
(define (square x) (* x x))
```

We can understand this in the following way:

```lisp
(define (square  x)        (*         x     x))
  ^        ^     ^          ^         ^     ^
  |        |     |          |         |     |
 To      square something, multiply   it by itself.
```

Having defined square, we can use just as a primitive:

```lisp
; to use as a simple operation on operand
(square 21)
;-> 441

; to use as a part of compound operations
(square (+ 2 5))
;-> 49

; repeat the symbol as many times as we need
(square (square 3))
;-> 81
```

As such we can use it as a building block in definitions of other procedures:

```lisp
(define (sum-of-squares x y)
  (+ (square x) (square y)))
```
```lisp
(sum-of-squares 3 4)
;-> 25
```
Now we can use sum-of-squares as a building block in constructing further procedures:

```lisp
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)
;-> 136
```

Compound procedures are used in exactly the same way as primitive procedures. You cannot tell them apart, because as soon as it is defined, the user is not concerned when it was defined.

#### 1.1.5 The Substitution Model for Procedure Application

In interpreting combinations of expressions, whose operators are compound procedures, the interpreter follows the same algorithm as for evaluating combinations from primitive expressions.

We can assume that primitives are just built in the interpreter and just give the result, thus the evaluation of compound procedure boils down to:

- To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

Thus we can evaluate combination of example f defined above as:

```lisp
(f 5)

;   |
;   v
(sum-of-squares (+ a 1) (* a 2))

;   |
;   v
(sum-of-squares (+ 5 1) (* 5 2))

;   |
;   v
(+ (square 6) (square 10))

;   |
;   v
(+ (* 6 6) (* 10 10))

;   |
;   v
(+ 36 100)

;   |
;   v
136
```
The process is called the substitution model for procedure application. This model can be used to interpret the meaning of the procedures, but:

- It is not a model of how interpreter works, it is only a way to think about it. In practice, "substitution" is achieved with local environment for formal parameters and bindings;
- There are models of how interpreters work presented in the book. Substitution model is only one of the first, helping us to wrap our heads around the evolution of process. More details introduced to computation will render the model inadequate and it will be changed for more powerful concept. For example, as "mutable" data will come in play, substitution model will be of no use.

**Applicative order versus normal order**

According to eval/apply mode of evaluation of expressions, the interpreter first evaluates the operator and operands and then applies the resulting procedure to the resulting arguments. The other mode of evaluation would be not to evaluate expression until  they are needed. Instead substitute all the expression until reduced only to primitives and then evaluate all of them.

For example, the same expression evaluated in this mode:

```lisp
; first expand:

(f 5)

;   |
;   v
(sum-of-squares (+ 5 1) (* 5 2))

;   |
;   v
(+    (square (+ 5 1))      (square (* 5 2))  )

;   |
;   v
(+    (* (+ 5 1) (+ 5 1))   (* (* 5 2) (* 5 2)))

; and then reduce:
;   |
;   v
(+         (* 6 6)             (* 10 10))

;   |
;   v
(+           36                   100)

;   |
;   v
;-> 136

```

Fully expand and then reduce mode of evaluation is "Normal order of evaluation". Whereas, the evaluation mode we have seen before is "Applicative order of evaluation". Those modes usually produce the same result, especially for the simple cases. However, there are illegitimate behaviors (exercise 1.5).

In general, applicative order is more efficient than normal order, due to redundancy in computation (have to repeat simple operations several times). Although, normal order evaluation will be shown useful later in the book.

#### 1.1.6 Conditional Expressions and Predicates

Expressive power is very limited if we have no way of testing and performing different operations based on the result. For example, computing absolute value of a number.  

```         
          x if x > 0
       /
|x| => -- x if x = 0
       \
         -x if x < 0
```

This construct is called a case analysis, and there is a special form in Lisp for notating such a case analysis. It is called cond. In general form:

```lisp
(cond (<predicate1> <expression1>)
      (<predicate2> <expression2>)
      ...
      (<predicaten> <expressionn>))
```

The absolute value, will be expressed as:

```lisp
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
```

The cond special form also includes else, for handling "any other case" and if special form that is designed for specifically two cases and looks like:

```lisp
(if <predicate> <consequent> <alternative>)
```

Accordingly, the absolute number procedure

```lisp
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

As the conditionals are also special forms, their evaluation goes as following: first evaluate predicate, then only evaluate the expression if needed.

The predicate is any procedure returning either #f or #t special values (boolean false and true).  
There are some useful built in predicates like `<, >, =, and, or, not`.

**Exercises**

- [Exercise 1.1 Result of sequence of expressions](./exercises/ex1-01.scm)
- [Exercise 1.2 Math expression to procedure](./exercises/ex1-02.scm)
- [Exercise 1.3 Procedure to return sum of 2 biggest numbers out of three](./exercises/ex1-03.scm)
- [Exercise 1.4 Describe behavior of the procedure](./exercises/ex1-04.scm)
- [Exercise 1.5 Procedure to determine applicative-order evaluation or normal-order evaluation](./exercises/ex1-05.scm)

#### 1.1.7 Example: Square Roots by Newton's Method

Procedures are alike to mathematical functions, except that mathematical functions concerned more with declarative knowledge and procedures more with imperative one. In practice it means that mathematical function of square root given as:


`sqrt(x) = the y such that y >= 0 and y^2 = x`

If translated directly to procedure:

```lisp
(define (sqrt x)
  (the y (and (>= y 0)
              (= (square y) x))))
```

does not make sense.

However we can describe the method of how to arrive at the result with procedure. One of such methods is Newton's method of finding square root, where we make a guess and improve it averaging the guess with input over guess and repeat until you get the good enough answer.

For example, if we look for square root of 2, we make initial guess of 1:

|Guess    | Quotient                    | Average                        |
|---------|-----------------------------|--------------------------------|
|1        | (2/1) = 2                   | ((2 + 1)/2) = 1.5              |
|         |                             |                                |
|1.5      | (2/1.5) = 1.3333            | ((1.3333 + 1.5)/2) = 1.4167    |
|         |                             |                                |
|1.4167   | (2/1.4167) = 1.4118         | ((1.4167 + 1.4118)/2) = 1.4142 |
|         |                             |                                |
|1.4142   | ...                         | ...                            |


Continuing going we will arrive to an answer.

We can express this method in the form of procedure:  
[*Newton Method Example Listing*](./examples/example_newtons_method.scm)

```lisp
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
```

Note: We still don't have good-enough? and improve procedures to make it work, we just make an assumption first ("*Wishful thinking*") that those are available and define them later:

```lisp
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```

All we have to do is to provide an entry point to the procedure:

```lisp
(define (sqrt x)
  (sqrt-iter 1.0 x)
```

And then, we are ready to use it:

```lisp
(sqrt 9)
3.00009155413138
(sqrt (+ 100 37))
11.704699917758145
(sqrt (+ (sqrt 2) (sqrt 3)))
1.7739279023207892
(square (sqrt 1000))
1000.000369924366
```

Note: sqrt-iter demonstrate how to accomplish iteration with ordinary procedure call (only possible with tail recursion).

**Exercises**

- [Exercise 1.6 New-if in the procedure and why it is a bad idea](./exercises/ex1-06.scm)
- [Exercise 1.7 Designing flexibly good-enough? alternative](./exercises/ex1-07.scm)
- [Exercise 1.8 Implement cube root](./exercises/ex1-08.scm)


#### 1.1.8 Procedures as Black-Box Abstractions

From sqrt example we see the set of procedures define, where sqrt-iter defined in terms of itself or recursively. With this composition of procedures we see that the problem of finding square root naturally breaks down to subproblems:

```
                 sqrt
                  |
                  |
                  |
              sqrt-iter
             /         \
            /           \
           /             \
      good-enough      improve
     /           \            \
    /             \            \
   /               \            \
square            abs         average
```

The biggest benefit of composition like that is thinking in the terms of *black box* abstractions or procedural abstractions. When developing good-enough we are not concerned with implementation of square as long as it works, and so on. Thus, at any point in time we can change how square procedure is implemented without affecting the overall program.

**Local Names**

In the definitions of procedures above, formal parameters were named with a variety of names, like:

```lisp
(define (square x) (* x x))
```

And yet, from the caller perspective it does not matter that the parameter is called x, the caller just passes the value and expects square of that value in return. Besides, the name x does not affect variable named x if it exists in the procedure where the square was invoked.

The key things here are:
- Formal parameters are bindings, which are important to the procedure. They are also called *bound variables*.
- Formal parameters are not visible to the procedure caller, they are *local* to procedure.
- The variable names defined in the context of where the procedure is defined are available to this procedure as *free variables* (in different languages it is possible for caller context names to be free variables of procedure - *lexical scoping*)
- The set of expressions for which a name is defined is called *scope* of the variable

**Internal definitions and block structure**

With name isolation in local scope it is possible to define procedure in the body of other procedure and thus *hide* it from the view.

For example,

```lisp
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

In this case, names `good-enough?`, `improve`, `sqrt-iter` are local to `sqrt` procedure, making it a *block structure*. Whereas in the example of `good-enough?` and `improve` we do not pass formal parameter `x` explicitly and just allow it to be visible with the rule of *lexical scope*.

---
## Procedures and the Processes They Generate

#### 1.2.1 Linear Recursion and Iteration

We will consider recursion and iteration processes on the example of computing factorial.  
Mathematically, factorial function of the number n is defined as:  
`n! = [(n-1) * (n-2) * (n-3) ... 3 * 2 * 1]`  
Which readily translates into recursive procedural definition:  
[*Factorial Examples Listing*](./examples/example_factorial.scm)

```lisp
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

When evaluating the procedure for some value, we can use substitution model to visualize the process:

```lisp
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720
```

If we describe the method for finding factorial a little bit differently (multiply 1 and 2 and then 3 and then up to n), we can provide another recursive definition:

```lisp
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

Invoking this procedure, will cause such process mutation:
```lisp
(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)         ; because sub-expressions to be applied to
(fact-iter 2 3 6)         ; fact-iter are primitive we can just assume that
(fact-iter 6 4 6)         ; they are computed immideately,
(fact-iter 24 5 6)        ; i.e. (fact-iter (* 1 6) (+ 1 1) 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720
```

Now let's consider both examples.
- Both examples compute same mathematical function and yield the same result and require the same number of step, proportional to `n`.
- Each of the procedure generate different shape of the process.
  * The first procedure generates a *recursive process*, which is characterized by *deferred operations* that create this expansion and shrinking in the process. The interpreter keeps track of those postponed operations implicitly, thus the space is also linear. This process is called a linear recursive process or linear recursion. (i.e. linear number of steps with deferred operations)
  * The second procedure generates an *iterative process*. This type does not grow and shrink. Such process's state can be seen and summarized in its *state variables* (in our case counter and product). The procedure also defines how to move from one state to another, by modifying only state variables and not postponing operations. The space needed for computation is not changing, because we do not postpone operations. Such a process is called a *linear iterative process*. (i.e. linear number of steps without deferred operations and mutable state)
- With iterative process, at each step we have full complete state of the process as a sub-result. With recursive process we have this "hidden" information (by the interpreter) of how to complete the computation in the next phase. What it means in practice. If we stop an iterative process at any point, we can get the full result and we can continue the computation from that very point and run it to completion. However, if it is a recursive process, halting it does not give the full answer, but rather some operations, which are still to be complete to arrive at result and accordingly we cannot resume easily after stop.
- Both procedure are defined recursively, i.e. in terms of itself, but each generate the processes of different shape. (this is due to tail recursion optimization. It is not the case in languages like Ada, C, Pascal, but they have "loop" special forms)

It is pretty easy to translate many recursive processes to iterative, some tips:
- When calling recursively, make sure ever parameter passed can be evaluated before applying it to call.
- Define state variables. It is usually helpful to have some aggregate variable and a counter, increasing or decreasing it accordingly (like in fact-iter), or two aggregate values, where you take from one and put it in another (later in [exercise1.9](./exercises/ex1-09.scm)).
- Devising a procedure, which generates iterative process, it is useful to approach problem from the "bottom". For example, in factorial procedure above, when computing with recursion, we though in terms of `n! = n * (n-1)..`, meaning starting from the top part or the answer and going down. However, for iteration, we start from 1 and go up until the answer, i.e. in terms of `n! = 1 * 2 ... * n`.

> Constructing iteration by means of recursive definition is specific for languages for tail-recursion optimization. However, it can help you think of the way of approaching the problem not only in such language, but also in those that have special forms for iteration, like state variables and approach from the bottom.  
> Additionally, we can consider the inner calling of fact-iter as just a way of declaring those state variables and keeping them intact in the local name scope.

**Exercises**
- [Exercise 1.9 Illustrating process of recursive and iterative add procedure](./exercises/ex1-09.scm)
- [Exercise 1.10 Values and mathematical definition of Ackerman's function](./exercises/ex1-10.scm)


#### 1.2.2 Tree Recursion

Another example of possible process shape and computation is a *tree recursion*.  
We will tackle it on the example of Fibonacci sequence.  
[*All Fibonacci Examples Listing*](./examples/example_fib.scm)  
Each number in this sequence is the sum of preceding two:  
`0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...`  
Mathematical definition:  
```
             0                        if n = 0
          /
Fib(n) => -- 1                        if n = 1
          \
             Fib(n-1) + Fib(n-2)      if n > 1
```

This readily translates to procedure:

```lisp
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

If called, generate process like this:

```
                                         (       fib 5       )         
                                /                                       \
                               /                                         \
                              /                                           \
                         (  fib 4  )                                  (  fib 3  )
                   /                     \                           /           \
                  /                       \                         /             \
                 /                         \                       /               \
              (fib 3)                    (fib 2)                 (fib 2)         (fib 1)
            /         \                 /       \               /       \           |
           /           \               /         \             /         \          |
          /             \             /           \           /           \         |
       (fib 2)        (fib 1)     (fib 1)      (fib 0)    (fib 1)      (fib 0)      1
      /       \          |           |           |          |            |
     /         \         |           |           |          |            |
    /           \        |           |           |          |            |
 (fib 1)      (fib 0)    1           1           0          1            0
    |            |
    |            |
    |            |
    1            0
```

Observations about the pattern of computation:
- In order to compute (fib 5), we need to compute (fib 4) and (fib 3), to compute (fib 4) we need to compute (fib 3) and (fib 2) and so on. Each time a branch is split, it is split in two, because we call fib in the body of it recursively twice every time.
- It is typical recursive tree of computation, but it is terrible to do that on Fibonacci, because of the redundant computation (the whole sub-tree for (fib 3) is repeated twice here and even more redundancy comes for bigger numbers).
- The number of steps required to compute is exactly the number of leaf nodes in the tree.
- This number happens to be equal to Fib(n+1), meaning the number of steps grows at the same rate as the function itself - exponentially.
- The growth of Fib(n) can be comprehended with fact that Fib(n) is the closest integer to phi^n / sqrt(5) - proof in [exercise 1.13](./exercises/ex1-13.scm), where `phi = (1 + sqrt(5))/2 ~ 1.6180...` is the golden ratio, satisfying the equation: `phi^2 = phi + 1`
- Although the number of steps grows exponentially, the space required grows linearly, with each level of the tree, because only the steps above current node need to be remembered.

Fibonacci can also be expressed as an iterative process. The idea is:
1. Take integers `a` and `b` initialized to `Fib(1) = 1` and `Fib(0) = 0` respectively
2. Repeatedly apply simultaneous transformation to those integers: `a = a + b` and `b = a`
3. After applying this transformation `n` times, we get `a = Fib(n + 1)` and `b = Fib(n)`, thus the answer.

Computing Fibonacci numbers in the procedure, generating iterative process:

```lisp
(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
```

The growth of number of steps is linear as the process is linear iteration. The difference between recursive and iterative is huge!

It seems that this example renders tree recursion useless, since we can come up with much more efficient way. However, tree recursion still has its' use cases:
- If traversing or otherwise working on the tree data structure, it is the natural way to work with it.
- The great example of the tree recursion is the evaluation rule for the interpreter like the one we learned before (eval/apply).
- If the problem is not so trivial and cannot be translated as easily (next example).

**Example: Counting change**  
[*Full Counting Change Example Listing*](./examples/example_count_change.scm)  

*Problem:*  
How many different ways can we make change of $ 1.00, given half-dollars, quarters, dimes, nickels, and pennies? More generally, can we write a procedure to compute the number of ways to change any given amount of money?

Simple recursive solution:

With assumption that we arrange coins in order, The number of ways to change amount a using n kinds of coins equals:
- the number of ways to change amount a using all but the first kind of coin, plus
- the number of ways to change amount a - d using all n kinds of coins, where d is the denomination of the first kind of coin.

Observations:  
- we can divide ways of making change in two groups - the ones that use first coin, and those that don't.
- thus the total number of ways to count change is the sum of first and the second, where for the first we should deduct amount of denomenation of the coin used.

Accordingly, we can reduce the problem of counting change for smaller amount and smaller number of types of coins, only counting the numbers in degenerate cases:
- If a is exactly 0, we should count that as 1 way to make change.
- If a is less than 0, we should count that as 0 ways to make change.
- If n is 0, we should count that as 0 ways to make change.

This algorithm easily translates to procedure:

```lisp
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
```

Although this implementation has the same redundancies as recursive Fibonacci has, it is not quite so transparently translated into iterative process (*can try to design it for a challenge*). Finally, there is way of smart compiler optimization of execution called LRU Cache (Least Recently Used). *Shape of the process and some more info on this is in [exercise 1.14](./exercises/ex1-14.scm)*

**Exercises**
- [Exercise 1.11 Implement function recursively and iteratively](./exercises/ex1-11.scm)
- [Exercise 1.12 Pascal's triangle](./exercises/ex1-12.scm)
- [Exercise 1.13 Prove Fib(n) is the closest integer to phi^n / sqrt(5)](./exercises/ex1-13.scm)

#### 1.2.3 Orders of Growth

Processes differ variably in the rates of their computational resources consumption. *Order of Growth* describes the differences conveniently in terms of input.

We take n to be a measurement of the parameter and then define R(n) to be the function at which resources are consumed. R(n) measures of the simple operations to be computed and/or the amount of space required for computation.

Order of growth of R(n) is designated as Theta(n) or often O(n) (also called Big-Oh), such that there K1 and K2 positive integers such that O(n) is sandwiched between them, i.e.:
K1 * O(n) < O(n) < K2 * O(n).

For example, computing factorial recursively, both the number of operations and space required were growing linearly or with O(n), but for the iterative solution we had number of steps growth as O(n) and space as O(1) or constant.

In general, we only care about crude measurement that describes the shape of the process, so: x^2 = 1000*x^2 = 2*x^2 + 12*x + 534 are all to be considered the same O(x^2).

**Exercises**
- [Exercise 1.14 Illustrating counting change process](./exercises/ex1-14.scm)
- [Exercise 1.15 Sine of x implementation](./exercises/ex1-15.scm)


#### 1.2.4 Exponentiation

We want a procedure that takes a base `b` and a positive integer exponent `n` as parameters and raises `b` to the power of `n`. We can think of exponentiation as a repetitive multiplication of base (just like multiplication is repetitive addition and addition is repetitive incrementing) and as such we can define it:

```
        b * b ^ (n-1)        if n > 0
       /
b^n =>  
       \
        0                    if n = 0
```

This easily translate into lisp procedure:

```lisp
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))
```

that generate linear recursive process, requiring linear space and number of steps or O(n).  
A procedure to generate linear iterative process formulates just as easily:

```lisp
(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                (- counter 1)
                (* b product)))) 
```

this version requires O(n) steps and O(1) space.

However, we can make even more improvement in the time complexity, computing exponent in less steps by using successive squaring.  
That way, instead of computing b^8 like this:

```
(b * (b * (b * (b * (b * (b * (b * b)))))
```

we cab do this:

```
b^2 = b * b
b^4 = b^2 * b^2
b^8 = b^4 * b^4
```

However, it only works for even exponents and we must generalize the rule:

```
          (b ^ (n/2)) ^ 2        if n > 0 and n is even
       /
b^n => -- b * b^(n-1)            if n > 0 and n is odd 
       \
          0                      if n = 0
```

In the form of procedure:

```lisp
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
```

This procedure computes `b` to the power of `n` in logarithmic number of steps and space that is O(log(n)). This conclusion comes from observation that `b^2n` requires one more multiplication than `b^n`, but the result is double the size. Thus, we can double the size of input and only increase number of steps by the factor of 1.  
*In general, observation that with each exponential increment in input we only get constant or linear growth of number of steps signals about logarithmic time complexity.*  
The difference in the number of steps is striking at big values of input. For example, `fast-expt` for `n = 1000` requires only 14 multiplications.  
Thus, it is always recommended to try to find a way to reduce the input size as fast as possible for better performance.

**Exercises**
- [Exercise 1.16 Iterative successive squaring exponentiation](./exercises/ex1-16.scm)
- [Exercise 1.17 Repeated multiplication](./exercises/ex1-17.scm)
- [Exercise 1.18 Iterative process for multiplication](./exercises/ex1-18.scm)
- [Exercise 1.19 Successive squaring on Fibonacci](./exercises/ex1-19.scm)

#### 1.2.5 Greatest Common Divisors

The greatest common divisor of two integers `a` and `b` is a largest integer that divides both `a` and `b` without remainder. It is useful in many applications, one particular example is interval arithmetics. One way to find GCD is to factor each of the integers down and compare the results for the smallest factor possible for both, but this is hugely inefficient.  
Another way is *Euclid's Algorithm*. The idea is based on the observation that `GCD(a, b)` is exactly `GCD(b, r)`, where `r` is the remainder of `a/b`. With this, we can devise a sequence of successive transformation to reduce to smaller integers:

```
GCD(206, 40) = GCD(40, 6) 
             = GCD(6, 4)
             = GCD(4, 2)
             = GCD(2, 0)
             = 2
```

Whenever starting with two positive integers, we can reduce the integers to eventually arrive at the pair, where the second pair is 0. Thus, we can formulate:

```
              GCD(b, a%b)         if b != 0
            /
GCD(a, b) =>   
            \
             a                    if b = 0
```

And the same in form of procedure:

```lisp
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

This is an iterative process that requires an algorithmic number of steps and it bears an interesting relationship to Fibonacci. According to *Lame's Theorem*, if Euclid's Algorithm requires `k` steps to compute GCD of a pair, then a smaller number must be greater or equal to `k-th` Fibonacci number. Meaning that we can inductively prove that the number of steps required is logarithmic:

```
if n is the smallest number of pair to GCD, then:
n >= Fib(k) = phi^k / sqrt(5)
sqrt(5) * n >= phi^k
log base phi (sqrt(5) * n) >= k
log base phi (n) >= k
since phi ~ 1.6 we can round up to two:
log(n) >= k
```

**Exercises**
- [Exercise 1.20 Illustrate GCD process on normal and applicative order evaluation interpreters](./exercises/ex1-20.scm)

#### 1.2.6 Example: Testing for Primality

Prime numbers fascinated mathematicians and philosophers since ancient time, and a number of ways was devised to check for prime numbers.  
Two algorithms for finding primality of a number are discussed here. One with order of growth O(sqrt(n)) and the other *"probabilistic"* with order of growth O(log(n)).

**Searching for divisor**

One way is to find divisors of a number. All we need is to find the smallest one bigger than 1. So the following algorithm described in this procedure just tries to find a divisor by going from 2 up to the point where a test divisor squared is more than the number.

```lisp
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
```

From this, we just need to find that the smallest divisor of number `n` is `n` itself.

```lisp
(define (prime? n)
  (= n (smallest-divisor n)))
```

The order of growth is O(sqrt(n)) is because the final test of `find-divisor` checks that the divisor is less than `sqrt(n)`, meaning that consequently we only need to check `sqrt(n)` numbers, thus the growth complexity.

**Fermat test**

[A great explanation of Fermat theorem](https://www.khanacademy.org/computing/computer-science/cryptography/random-algorithms-probability/v/fermat-s-little-theorem-visualization) and [Fermat test](https://www.khanacademy.org/computing/computer-science/cryptography/random-algorithms-probability/v/fermat-primality-test-prime-adventure-part-10) derived from it.

This test, performing at O(log(n)), is based on *Fermat's Little Theorem*, which states that if a number `n` is prime and `a` is any number less than `n`, then `a^n` is congruent to a modulo n, i.e. `a^n ≡ a (mod n)`, where `≡` is congruence sign.

If the number `n` is not prime and `a` is such that `a < n`, then for the most cases the above relation is not satisfied. Thus, if you get the number that does satisfy this relationship, then it is *probably prime*.

Accordingly, the algorithm will be as follows:  
Given a number `n`,
1. Pick an number `a` at random, such that `a < n`
2. Compute the remainder of `a^n / n` or `a^n mod n`
3. If remainder is not equal to `a` (just `a` because `a mod n = a`) then the number is not prime
4. If remainder is equal to `a` then chances are good that `n` is prime
5. Repeat the previous steps for several random number to confirm. (the more you repeat the more chances of getting answer more precise you get)

To begin with, we need a procedure to compute remainder of `a^n` to `n`, meaning we need exponential modulo operation. We can define it in two ways: one way is simple raise `a` to the power of `n` and then find remainder to `n`, but it requires computing large numbers and then working out remainder out of them, which is both time and space inefficient; the second option is to approach the problem through the same method we did for `fast-expt` procedure, we use successive squaring and taking remainder at each step of the multiplication, due to the equality:

```
c = a * b
c mod m = (a * b) mod m = [(a mod m) * (b mod m)] mod m
```

Thus, we can work only on smaller numbers and do it faster. The procedure definition is as follows:

```lisp
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))    
```

This procedure will generate following process, when called on 2 as base 5 as exponent and 3 as modulus:

```lisp
(expmod 2 5 3)
(remainder (* 2 (expmod 2 4 3)) 3)
(remainder (* 2 (remainder (square (expmod 2 3 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (expmod 2 2 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder (square (expmod 2 1 3)) 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder (square (remainder (* 2 (expmod 2 0 3)) 3)) 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder (square (remainder (* 2 1) 3)) 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder (square (remainder 2 3)) 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder (square 2) 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 (remainder 4 3)) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder (* 2 1) 3)) 3)) 3)
(remainder (* 2 (remainder (square (remainder 2 3)) 3)) 3)
(remainder (* 2 (remainder (square 2) 3)) 3)
(remainder (* 2 (remainder 4 3)) 3)
(remainder (* 2 1) 3)
(remainder 2 3)
1
```

Next, we add implementation of the test. We do that by taking a number `a` at random that is in `(2, n-1]` and compare its `expmod` to itself, because `a mod n = a` if `a < n`, which is always the case for us.

```lisp
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

Finally, we implement a procedure to run the test given number of times:

```lisp
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
```

**Probabilistic methods**

The answer of the above test is not precisely guaranteed. It is only *probably* correct, i.e. if test fails we are certain that the number is not prime, but otherwise it is strong indication of the fact that number is prime, but not a guarantee. What we can say, if the test passes and we conduct the test multiple times, the probability of error decreases.

Unfortunately, there are still some numbers that can fool Fermat test, meaning that they have `a^n mod n = a` and still not to be prime. Those number are called *Carmichael numbers* and are extremely rare - there 255 for values below 100 000 000, meaning that the chances of choosing such number at random are astronomical. Thus, we can say that by testing once our chances are better than 50/50, testing for two random are 3/4, and so on we can decrease probability of error.

Algorithms of this type are called *probabilistic algorithms*.

**Exercises**
- [Exercise 1.21 Using smallest-divisor procedure on growing numbers](./exercises/ex1-21.scm)
- [Exercise 1.22 Measurements of time of prime number procedures](./exercises/ex1-22.scm)
- [Exercise 1.23 Updating smallest-divisor procedure and measuring its speed](./exercises/ex1-23.scm)
- [Exercise 1.24 Timing and measurements of Fermat test](./exercises/ex1-24.scm)
- [Exercise 1.25 Reusing exponentiation procedure to implement expmod](./exercises/ex1-25.scm)
- [Exercise 1.26 Changed version of expmod to use explicit multiplication](./exercises/ex1-26.scm)
- [Exercise 1.27 Checking Carmichael numbers against Fermat test](./exercises/ex1-27.scm)
- [Exercise 1.28 Implementing Miller-Rabin test](./exercises/ex1-28.scm)


---

## Formulating Abstractions with Higher-Order Procedures

Having ability to define procedures greatly enhances our ability to abstract, control complexity, and build up on the terms defined. However, we still are somewhat limited in creating abstractions if our procedures can accept only numbers or primitive data as abstractions.  
Often there are programming patterns that are useful for number of operations. To employ those operations on the same pattern, some programming languages allow procedures (or rather their names) to be passed as parameters to other procedures, aka *Higher Order Procedures*. It is very powerful abstraction mechanism.

#### 1.3.1 Procedures as Arguments

To illustrate usefulness of this type of abstraction, we will consider following procedures and their common pattern:

```lisp
; first one to sum integers a through b:
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

; second to sum the cubes of intgeres of given range:
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

; and the third computes the sum of the following series:
1 / 1*3 + 1 / 5*7 + 1 / 9*11 ...
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
```

The common pattern here is summation and its presence speaks of an abstraction possibility. For one, mathematics already has such abstraction - Sigma notation, where we have range specified, what function is used for mapping values to be summed up, function to get to the next term.

We can formulate such abstraction in lisp by transforming concepts of summation to parameters, formulating `sum` procedure:

```lisp
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
```

Along with range bounds `a` and `b`, `sum` procedure takes `term` and `next` procedures as parameters. The former is used to get the term to add up and the latter to proceed to the next number.

Having defined a general method in a procedure like that, we can define our procedures to operate it. This is the way to rework previous three sum-like procedures:

```lisp
; first, we will devise a procedure inc to increament number by one
(define (inc n) (+ n 1))

; then, sum-cubes defines itself readily:
(define (sum-cubes a b)
  (sum cube a inc b))

; to sum integers we use identity procedure:
(define (identity x) x)

(define (sum-integers a b)
  (sum identity a inc b))

; finally, we can define pi-sum in the same way:
; with the help of block structure to pack it all together,
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))
```

Additionally, as we did before with our abstractions, we can re-use it as building block. Once having sum, we can define a procedure for approximating integral of a function, for small values of `dx`:

```lisp
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; usage:
(integral cube 0 1 0.01)
: .24998750000000042
(integral cube 0 1 0.001)
: .249999875000001
```

**Exercises**
- [Exercise 1.29 Implementing Simpson's Rule to approximate integral](./exercises/ex1-29.scm)
- [Exercise 1.30 Finishing implementation of sum procedure that generates iterative process](./exercises/ex1-30.scm)
- [Exercise 1.31 Implementing product procedure similar to sum for both recursive and iterative processes](./exercises/ex1-31.scm)
- [Exercise 1.32 Generalizing the pattern of sum and product into accumulation](./exercises/ex1-32.scm)
- [Exercise 1.33 Filtered accumulation](./exercises/ex1-33.scm)

#### 1.3.2 Constructing Procedures Using Lambda

In previous examples, it is visible that inside of block structure we are defining many trivial procedures that are only used ones. Languages often have special form called *lambda* specifically for creating procedures.

In general, expression has following form:

```lisp
(lambda (<formal-parameters>) <body>)
```

and can be used in combinations just as a name of a procedure would be.

For example, om the `pi-sum` procedure:

```lisp
(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))
```

The resulting procedure that is created by lambda is essentially the same as procedure define with a name.

```lisp
(define (plus4 x) (+ x 4))

; is equivalent to

(define plus4 (lambda (x) (+ x 4)))
```

In fact, we can thing of short form of a named procedure definition as a syntactic sugar for reducing boilerplate code. 

We can read lambda as:

```lisp
    (lambda             (x)             (+    x     4))
       ^                 ^               ^    ^     ^
       |                 |               |    |     |
 the procedure   of an argument x  that adds  x and 4
```

**Using let to create local variables**

We can also use lambda expression to create local variables. We need local variables in procedures, where we often reuse some of the computation and this additionally brings semantical meaning to the computation (with proper naming of course).

For example, function:

```
f(x,y) = x*(1 + x*y)^2 + y*(1 - y) + (1 + x*y)*(1 - y)
```

which can also be expressed as:

```
a = 1 + x*y
b = 1 - y
f(x,y) = x*a^2 + y*b + a*b
````

We would like to include `a` and `b` as our local variables to computation as it makes it easier and slightly better in performance (although maybe not in this case). We can use helper procedure for that:

```lisp
(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (f-helper (+ 1 (* x y)) 
            (- 1 y)))
```

Using lambda in this case makes more sense, because we are only using it to bring the variables:

```lisp
(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))
```

However, we have additional special form called *let*. We can rewrite procedure:

```lisp
(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))
```

In general, let has this form:

```lisp
(let ((<var1> <exp1>)
      (<var2> <exp2>)
      
      (<varn> <expn>))
   <body>)
```

The first part is expressions to be evaluated and the results of those expression will be bound to variable names available inside of this let body (the scope of those variables is exactly the body of let). It is evaluated just as parameters of a procedure (let is essentially a lambda with parameters yanked up, no new mechanism in interpreter is required, it is just a lambda).

Important note here, just as with parameters of the procedure, bound variables of let are only available inside of the body. Meaning if you define variable `a` and then want to define `b` in terms of `a` in the same let, you cannot do that because `a`'s scope is the body of the let.

You can also define variable in the current scope with define (we have been doing this all along, but only for global scope and procedure in block structures):

```lisp
(define (f x y)
  (define a (+ 1 (* x y)))
  (define b (- 1 y))
  (+ (* x (square a))
     (* y b)
     (* a b)))
```
**Exercises**
- [Exercise 1.34 Procedure application to itself puzzler](./exercises/ex1-34.scm)


#### 1.3.3 Procedures as General Methods

We have seen abstraction with compound procedures and abstraction with procedures as parameters. Both paradigms empower us to implement our procedures and programs as general as we can think about them. We will see two examples - general methods for finding zeros and fixed points of functions.

**Finding roots of equations by the half-interval method**

The half-interval technique is a simple one, but quite powerful for finding roots of an equation `f(x) = 0`.

The idea is to begin with two numbers `a` and `b` such that `f(a) < 0 < f(b)`, then take midpoint of `a` and `b`; if midpoint is less than zero, then zero of the function must be between midpoint and `b`; if midpoint is more than zero, then zero of the function must be between `a` and midpoint; otherwise there might be a case when the midpoint of two numbers happens to be a zero of the function. We continue to search like this until we approach *close enough* answer, which is anything less than our set tolerance. In the case of such search, the procedure implementing it will have growth complexity as `O(log(L/T))`, where `L` - length of initial interval `a-b` and `T` - tolerance. (As discussed in [order of growth section](#1.2.3-Orders-of-Growth), we can deduce logarithmic nature easily since we decrease input or uncertainty in this case by half at each step.)

```lisp
; same implementation as for sqrt procedure
(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
 
(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))
```

This `search` procedure is cumbersome, because along with function an incorrect interval may be passed, i.e. `neg-point > pos-point`. In this case, we may build addition facility for checking like this:

```lisp
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))
```

Usage:

```lisp
; approximating pi
(half-interval-method sin 2.0 4.0)
3.14111328125
```

**Finding fixed points of functions**

A number `x` is called fixed point of function `f` if `f(x) = x`. We can find a fixed point by making an initial guess and then applying function repeatedly, until we get to the point that values do not change much.

```
f(x), f(f(x)), f(f(f(x))), f(f(f(f(x)))), ...
```

We can devise it in the form of procedure that we apply repeatedly until we get an approximation of the answer with predefined tolerance:

```lisp
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
```

Example usage:

```lisp
; fixed point of cosine function
(fixed-point cos 1.0)
.7390822985224023

; solution to the equation y = sin y + cos y:
(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
1.2587315962971173
```

If we analyze square root procedure from previous sections, we can realize that it is reminiscent of the process of finding fixed point. Finding square root of `x` requires finding number `y` such that `y^2 = x`. It can be reformulated to `y = x/y`, which can be expressed as function `f(y) = x/y` and all we need is to find fixed point of that function. Thus, square root procedure defines as:

```lisp
(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))
```

Unfortunately, this procedure will never finish running, because the values will never get close enough. Consider initial guess is `y1`, the next guess `y2 = x/y1`, then the next one is `y3 = x/y2 = x/(x/y1) = y1`, which means it will be repeatedly oscillating between `y1` and `y2`.  
For example:

```lisp
; the illustration of process generated
(sqrt 4)

; call to sqrt will call fixed-point, which will in turn will be invoking try repeatedly

(try 1.0) ; at first, we have guess = 1.0, generating next value to be 4.0
(try 4.0) ; now guess = 4.0, meaning next = 4 / 4 = 1.0
(try 1.0) ; guess = 1.0, next = 4.0
; and so on without termination
```

However, such oscillation around the correct answer can be solved by technique called *average dumping*. In essence, we know that the answer is somewhere between `x` and `f(x)`, but not as far as `f(x)` itself, so it is pretty obvious for us to get a middle point of that range with average. This helps us to break out from circles around correct answer. This approach of *average dumping* is used pretty frequently and a useful operation in computation. Later we will see generalization of that approach.

New implementation of `sqrt` looks like this:

```lisp
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
```
*Note* that averaging works here because the expression are mathematically equal:

```
y = x/y
y + y = y + x/y
2y * 1/2 = (y + x/y) * 1/2
y = (y + x/y) * 1/2
```

With this update, procedure works and generates a correct answer, moreover generating the process very much alike to one in original square root procedure.

**Exercises**
- [Exercise 1.35 Golden ratio proof and approximating it with fixed point procedure](./exercises/ex1-35.scm)
- [Exercise 1.36 Printing and analyzing process of fixed-point with and without average dump for several functions](./exercises/ex1-36.scm)
- [Exercise 1.37 Infinite continued fraction](./exercises/ex1-37.scm)
- [Exercise 1.38 Approximating Euler's constant with continued fraction, based on Euler's expansion](./exercises/ex1-38.scm)
- [Exercise 1.39 Approximating tangent function with continued fraction, based on Lambert's representation](./exercises/ex1-39.scm)

#### 1.3.4 Procedures as Returned Values

We have seen that ability to pass procedures as parameters to other procedures is a pretty powerful abstraction tool. Another powerful abstraction tool is ability to construct procedures at the runtime and return them as a result of procedures.

A great proof to this idea is generalizing average dumping:

```lisp
(define (average-damp f)
  (lambda (x) (average x (f x))))
```

The procedure here takes another procedure as its argument, creates new procedure that will call original procedure and apply averaging to its input and result, and return this procedure back. Then, invoking the resulting procedure yields us an average dumped value. Thus we can re-implement square root again:

```lisp
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
```

However now, with this implementation, we make idea of average dumping discrete, even giving a name to it. Thus we have three separate notions: finding fixed point, average dumping, and the function itself.

Besides, we get to reuse this procedure. For example, we know that we can find cube as the fixed point of `y = x/y^2`, so we implement it:

```lisp
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))
```

**Newton's Method**

Previously, we used special case of Newton's Method to find square root of x. In general, if `g(x)` is differentiable function, the a solution of the equation `g(x) = 0` is a fixed point of the function `f(x)`:

```
f(x) = x - g(x) / Dg(x)
```

where, `Dg(x)` is the derivative of `g` evaluated at `x`.

In order to implement this method we will need to be able to compute derivatives of functions. We now that it is computed according to formula:

```
Dg(x) = ( g(x + dx) - g(x) ) / dx
```

for `dx` tending to zero. Thus we can express derivative as:

```lisp
(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
```

Just as `average-dump` procedure, our `deriv` takes the procedure that defines a function and return the procedure that defines its derivative.

Finally, we can implement Newton's Method with aid of `deriv`:

```lisp
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))
```

where `newton-transform` is the implementation of formula above. The `newtons-method` procedure uses `fixed-point` to find `x` at which the function of the latter formula will be equaling to `x`.

With this, we can provide yet another implementation of square root of `x` through finding zero of function `f(y) = y^2 - x`:

```lisp
(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))
```

**Abstractions and first-class procedures**

We have seen two more general ways of finding square root through finding fixed point and Newton's Method. In each method we had function transformed. We can generalize this paradigm:

```lisp
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))
```

This generalized form takes two procedures as arguments: the function and transform, along with initial guess; and returns the fixed point of that transformed function.

Using this abstraction we can restate two implementations of square root:

```lisp
; fixed point of average dumped f(y) = x/y
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

; zero of Newton transformed function f(y) = y^2 - x
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))
```

Ability to manipulate procedures as *first-class* entities is an important abstraction tool. It does not imply that we should always go for the most general way of constructing procedure, but rather to think in terms of those abstractions and be able to identify the contexts in which they are applicable.

In general, programming languages put restrictions on the way we can manipulate its elements. The fewest restrictions are put on elements of *first-class* status. Such elements can be:

- named by variables.
- passed as arguments to procedures.
- returned as the results of procedures.
- included in data structures.

**Exercises**
- [Exercise 1.40 Approximating cubic function through Newton's Method](./exercises/ex1-40.scm)
- [Exercise 1.41 Repetitive application of doulbe procedure](./exercises/ex1-41.scm)
- [Exercise 1.42 Defining compose function](./exercises/ex1-42.scm)
- [Exercise 1.43 Defining repeat procedure in terms of compose](./exercises/ex1-43.scm)
- [Exercise 1.44 Defining smooth procedure and a procedure to obtain n-fold smooth function](./exercises/ex1-44.scm)
- [Exercise 1.45 Implementing procedure to finding n-th root by repeatedly applying average dumping as many times as required](./exercises/ex1-45.scm)
- [Exercise 1.46 Generalizing the patter of computation introduced here as iterative improvement](./exercises/ex1-46.scm)

---
