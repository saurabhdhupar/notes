; 阶乘
; 1. 递归计算过程
(define (fac2 n)
    (if (= n 1)
        1
        (* n (fac2 (- n 1)))))
(fac2 10)

; 2. 迭代计算过程
(define (fac n)
    (define (fac-iter product counter max-count)
        (if (> counter max-count)
            product
            (fac-iter (* product counter) (+ counter 1) max-count)))
    (fac-iter 1 1 n))
(fac 10)
(= (fac 10) (fac2 10))