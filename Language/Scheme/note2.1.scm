(load "lib/lib.scm")

; 数据抽象导引
; 序对
; cons x y
; car z
; cdr z

; 竟然可以将过程表示为序对！

; 2.4 证明下面的定义过程可以达到预期的效果
; cons返回的是一个过程，设为m，这个过程中保存了两个数据x和y
; 这个过程z，接受一个参数，这个参数还是一个过程，设为m
; m这个过程需要接受两个参数，数据分别是x和y，要我就是定义cons的那两个输入参数
; car和cdr都是m这个过程，他们分别返回x和y这两个参数的第一个和第二个
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
