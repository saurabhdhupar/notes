; 运算
(+ 1 1)

; 定义变量
(define size 2)

; 定义函数
(define (squqre x) (* x x))

(squqre 9)

(define (sum-of-squqre x y) (+ (squqre x) (squqre y)))

(sum-of-squqre 3 4)

; 条件表达式

; cond
(define (abs x)
(cond
    ( (> x 0) x )
    ( (= x 0) 0 )
    ( (< x 0) (- x) )
)
)

(abs 1)
(abs (- 1))

; cond + else
(define (abs2 x) (
    cond
        ((< x 0) (- x))
        (else x)
))

(abs2 1)
(abs2 (- 1))

; if x x x
(define (abs3 x) (
    if 
        (< x 3)
        (- x)
        x
))

(abs3 1)
(abs3 (- 1))

; and or not
(and (> 1 0) (< 1 0)) ;f
(or (> 1 0) (< 1 0)) ;t
(not (> 1 0)) ;f

; >=
(define (>= x y) (
    or (> x y) (= x y)
))

(define (>=2 x y) (
    not (< x y)
))

(and (>= 2 1) (>=2 2 1) #t) ; #t
(and (>= 1 1) (>=2 1 1) #t) ; #t
(or  (>= 1 2) (>=2 1 2) #f) ; #f

; 平方根
(define (sqrt-iter guess x)
    (if (good-enough guess x) guess (sqrt-iter (improve guess x) x)))
(define (good-enough guess x)
    (< (abs (- (squqre guess) x)) 0.001))
(define (improve guess x)
    (average guess (/ x guess)))
(define (average x y)
    (/ (+ x y) 2))
(define (sqrt x)
    (sqrt-iter 1.0 x))
(sqrt 2)
(sqrt 0.00000000000000000000000000000000000001)
(sqrt 99999999999999999999999)