; Exercise 2.37. Suppose we represent vectors v = (vi) as sequences of numbers, and matrices m = (mij)
; as sequences of vectors (the rows of the matrix). For example, the matrix

; | 1 2 3 4 |
; | 4 5 6 6 |
; | 6 7 8 9 |

; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)).
; With this representation, we can use sequence operations to concisely express the basic matrix and vector operations.
; These operations (which are described in any book on matrix algebra) are the following:

; (dot-product v w) - returns the sum Σ[i](v[i]w[i])

; (matrix-*-vector m v) - returns the vector t, where t[i] = Σ[j](m[i][j]v[j])

; (matrix-*-matrix m n) - returns the matrix p, where p[i][j] = Σ[k](m[i][k]n[k][j])

; (transpose mat) - returns the matrix n, where n[i][j] = m[j][i]

; We can define the dot product as:

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; Fill in the missing expressions in the following procedures for computing the other matrix operations.
; (The procedure accumulate-n is defined in exercise 2.36.)

(define (matrix-*-vector m v)
  (map <??> m))

(define (transpose mat)
  (accumulate-n <??> <??> mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map <??> m)))

; SOLUTION:

; dot product = sum of products of v[i] and w[i]
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
  
; multiplying matrix by vector = sum of rows of matrix after multiplying each item in the row by vector
(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

; transpose matrix = m[i,j] => m[j,i]
(define (transpose mat)
  (accumulate-n cons nil mat))

; matrix by matrix
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))
