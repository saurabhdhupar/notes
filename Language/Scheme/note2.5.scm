; 带有通用型操作的系统

(load "lib/lib.scm")

; 2.5.1 通用型算术运算

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (make-scheme-number n) ((get 'make 'scheme-number) n))
(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number) (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number) (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number) (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number) (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number (lambda (x) (tag x)))
    'done)

; (define (make-rational n d) ((get 'make 'rational) n d))
; (define (install-rational-package)
;     (define (tag x) (attach-tag 'rational x))
;     (put 'add '(rational rational) (lambda (x, y) (tag (add-rat x y))))
;     (put 'sub '(rational rational) (lambda (x, y) (tag (sub-rat x y))))
;     (put 'mul '(rational rational) (lambda (x, y) (tag (mul-rat x y))))
;     (put 'div '(rational rational) (lambda (x, y) (tag (div-rat x y))))
;     (put 'make 'rational (lambda (n d) (tag (make-rat n d))))
;     'done)

; (trace install-rational-package)
; (install-scheme-number-package)
; (install-rational-package)

; (add (make-scheme-number 1) (make-scheme-number 2))
; (add (make-rational 1 2) (make-rational 2 3))

; 2.5.3 实例：符号代数

; 多项式代数
; 本代数演算系统，多项式是一个特殊的语法形式，而不是在其之下的数学意义
; ![image](https://user-images.githubusercontent.com/15604894/35803198-cc8997ca-0aad-11e8-9573-efee3567e78d.png)
; poly