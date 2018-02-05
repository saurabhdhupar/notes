(load "lib/lib.scm")

; 数据抽象导引
; 序对
; cons x y
; car z
; cdr z

; 竟然可以将过程表示为序对！

; 2.4 证明下面的定义过程可以达到预期的效果
; cons返回的是一个过程，设为x，然后x又以过程m为参数，返回(m x y)的计算结果，这个过程中保存了两个数据x和y
; 也就是说cons会将x和y的数据保存起来，等待输入一个函数，对x和y进行计算
; car和cdr都是x这个过程；然后分别有一个lambda函数，分别返回两个输入参数中的一个；这个lambda函数就是m
; 这种就是2.4.3节中说到的消息传递
(define (cons x y)
    (lambda (m) (m x y)))
(define (car z)
    (z (lambda (p q) p)))
(define (cdr z)
    (z (lambda (p q) q)))

(define z (cons 1 2))
(assert-equal (car z) 1)
(assert-equal (cdr z) 2)

; 2.5

; 2.6
; 0：`(lambda (f) (lambda (x) x))`
; 1: `(add-1 zero)`
;    `(lambda (f) (lambda (x) (f ((lambda (x) x) x))))`
;    `(lambda (f) (lambda (x) (f (x))))`
; 2: `(add-1 (add-1 zero)))`
;    `(lambda (f) (lambda (x) (f ((one f) x))))`
;    `(lambda (f) (lambda (x) (f ((lambda (x) (f (x)) x))))`
;    `(lambda (f) (lambda (x) (f (f x))))`
(define zero
    (lambda (f) (lambda (x) x)))
(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))

(assert-equal ((zero inc) 0) 0)
(assert-equal (((add-1 zero) inc) 0) 1)
(assert-equal (((add-1 (add-1 zero)) inc) 0) 2)

(define one
    (lambda (f) (lambda (x) (f x))))
(define two
    (lambda (f) (lambda (x) (f (f x)))))

(assert-equal ((one inc) 0) 1)
(assert-equal ((two inc) 0) 2)

; todo +

; 2.9 证明两个区间的和（与差）的宽度就是被加（或减）的区间的宽度的函数
(define interval-1 (make-interval 1 10))
(define interval-2 (make-interval 2 5))
