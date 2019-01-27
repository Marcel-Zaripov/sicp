# Building Abstractions with Data

- [2.1 Introduction to Data Abstraction](#Introduction-to-Data-Abstraction)
- [2.2 Hierarchical Data and the Closure Property]()
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


