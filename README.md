# Structure and Interpretation of Computer Programs.
##### Solutions to exercise, Examples, Notes.
![SICP](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/6-001s05.jpg)
## Intro  
This repository is a set of notes, highlights, and clippings from "Structure and Interpretation of Computer Programs", both from [the book](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html) and [video lectures](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/) to the course of the same name, interesting examples from the book, and solutions for the exercises.  
You may also find some useful links down below, in this very [document](#Useful-Links-to-Related-Resources).  

---
## Contents
1. [Building Abstractions with Procedures](./chapter1/README.md)
   1. [The Elements of Programming](./chapter1/README.md#The-Elements-of-Programming)
   2. [Procedures and the Processes They Generate](./chapter1/README.md#Procedures-and-the-Processes-They-Generate)
   3. [Formulating Abstractions with Higher-Order Procedures](./chapter1/README.md#Formulating-Abstractions-with-Higher-Order-Procedures)
2. [Building Abstractions with Data]()
   1. [Introduction to Data Abstraction]()
   2. [Hierarchical Data and the Closure Property]()

---
## About the Book
"Structure and Interpretation of Computer Programs" by professors Harold Abelson, Gerald Jay Sussman, and Julie Sussman is a prolific textbook aiming to teach the principles of computer programming, such as abstraction in programming, metalinguistic abstraction, recursion, interpreters, and modular programming. The book was formerly used at MIT as a manual for introductory programming classes and as such has its structure laid out in the manner alike the course schedule or outline.
  
Unlike many of its predecessors, which almost always concentrated on teaching details of a certain programming language, SICP aims at finding, defining, and explaining general and abstract programming paradigms, common to all programming languages. Due to that very fact, SICP remains to be relevant and extremely instructive source of knowledge, even though using Scheme, a dialect of Lisp, for explanation of concepts and paradigms, examples, and exercises.

The book also provides a great amount of fun and challenging exercises, which require rigor and dedication, as well as a voluminous lot of time. Tasks in exercises range from writing code for some puzzling problems to researching a particular subject matter or meticulously proving a statement or theorem with extensive induction. 


This high relevance, striking generality and applicability of broad Computer Science concepts, along with challenging exercises is what makes this book (along with some [MIT course material](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/index.htm)) a perfect tutorial for both beginners and experienced programmers, who aspire to acquire deep and thorough understanding of mind bending concepts and ideas of programming.

---
## Motivation
My main idea when reading the book, working through exercises, and compiling this repository is solely self-development and learning computer programming. I put all of the resources here for my personal use and no other intentions.  

However, you are more than welcome to view or use any of it. But please, if you find yourself puzzled with some exercises, do not jump to the solution right away as it forfeits your learning and defies the whole reason of reading and working through the book.

---
## Navigating and Using Repository

- This readme contains many useful bits of information for preparation, setup, and embarking on the learning experience with the book.
- Using the links in the table of contents, it is possible to navigate to short notes and extracts from the book and video lectures. There, in the chapter level readme and in the subsections of it, there are links to exercises and some interesting examples.
- It is always possible to explore single examples or exercises by simply following the path.

---
## How to Prepare Learning and Development Environment

Two main components to start working with exercises and examples:

1. Scheme interpreter (Required)
2. Edwin editor - a modification of Emacs (not required, but very useful)

**Interpreter**

- option one, Racket.

First off, one of the best interpreters for Scheme to work on SICP is Racket. on *nix like systems you can install Racket through your software repository and then install sicp collections through:

```
raco setup  # might be optional
raco pkg install sicp
```

Then, simply including `(require sicp)` at the beginning of your scm files or by invoking interpreter with `racket -l sicp --repl` or right away aliasing it with lines in your .bashrc by `alias scheme='racket -l sicp --repl'`.

For Windows things are as usual trickier and it is really not recommended to do that stuff there, just because it is so much easier on *nix systems.

- option two, MIT Scheme.

Extensive explanation of installation is provided here: [MIT Scheme](http://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/user_2.html#SEC2). It includes the creation of all shortcuts, including Edwin preparation.

**Editor**

To use Edwin with all of its perks and qwerks, simply install MIT Scheme (having emacs is prerequisite) and that will add Edwin environment to the scheme interpreter.

To start working in Edwin, type `scheme -edwin`.

Otherwise, any text editor can be used and the resulting file can be passed to interpreter from command line.

**Work online**

As an alternative, it is possible to work with scheme online here - [repl](http://repl.it/languages/scheme) (There is no MIT assumed macros and primitives, thus you have to define a lot of those things).

---
## Useful Links to Related Resources

Many of these links are readily available online in the first search page or in the home page of this course on Open Course Ware from MIT, but it is still useful to list them here. There are more links to useful resources throught the book.

- [SICP Website](https://mitpress.mit.edu/sites/default/files/sicp/index.html);
- [The book](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html);
- [MIT Course Ware home and video lectures](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/index.htm);
- [Youtube playlist with video lectures](https://www.youtube.com/watch?v=2Op3QLzMgSY&list=PLE18841CABEA24090);
- [Thrid party instruction on installing MIT Scheme and Setup](http://www.shido.info/lisp/scheme1_e.html);
- [MIT Scheme home](https://www.gnu.org/software/mit-scheme/);
- [Racket](https://download.racket-lang.org/);
- [SICP Racket collections](https://docs.racket-lang.org/sicp-manual/index.html)
- [Edwin installition](https://docs.racket-lang.org/sicp-manual/index.html);
- [Edwin user guide](http://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/user_8.html);
- [Don't panic guide](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/tools/dontpanicnew.pdf);
- [Beating the Averages (a small story about using lisp in startup)](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/tools/dontpanicnew.pdf);
- [Useful Math resource if you need some brush up](http://www.mathtutor.ac.uk);

---
