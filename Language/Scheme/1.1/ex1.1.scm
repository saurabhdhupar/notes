; 1.1
; 写在书上

; 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

; 1.3
(define (<= x y) (not (> x y)))
(define (sum-of-max-two a b c) (if (and (<= a b) (<= a c)) (+ b c) (+ a (if (> b c) b c))))
(= (sum-of-max-two 1 2 3) 5)
(= (sum-of-max-two 1 1 1) 2)

; 1.4
; a加上b的绝对值

; 1.5
; ben发明一个方法可以知道解释器是采用哪种求值序
; 正则序求值：完全展开。而后归约
; 引用序求值：先求值参数，然后应用

;(define (p) (p))
;(define (test x y)
;    (if (= x y) 0 y))
;(test 0 (p))

; 如果是正则序：=> (if (= 0 (0)) 0 0)，结果无限递归？
; 如果是引用序：会先求p，然后会无限递归，无结果
; 好吧，答案不知道

; 1.6 为什么id需要单独定义，而不能使用cond？
; err new-if
(define (new-if predicate then-clause else-clause)
    ((cond (predicate then-clause)
        (else else-clause))))
;(new-if (= 2 3) 0 5)
;(new-if (= 1 1) 0 5)
;不懂

; 1.7 使用猜测之变化小的时候停止，求平方根
; 平方根
(define (sqrt-iter2 guess x)
    (if (good-enough guess x) guess (sqrt-iter2 (improve guess x) x)))
; (define (good-enough guess x)
;     (< (abs (- (squqre guess) x)) 0.001))
(define (good-enough guess x)
    ; 这里就是一个变化率
    (< (/ (abs (- (improve guess x) guess)) guess) 0.0000000000001))
(define (improve guess x)
    (average guess (/ x guess)))
(define (average x y)
    (/ (+ x y) 2))
(define (sqrt2 x)
    (sqrt-iter2 1.1 x))
(sqrt2 0.00000000000000000000000000000000000001)
(sqrt2 99999999999999999999999)

; 1.8 立方根
(define (cube-iter guess x)
    (if (good-enough-cube guess x) guess (cube-iter (improve-cube guess x) x)))
(define (improve-cube guess x)
    (average guess (/ (+ (/ x (* guess guess)) (* 2 guess)) 3)))
(define (good-enough-cube guess x)
    (display (/ (abs (- (improve guess x) guess)) guess))(newline)
    (< (/ (abs (- (improve guess x) guess)) guess) 1))
(define (cube-root x)
    (cube-iter 1.1 x))
(cube-root 8)