; 符号数据

(load "lib/lib.scm")

; 引号
(define a 's)
(list a 'a)
; 在表前面加引号，是表里的每一项都加引号
(car '(a b c))
(car (list 'a 'b 'c))

; (car '())

; eq? 检查两个符号或者数字是否相等
; memq
; 第一个参数是符号，第二个参数是表；如果这个符号不在这个表里面，也就是说不与任何项eq?，返回假；否则返回这个符号第一次开始的那个子表
(define (memq item x)
    (cond ((null? x) false)
          ((eq? item (car x)) x)
          (else (memq item (cdr x)))))
(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple banana) y apple pear))

; 2.53
(list 'a 'b 'c)
; (a b c)
(list (list 'george))
; ((george))
(cdr '((x1 x2) (y1 y2)))
; ((y1 y2))
; (???)
(pair? (car '(a short list)))
; #f
(memq 'red '((red shoes) (blue socks)))
; #f
(memq 'red '(red shoes blue socks))
; (red shoes blue socks)

; 2.54
; 定义equal?，比较两个元素的表
(define (equal? x y)
    (cond ((and (pair? x) (pair? y))
           (and (equal? (car x) (car y)) 
                (equal? (cdr x) (cdr y))))
          ((and (not (pair? x)) (not (pair? y)))
           (eq? x y))
          (else #f)))
(assert-true (equal? 1 1))
(assert-false (equal? (list) 1))
(assert-true (equal? (list) (list)))
(assert-false (equal? (list) (list 1)))
(assert-true (equal? (list 1) (list 1)))

; 2.55
; 为什么 (car ''abracadabra) 打印 quote
(car ''abracadabra)
;   因为 'q == (quate a)
; 又因为 '(a b) == ('a 'b)
; 所以  (car ''abracadabra)  ==  (car '(quate abracadabra)) 
;                           ==  (car ('quate 'abracadabra)) 
;                           ==  'quate 
;                           ==  打印的 quate

; 符号求导

; 变量
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))

; 和式
; 有一项为0，结果为另外一项
; 如果都是数字，结果和数字的和
; (define (make-sum a1 a2) (list '+ a1 a2))
; (define (make-sum a1 a2)
;     (cond ((=number? a1 0) a2)
;           ((=number? a2 0) a1)
;           ((and (number? a1) (number? a2)) (+ a1 a2))
;           (else (list '+ a1 a2))))
; 2.57
(define (make-sum . a)
    (let ((a1 (car a))
          (a2 (if (null? (cdr (cdr a)))
                  (car (cdr a))
                  (cdr a))))
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list '+ a1 a2)))))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

; test
; (define sum1 (make-sum 'a 'b)
; (make-sum 'a 'b)

; 乘式
; 有一项为0，结果为0
; 有一项为1，结果为另一项
; 两项都是数字，结果是数字的乘积
; (define (make-product m1 m2) (list '* m1 m2))
; (define (make-product m1 m2)
;     (cond ((or (=number? m1 0) (=number? m2 0)) 0)
;           ((=number? m2 1) m1)
;           ((=number? m1 1) m2)
;           ((and (number? m1) (number? m2)) (* m1 m2))
;           (else (list '* m1 m2))))
; 2.57
(define (make-product . m)
    (let ((m1 (car m))
          (m2 (if (null? (cdr (cdr m)))
                  (cadr m)
                  (cdr m))))
      (cond ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m2 1) m1)
            ((=number? m1 1) m2)
            ((and (number? m1) (number? m2)) (* m1 m2))
            (else (list '* m1 m2)))))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

; 2.56
; 幂
; 0次幂是1
; 1次幂是它本身
; 都是数字就是幂
(define (make-exponentiation x n)
    (cond ((=number? n 0) 1)
          ((=number? n 1) x)
          ((and (number? x) (number? n)) (** x n))
          (else (list '** x n))))
(define (exponentiation? u) (and (pair? u) (eq? (car u) '**)))
(define (base u) (cadr u))
(define (exponent u) (caddr u))

; 求导
; ![image](https://user-images.githubusercontent.com/15604894/35763372-da89ffc8-08e5-11e8-906f-465e14c92580.png)
; d(exp)/d(var)
(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp) (if (same-variable? exp var) 1 0))
          ((sum? exp) (make-sum (deriv (addend exp) var)
                                (deriv (augend exp) var)))
          ((product? exp) (make-sum (make-product (multiplier exp)
                                                  (deriv (multiplicand exp) var))
                                    (make-product (deriv (multiplier exp) var)
                                                  (multiplicand exp))))
          ((exponentiation? exp) (make-product (exponent exp)
                                               (make-exponentiation (base exp) (- (exponent exp) 1))
                                               (deriv (base exp) var)))
          (else (error "unknown expression type -- DERIV" exp))))

(trace deriv)
(assert-equal (deriv '(+ x 3) 'x) 1)
(assert-equal (deriv '(* x y) 'x) 'y)
(assert-equal (deriv '(* (* x y) (+ x 3)) 'x) '(+ (* x y) (* y (+ x 3))))
; (deriv '(** x 1) 'x)


; 集合

; 集合是未排序的表
; 2.59
; 2.60
; 集合是排序的表
; 2.61
; 2.62
; 集合是未排序的表
; 2.63
; 2.64
; 2.65

; huffman 编码

; 略