; 1.11
; 函数f: 如果n<3，返回n; 如果n>=3，返回 f(n-1) + 2f(n-2) + 3f(n-3)
; 递归计算
(define (f1 n)
    (if (< n 3)
        n
        (+ 
            (f1 (- n 1))
            (* 2 (f1 (- n 2)) )
            (* 3 (f1 (- n 3))))))
; 迭代计算
(define (f2 n)
    (define (f2-iter a b c max-count)
        (cond ( (= 0 max-count) a )
              ( (= 1 max-count) b )
              ( (= 2 max-count) c )
              (else (f2-iter 
                        b
                        c
                        (+ (* 3 a) (* 2 b) c)
                        (- max-count 1)))))
    (f2-iter 0 1 2 n))

; test
(= (f1 5) (f2 5))
(= (f1 10) (f2 10))

; 1.12 用递归计算求帕卡斯三角
(define (p n)
    ())

; 1.13

; 1.14

; 1.15 sinx
(define (sine angle)
    (if (not (> (abs angle) 0.1))
        angle
        (p (sine (/ angle 3.0)))))
(define (abs x)
    (if (< x 0) (- x) x))
(define (p x)
    ; (display 1)(newline)
    (- (* 3 x ) (* 4 (cube x))))
(define (cube x)
    (* x x x))

; (a)
(sine 12.15)
; (b)
; (sine a)
; 空间，步数
