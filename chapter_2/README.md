# Building Abstractions with Data

- [2.1 Introduction to Data Abstraction](#Introduction-to-Data-Abstraction)
- [2.2 Hierarchical Data and The Closure Property](#Hierarchical-Data-and-The-Closure-Property)
- [2.3 Symbolic Data]()
- [2.4 Multiple Representations for Abstract Data]()
- [2.5 Systems with Generic Operations]()  

---

Previous chapter focused on primitive data manipulations and primitive operations, but also on the means of abstractions with use of procedure, in particular higher order procedure, manipulating other procedures.

All three, primitives, means of combination, and means of abstraction were present. However, means of abstraction with data were still missing.

In this chapter, the focus is on abstracting with data, which is an essential component of any programming language - means of combining data objects to form *compound data*.

Why is data abstraction needed? The same reason as for abstraction with procedures - to elevate conceptual level of our programs, increase modularity, and enhance expressive power of the language. With compound data, we can deal with it at higher conceptual level than primitives allow.

For example, if we want to develop a package for dealing with rational numbers, we may represent each individual rational number by two independent integers. Thus, we can operation `add-rat` out of those integers, but we will have to manage all of the details related to any connections our-selves - `add-rat` would expect four integers and we will have to pass them properly. Besides, the procedure will have to produce nominator and denominator separately and overall system will quickly get complicated, not to mention clumsy. In a program, where we would work with dozens of rational numbers, such bookkeeping details would quickly clutter the program and make it unmaintainable. An improvement would be if we could *"glue together"* nominator and denominator to form a pair, a *compound data object*, that would be consistent as a single computational unit, just as integer is.

Data abstraction increases modularity of our programs, isolating parts of program that are responsible for representation of data from the parts of program that use data for computation.

The us of compound data also increases expressive power of programming language.  
For example, if we consider a *Linear combination* like `ax + ab` can be expressed in lisp like:

```lisp
(define (linear-combination a b x y)
  (+ (* a x) (* b y)))
```

But this definition is only concerned with primitive data - numbers, since `*` and `+` operators are operating on either integers or float point numbers. However, if we would like to define in form of procedure a general idea of linear combination whenever multiplication and addition are defined:

```lisp
(define (linear-combination a b x y)
  (add (mul a x) (mul b y))) 
```

where `mul` and `add` are complex compound procedures that can operate on a data type of parameters `a`, `b`, `x`, and `y`. However, from the perspective of `linear-combination` procedure the data type of those parameters or how they are represented with primitive data is irrelevant. If we don't have the concept of manipulating compound data in the language, we cannot possibly implement `linear-combination` without knowing how those parameters are represented.  
The main idea of this chapter thus is using compound data as an abstraction technique to cope with the complexity of the problems and programs to solve them. We will see how data abstraction enables us erect *abstraction barriers* between different parts of the program.

The key component to data abstraction and compound data is having a special *glue* that allows us combine pieces of primitive data into meaningful units. In fact, there is nothing *special* about this glue as we are going to see, it is just another layer of abstraction for us. We can even implement this layer our-selves with use of nothing else but procedures. This will further blur the line between *data* and *procedures*.

Some of the ways of representing of conventional data structure will be present in this chapter, like trees and sequences. One key idea to help here, as well as with any compound data, is the idea of *closure* - that we can use the same type of glue we used to glue primitives to glue compound data objects, thus growing on abstraction layers and making more expressive combinations. Another key idea is that compound data objects can be *conventional interfaces* for combining modules of programs. This idea will be used to create pictorial graphics language.

Later on, *symbolic expressions* will be introduced to enhance expressive power of language. The idea is that elementary parts of the compound data objects can be any arbitrary symbols, not only numbers. Various ideas for representing sets of objects will be explored. We will learn that many ways of representing data objects can be used, affecting performance in time and space complexity. We will investigate these ideas on symbolic differentiation, the representation of sets, encoding of information.

Finally, we will learn that different parts of the programs may need to represent data objects differently. This will lead us to the idea of *generic operations*, which must handle multiple data types. In order to maintain modularity in the presence of generic operations we must introduce something more powerful than simple data abstraction rules. Thus, *data-directed programming* is introduced that allows individual data representations to be implemented in isolation and then combined *additively*. To demonstrate the expressive power of the concepts unveiled in this chapter, the chapter is closed with design and implementation of the package for symbolic arithmetic on polynomials, in which coefficients of polynomials can be integers, floats, rational numbers, and even other polynomials. 

---

## Introduction to Data Abstraction

The previous chapter demonstrated that the compound procedures used for constructing more complex procedures or systems are not only a convenient way to combine operations together, but also serves as procedural abstraction. It means that details of a procedure are suppressed and what matters is its behavior, separating the invocation of the procedure and its composition out of primitive operations.

The same principle applies to the compound data and is called *data abstraction* - isolating how a compound data object is used and constructed from primitive data.

The idea is to structure programs that use compound data such that they operate on *abstract data*. It means that programs should not make assumptions about underlying data objects of the abstract data. Whereas the abstract data itself defines its "concrete" representation independent of the program and only exposes an interface to use it - usually called *selectors* and *constructors*.

#### 2.1.1  Example: Arithmetic Operations for Rational Numbers

We want to do basic arithmetics on rational numbers: add, subtract, multiply, and divide them and also be able to test whether two rational numbers are equal.

We can begin by making an assumption that we already have representation for rational numbers and we can construct them from nominator and denominator. We also assume that have a way to get these back from rational number representation.

From these assumptions, we draw further assumption that we have this interface as procedures:

- `(make-rat <n> <d>)` - returns rational number built from numerator `<n>` and denominator `<d>` (integers),
- `(numer <x>)` - returns numerator of the rational number `<x>`,
- `(denom <x>)` - returns denominator of the rational number `<x>`.

This strategy of synthesis is called **"wishful thinking"** and it is very powerful. We have not said yet how rational number is represented or how any of the interface procedures are implemented. However, with the idea of these procedures we can already think of higher level logic and operation on rational numbers. We can add, subtract, multiply, divide, and compare rational numbers if we use these relations:

```
n1/d1 + n1/d1 = (n1d2 + n2d1)/d1d2

n1/d1 - n1/d1 = (n1d2 - n2d1)/d1d2

n1/d1 * n1/d1 = n1n2/d1d2

n1/d1 / n1/d1 = n1d2/d1n2

n1/d1 = n1/d1 if and only if n1d2 = n2d1
```

These rules as procedures:

```lisp
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))
```

Now, we have all of those operations on rational numbers defined in terms of constructor and selectors. Next, we need to find a way to glue together nominator and denominator to form one rational number.

**Pairs**

Pairs are concrete level of data needed for data abstraction in lisp. Pairs are constructed with the primitive procedure `cons`, taking two arguments, each part of a pair, and returns a compound data object. Lisp also provides two procedures to access each part of a pair, `car` and `cdr`.  
> `cons` stands for *Constructor*. As for `car`, it is *Content of Address Part of Register* and for `cdr` is *Content of Decrement Part of Address* and both derive from the machine architecture where one could access each respective part of memory address.

Example of usage:

```lisp
(define x (cons 1 2))

(car x)
; 1

(cdr x)
; 2
```

Important to note here is the fact that the compound data object produced by `cons` has first-class status, i.e. can be named and manipulated just as primitive.

```lisp
(define x (cons 1 2))

(define y (cons 3 4))

(define z (cons x y))

(car (car z))
; 1

(car (cdr z))
; 3
```

In the later section (2.2), we will see that pairs can be used as general-purpose building blocks to create complex data structures. The only *glue* needed is pair itself (idea) and `cons`, `car`, and `cdr` (interface). List structured data and idea of *closure* will be shown later.

**Representing Rational Numbers**

Pairs give a natural way to represent rational numbers as pairs of integers. Then, `make-rat`, `numer`, `denom` in terms of concrete data (pairs):

```lisp
(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

; plus helper to display on screen
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
```

Example of use:

```lisp
(define one-half (make-rat 1 2))

(print-rat one-half)
; 1/2

(define one-third (make-rat 1 3))
(print-rat (add-rat one-half one-third))
; 5/6

; use procedures defined before:

(print-rat (mul-rat one-half one-third))
; 1/6

(print-rat (add-rat one-third one-third))
; 6/9
```

In the last example we see that we do not have reduction to lowest terms. We can change `make-rat` to support it with use of `gcd` procedure from section 1.2.5:

```lisp
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
    
; using reworked example:
(print-rat (add-rat one-third one-third))
; 2/3
```

Due to correct abstraction, we did not have to change any other parts of the program.

**Exercises**

- [Exercise 2.1 Version of make-rat to normalize sign](./exercises/ex2-01.scm)

#### 2.1.2 Abstraction Barriers

We defined rational number operations in terms of `make-rat` constructor and `numer` and `denom`  accessors. In general, the underlying idea of data abstraction is to identify a basic set of operations, in terms of which the data type will be expressed, then we will only use these operations to manipulate it.

Thus, we can show the structure of rational number systems as:

```
------[ Programs that use rational numbers ]------

         Rational number in problem donain
         
--------[ add-rat sub-rat mul-rat div-rat ]-------

   Rational number as numerators and denominators
   
-------------[ make-rat numer denom ]-------------

             Rational numbers as pairs

-----------------[ cons car cdr ]-----------------

           However pairs are implemented
```

Each part of the complex structure may be independently changed, thus such idea give ease in maintenance and modification.

Any complex data can be represented by a variety of the primitive data types. Logically, the choice of representation influences how a program operates on it. If we have to change representation for the data all programs using it will have to change accordingly. It may be hard and tedious in the case of large systems, unless we confine the dependence on the representation to a very few parts of program.

For example, we could deter reduction to lowest terms in our ration numbers until access to the numerator and denominator, instead of transforming at construction:

```lisp
(define (make-rat n d)
  (cons n d))
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))
```

If in typical use case we frequently access parts of rational numbers, then the best choice would be to compute greatest common divisor once, when constructing, and then continue with lowest terms. Although, if we construct a bunch of rational numbers very fast and then only access parts of some of them or access the parts rarely, we are better of to compute gcd later.  
In any case, changing this detail does not affect implementations of `add-rat`, `sub-rat` and the rest of operations, because we limited the detail at certain level of abstraction.

Constraining the dependence on the representation to a few interface procedures helps us design and modify programs easier, because it gives us flexibility of varying implementations.

Going further, at the design time, we can defer from the decisions on concrete details/implementations until later and just decide on interface (*wishful thinking* again). This will not affect our ability to make progress on the rest of the systems - we saw that with our example.

**Exercises**

- [Exercise 2.2 Representation of points](./exercises/ex2-02.scm)
- [Exercise 2.3 Representation of rectangles](./exercises/ex2-03.scm)

#### 2.1.3 What is meant by data

Chapter started with rational number operations definition - `add-rat`, `sub-rat` and so on in terms of `make-rat`, `numer`, and `denom`. At the time, we did not have data representation of rational numbers, but we could develop operations in terms of abstract data objects, whose behavior is specified by the latter procedures.

Data here is not any arbitrary behavior or procedure. For data to be truthful we need to specify contract of data - a set of rules for data to be true. In case of rational numbers, we need to guarantee that if we construct rational number `r` from `a` and `b` by means of `make-rat` we can get `a` by `(numer r)` and `b` by `(denom r)`. So the only rule here is:

```
for any integer a and any integer b != 0, we can construct a rational number r so that:

(numer r) / (denom r) = a / b
```

All needed to specify data is interface procedures (constructor and selectors) and some conditions. (*Hoare, 1972*)

It does not only concern *higher level data* like representation of numbers. We can also apply the same rule to pairs themselves.

Pair is provided by procedures `cons`, `car`, and `cdr` and satisfy condition:

```
if x and y are any programming entities,

  if z is (cons x y),
      then (car z) is x
        and (cdr z) is y
```


With this rule implementation of pair is irrelevant to us.

Of course, to be efficient it is implement on the lower level of scheme, but we may as well define it ourselves:

```lisp
(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

(define (car z) (z 0))

(define (cdr z) (z 1))
```

We implemented it using higher order procedure where:
- in `cons` we create procedure that have enclosed access to arguments x and y
- in `car` and `cdr` we accept procedure as argument and apply it to 0 or 1.  

This implementation raises borders between procedures and data some more.

Although counter intuitive, this implementation of pairs is a perfect example of that if we meet expected conditions we cannot distinguish from "real" pairs and this procedural representation.

Procedural representation of data plays an important role along the book and programming career as a whole. This style of programming is called *message passing*.

**Exercises**

- [Exercise 2.4 Alternative procedural representation of pairs](./exercises/ex2-04.scm)
- [Exercise 2.5 Representation of pairs of integers through number only](./exercises/ex2-05.scm)
- [Exercise 2.6 Church numerals procedural representation](./exercises/ex2-06.scm)

#### 2.1.4 Extended exercise: Interval Arithmetic

> Here, only dry and brief explanation of problem. The section is short in the book - follow it there better.

To be able to manipulate inexact quantities we need to somehow handle intervals with known precision. It is called [Interval Arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic).

An application of such package implementing interval arithmetics is to compute electrical quantities, such as resistance. For example, it is sometimes needed to compute the value of parallel resistance according to formula:

```
Rp = 1 / (1/R1 + 1/R2)
```

The values of resistance are usually represented with some tolerance, like: "6.8 ohms with 10% tolerance", meaning that you can be only sure that resistance falls somewhere between 6.12 and 7.48 ohms.

The idea is to represent arithmetic operation in terms of intervals as abstract entities or data objects.

Postulating that an interval has two points - upper and lower bounds, as well as assuming that we can construct an interval given those two endpoints, we can formulate procedure for adding two intervals in terms of constructor and selectors:

```lisp
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
```

Product can be defined as minimum and maximum of products of all endpoints of two intervals:

```lisp
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
```

The division is multiplication of first interval by the reciprocal of the second:

```lisp
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
```

**Exercises**

- [Exercise 2.7 Defining interval selectors](./exercises/ex2-07.scm)
- [Exercise 2.8 Subtract procedure for intervals](./exercises/ex2-08.scm)
- [Exercise 2.9 Width definition for different operations on intervals](./exercises/ex2-09.scm)
- [Exercise 2.10 Error checking interval divided by 0](./exercises/ex2-10.scm)
- [Exercise 2.11 Multiplication "improvement" to reduce number of multiplications computed](./exercises/ex2-11.scm)
- [Exercise 2.12 Interval constructor in terms of percentage](./exercises/ex2-12.scm)
- [Exercise 2.13 Formula to approximate percentage tolerance of product of two intervals](./exercises/ex2-13.scm)
- [Exercise 2.14 Demonstrating defect of inequality of equivalent computations in interval operations](./exercises/ex2-14.scm)
- [Exercise 2.15 Proving that expression involving less imprecise terms yields answer closer to truth](./exercises/ex2-15.scm)
- [Exercise 2.16 Explanation of why precise interval logic is next to impossible. Dependency problem.](./exercises/ex2-16.scm)

---

## Hierarchical Data and The Closure Property

Pairs provide a primitive "glue" to construct data objects. We can represent it in box-and-pointer notation to visualize the concept.

```
   [#|#] ---> [2]
  /
 |
 v
[1]
```

We also have seen that `cons` can combine not only numbers but pairs too (exercises 2.2 & 2.3), meaning that `car` and `cdr` may point to other pairs, thus providing a universal building blocks from which we can construct all sort of data structures. Visualized concept with two ways of representing 1, 2, 3, and 4:

```
      [#|#] ---> [#|#]        |           [#|#] ---> [4]
     /          /     \       |          /
    |          |       |      |         |
    v          v       v      |         v
   [#|#]      [3]     [4]     |       [#|#] ---> [#|#]
  /     \                     |      /          /     \
 |       |                    |     |          |       |
 v       v                    |     v          v       v
[1]     [2]                   |    [1]        [2]     [3]
```

The key here is the ability to create pairs of pairs, i.e. the elements yielded from a combination can themselves be used in this combination. It is called *closure property* (in the case of pairs - it is closure property of `cons`). Closure allows us to create hierarchical structures, which made up of parts, which themselves are made up of parts, etc. (recursive data structure, kind of)

> [This definition of closure is linked to abstract algebra where a set of elements is said to be closed under an operation if applying the operation to elements in the set produces an element that is again an element of the set. Closure is also utilized to refer to an implementation technique for representing procedures with free variables. Closure is not used in this sense in SICP]

In chapter one we have already used closure in dealing with procedures and expression combinations, where elements of expression combinations can themselves be expression combinations and the same with procedures.

In this context, the consequences of closure are applied to compound data. Some conventional techniques to represent sequences and trees using pairs are coming next. Graphics language that shows closures vividly too.

#### 2.2.1 Representing Sequences

With pairs, having property of closure, we can represent many things, for example sequences - an ordered collection of things, e.g. [1, 2, 3, 4].

There are multiple ways to do that with pairs, but one practical way is to organize it like this:

```
    [#|#] ---> [#|#] ---> [#|#] ---> [#|/]
   /          /          /          /
  |          |          |          |
  v          v          v          v
 [1]        [2]        [3]        [4] 
```

Where `car` of each pair yields an element from the sequence and `cdr` gives the next pair, from which we can follow the rest of the sequence.

`cdr` on the last pair will return `nil`, a special value used to signal "nothing", representing the end of the sequence.

We can get such a structure with this sequence of `cons`:

```lisp
(cons 1
      (cons 2
            (cons 3
                  (cons 4 nil))))
```

Such consequent calls to cons is referred to as `list` and thus Scheme provides a primitive to make such structures easily:

```lisp
(list <a1> <a2> ... <an>)

; is equivalent to

(cons <a1> (cons <a2> (cons ... (cons <an> nil) ...)))
```

There is also a convention of printing lists like:

```lisp
(list 1 2 3 4)
; -> (1 2 3 4)
```

But `(1 2 3 4)` is just a representation and does not evaluate to the same list of items.

**List Operations**

Representing lists as linked pairs has a conventional set of techniques with it for traversing list, getting elements at a certain position (index), applying operation to each item. Such operations often accompanied by "`cdr`-ing" down the list. For example, `list-ref` procedure to get `n`-th item in the list by following this method:

- for `n = 0` return `car` of the list;
- otherwise find `list-ref` of the `n - 1` -th item of the `cdr` of the list.

Implemented as:

```lisp
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))

(list-ref squares 3)
; -> 16
```

`cdr`-ing down the list happens very often, which is why Scheme introduces primitive `null?`, which return `#t` if the list is terminated, i.e. has `null` special value at `cdr`. The essence of the function is to check whether the `cdr` of the function returns this special value. An example of going over all the list is getting its length.

A recursive implementation of retrieving the length:

```lisp
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define odds (list 1 3 5 7))

(length odds)
; -> 4
```

And a simple iterative plan may be realized as follows:

```lisp
(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))
```

It is also a case to "cons up" a list, while `cdr`-ing down another list, much like moving stacks of things between each-other.

One example of such useful operation is appending two lists together:

```lisp
(append squares odds)
; -> (1 4 9 16 25 1 3 5 7)

(append odds squares)
; -> (1 3 5 7 1 4 9 16 25)
```

Append, implemented with recursive plan, follows this logic:

- if `list1` is empty, then the answer is just `list2`
- otherwise, return `cons` of `car` of the `list1` and the result of `append` of `cdr` of `list1` and `list2`

Or in code:

```lisp
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
```

**Exercises**

- [Exercise 2.17 Implementing `last-pair` procedure to return last element in list](./exercises/ex2-17.scm)
- [Exercise 2.18 Implementing `reverse` procedure](./exercises/ex2-18.scm)
- [Exercise 2.19 Updating change counting program to use list](./exercises/ex2-19.scm)
- [Exercise 2.20 Using dotted tail notation to implement `same-parity` procedure](./exercises/ex2-20.scm)

**Mapping over Lists**

One useful operation on lists is applying one particular operation to all elements of the list, often referred to as mapping.

For example, scaling each value in list:

```lisp
(define (scale-list items factor)
  (if (null? items)
      nil
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))
(scale-list (list 1 2 3 4 5) 10)
; -> (10 20 30 40 50)
```

We can abstract this idea and capture it as a higher order procedure, taking list and another procedure as input, and outputting the resulting list.

```lisp
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))
(map abs (list -10 2.5 -11.6 17))
; -> (10 2.5 11.6 17)

(map (lambda (x) (* x x))
     (list 1 2 3 4))
; -> (1 4 9 16)
```

Now, we can re-implement `scale-list` procedure.

```lisp
(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))
```

`map` is an important concept not only because it captures a common pattern, but also because it elevate the level of abstraction. Instead of dealing with elements of lists, we can conceptually deal with lists as structure and, as long as they provide conventional interface, do not bother with underlying representation (much like abstraction barriers mentioned earlier).

**Exercises**

- [Exercise 2.21 Completing the implementation of list squaring procedure](./exercises/ex2-21.scm)
- [Exercise 2.22 Upgrading squaring procedure to evolve iterative process](./exercises/ex2-22.scm)
- [Exercise 2.23 Implementing `for-each` procedure](./exercises/ex2-23.scm)

#### 2.2.2 Hierarchical Structures

The representation of sequences in terms of pairs (or lists) generalizes to sequences who themselves can be sequences (closed onto themselves, mathematical meaning of closure).

For example, the structure like `((1 2) 3 4)`, which can be constructed by:

```lisp
(list (cons 1 2) 3 4)
```

can be regarded as list (pairs) of three elements, with the first item being list (pair) itself - `(1 2)`.

In the box notation of visualizing pairs:

```
      [#|#] ---> [#|#] ---> [#|/]
     /          /          /
    |          |          |
    v          v          v
   [#|#]       3          4
  /     \
 |       |
 v       v
 1       2
```

Another way to view this structure is a tree. The elements of the trees are branches and the elements that are themselves are sequences are sub-trees.

```
             ( (1 2) 3 4 )
            /       |     \
           /        |      \
          /         |       \
       (1 2)        3        4
      /     \
     /       \
    /         \
   1           2
```

Recursion is a natural way to deal with the trees (often such self closed structures are called recursive).  The operation on the tree reduces to operation on its branches, then on the branches of the branches and all the way down to the leaves of the tree (single elements of the tree, not having any ancestry).

For example, let's compare `length` procedure from previous section to `count-leaves` procedure, which returns the total of leaves of the tree:

```lisp
(define x (cons (list 1 2) (list 3 4)))

(length x)
; -> 3

(count-leaves x)
; -> 4

(list x x)
(((1 2) 3 4) ((1 2) 3 4))

(length (list x x))
; -> 2

(count-leaves (list x x))
; -> 8
```

Recursive plan for `length` is:  

- Length is 1, plus length of the `cdr` of the list;
- Length is 0 for empty list.

Recursive plan for `count-leaves` needs to take into account the fact that on the reduction step we may have another sequence - a subtree. Thus, the reduction steps look like this:

- Number of leaves of a tree is `count-leaves` of `car` of the tree (since it can itself be sequence) plus `count-leaves` of the `cdr` of the tree;
- Number of leaves of a tree if it is a single leaf is 1;
- Number of leaves of empty tree (empty list) is 0.

Assuming that we have a procedure to check of an object is a pair, named `pair?` (Scheme specification provides such primitive), we can implement this plan into code:

```lisp
(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
```

**Exercises**
- [Exercise 2.24 Providing representation of sequence data structure constructed with lists](./exercises/ex2-24.scm)
- [Exercise 2.25 Accessing elements in nested lists](./exercises/ex2-25.scm)
- [Exercise 2.26 Working out results of operations on lists. Append, cons, etc.](./exercises/ex2-26.scm)
- [Exercise 2.27 Implementing `deep-reverse` procedure to work on the nested sequences](./exercises/ex2-27.scm)
- [Exercise 2.28 Implementing `fringe` procedure to flatten a tree into flat sequence, i.e. list.](./exercises/ex2-28.scm)
- [Exercise 2.29 Creating binary mobile structure representation. Defining selectors for it. Defining `weight` procedure to compute weight accordingly. Finding balanced mobiles. Changing to new representation.](./exercises/ex2-29.scm)


**Mapping over trees**

Map is a powerful concept not only for flat sequences, but also trees. With combination of map and recursion we can have many operations, applied to each leaf of the tree, yielding useful results.

How we can use map with trees.

Take `scale-tree` procedure, which does the same thing as `scale-list`.  
We can implement it with recursive plan just as `count-leaves` procedure.

```lisp
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
                    
(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
            10)
; -> (10 (20 (30 40) 50) (60 70))
```

However, it is possible to treat the tree as a sequence of sub-trees, in which case we can map over this sequence and apply scaling, descending down with recursion if necessary.

```lisp
(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))
```

**Exercises**
- [Exercise 2.30 Defining `square-tree` procedure](./exercises/ex2-30.scm)
- [Exercise 2.31 Generalizing `square-tree` procedure and produce `map-tree`, expressing higher level abstraction.](./exercises/ex2-31.scm)
- [Exercise 2.32 Defining procedure to generate all sub-sets of a set. Explanation.](./exercises/ex2-32.scm)


#### 2.2.3 Sequences as Conventional Interfaces

Data abstraction allows to design without knowledge of underlying data representation, giving flexibility to change it later without immediate effects or changes required to the program using this data.

In this section, we will study another powerful design principle - *conventional interface* for data structure.

We saw how higher order procedures capture general patterns of computation. We want to have the same ability to capture this generality while operating on sequences. It depends on the style of how we work with sequences.

Considering two examples of procedures working with sequences:

- Compute the sum of squares of odd nodes in the tree:

```lisp
; program #1
(define (sum-odd-squares tree)
  (cond ((null? tree) 0)  
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))
```

- Construct list of the even Fibonacci numbers that are less than input `n`:

```lisp
; program #2
(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))
```

On the surface, judging from the structure of those two procedures, no similarities between them are exposed.

However,nonetheless this dissimilarity, if we describe both of them more abstractly, we can reveal a lot of common traits.

Program #1:
1. **Enumerates** all the nodes of the tree
2. **Filters** them, selecting only odd ones
3. Squares **each** of them
4. **Accumulates** the result by addition

Program #2:
1. **Enumerates** the integers from 0 to `n`
2. Computes Fibonacci for **each** integer
3. **Filters** them, selecting only even ones
4. **Accumulates** the result into list

These structures resemble how the signal can be processed by flowing through a cascade of stages, where in our example signal is each element in the sequence. This show by bold emphasis in the description above, and in the diagram below.

For the first example, the signal is generated by enumerating nodes of the tree, then filtering them to only keep those that are odd, applying square through map onto each of them, which is basically a transducer. Finally we feed accumulator with the resulting signals, which combines them with addition, starting from zero. The second example has similar structure.

```
; program #1
 ___________        ___________        ___________        ___________
|ENUMERATE: |      |  FILTER:  |      |    MAP:   |      |ACCUMULATE:|
|tree nodes | ---> | only odd  | ---> |  square   | ---> |    +, 0   |
|___________|      |___________|      |___________|      |___________|

; program #2
 ___________        ___________        ___________        ___________
|ENUMERATE: |      |    MAP:   |      |  FILTER:  |      |ACCUMULATE:|
|ints 0 to n| ---> |    fib    | ---> | only even | ---> | cons, nil |
|___________|      |___________|      |___________|      |___________|

```

However, our programs fail to demonstrate those patterns. For example, enumeration is scattered across whole `sum-odd-squares` procedures, where it partially handled by recursion and checks like `pair?`. Same goes for filtering and accumulation. Both programs, decompose similar computations in different ways, essentially doing same things, but mingling them together beyond recognition.

If we restructure the code to manifest the signal processing pattern, we will benefit from increased conceptual clarity of code and re-usability of parts.

**Sequence operations**

To get the structure similar to signal processing, we need to concentrate on the signals. If we represent signals as list, we can manipulate them all in general (in bulk) via list operations.

For example, mapping stage readily translates to `map` list operation:

```lisp
(map square (list 1 2 3 4))
; -> (1 4 9 16)
```

We can implement filtering higher order procedure that will return sequence, where each element satisfies given predicate:

```lisp
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5))
; -> (1 3 5)
```

Accumulation is, in essence, another higher order procedure:

```lisp
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
          
          
(accumulate + 0 (list 1 2 3 4 5))
; -> 15
(accumulate * 1 (list 1 2 3 4 5))
; -> 120
(accumulate cons nil (list 1 2 3 4 5))
; -> (1 2 3 4 5)
```

The last thing from signal processing is enumerating or producing signals/values. For Fibonacci we need range of numbers:

```lisp
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
      
      
(enumerate-interval 2 7)
; -> (2 3 4 5 6 7)
```

For squaring of a tree, we need to enumerate each node of the tree (we had this in `fringe` procedure in one of previous sections. we just rename it here):

```lisp
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))


(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
; -> (1 2 3 4 5)
```

Now, having all the components of signal processing: enumerator, filter, transducer, accumulator; we can reformulate our procedure to follow this pattern.

For sum of odd squares of the tree, we need to enumerate all nodes, filter and keep those that are odd, map each to be the square, and accumulate into sum from zero.

```lisp
(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))
```

For list of even Fibonacci numbers we will enumerate integers up to input `n`, map `fib` function to get Fibonacci number at each integer, filter to keep only even ones, accumulate them into one list.

```lisp
(define (even-fibs n)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))
```

The benefit of formulating programs as sequences of general operations is that it supports modularity, design that combines relatively independent components that are pluggable in different places.

To encourage such design we can provide components and conventional interfaces for flexibly combining them together in one library.

Modular construction also helps to control complexity. It is easier to follow operations that concentrate only on some strict logic.

Besides, providing conventional interface enables us to mix and match those operation in ubiquitous manner.

We can reuse same components of our previous procedures to produce list of squares of Fibonacci numbers.

```lisp
(define (list-fib-squares n)
  (accumulate cons
              nil
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))

(list-fib-squares 10)
; -> (0 1 1 4 9 25 64 169 441 1156 3025)
```

With some simple rearrangement, we can compute product of squares of odd elements in a sequence.

```lisp
(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))
; -> 225
```

Such cascading operations are natural for data processing. For example, if we represent employee records in sequence, then we can formulate operations on it with our general interface.  
Suppose we want to find highest payed programmer.

```lisp
(define (salary-of-highest-paid-programmer records)
  (accumulate max
              0
              (map salary
                   (filter programmer? records))))
```

It's just scratching the surface of what can be implemented with such approach.  
*Read footnote 15 from this section in the book!*

Having representation of sequences along with conventional interfaces enable us to modular design. Besides, when structures are uniformly treated as sequences, we have benefited from isolating data structure dependencies to a small number of procedures. If we need to change representation, the program as a whole can stay intact. This change will be done in section 3.5, when infinite sequences will be introduced.

**Exercises**
- [Exercise 2.33 List operations in terms of accumulations](./exercises/ex2-33.scm)
- [Exercise 2.34 Horener's Rule for evaluating polynomials](./exercises/ex2-34.scm)
- [Exercise 2.35 Defining `count-leaves` procedure as accumulation](./exercises/ex2-35.scm)
- [Exercise 2.36 Defining `accumulate-n` procedure for nested list accumulation](./exercises/ex2-36.scm)
- [Exercise 2.37 Defining procedures for matrix operations](./exercises/ex2-37.scm)
- [Exercise 2.38 Distinguishing `fold-right` and `fold-left` types of accumulation](./exercises/ex2-38.scm)
- [Exercise 2.39 Implementing `reverse` procedure via `fold-right` or `fold-left`](./exercises/ex2-39.scm)
