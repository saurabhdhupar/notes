; test
(define (check-expect actual expect)
  (if (= expect actual)
      (display "\t\tsuccess!\n")
      ((display "\t\tfailed!\n") (error "\t\tfailed!\n"))))
; common
(define (cube x)
    (* x x x))
(define (inc x)
    (+ x 1))

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

; 求和记法，求从a到b的按照一个增长方法next的，对每个元素计算term，的和
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

; 使用这个计算从a到b的立方和
(define (sum-cubes a b)
    (define (cube x)
        (* x x x))
    (sum cube a inc b))

(check-expect (sum-cubes 1 10) 3025)

; 用这个计算求：a到b的和
(define (sum-int a b)
    (define (identity x)
        x)
    (sum identity a inc b))


(check-expect (sum-int 1 10) 55)

; 用下面的公式求函数f在范围a到b之间的定积分的近似值
; ![image](https://user-images.githubusercontent.com/15604894/35604904-e7e859c0-067f-11e8-9296-0353ea23a446.png)
(define (integral f a b dx)
    (define (add-dx x)
        (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b)
       dx))

; f[0-1]cube == [0-1](1/4 * x^4)
(integral cube 0 1 0.01) ; .24998750000000042
(integral cube 0 1 0.0001) ; .24999999874993412

; 1.29 使用辛普森规则计算定积分
; ![image](https://user-images.githubusercontent.com/15604894/35605126-8bf91986-0681-11e8-9081-5752bef90935.png)
; yk = i * f(a + k * h)
(define (integral-xps f a b n)
    (define h
        (/ (- b a) n))
    (define (even x)
        (= (remainder x 2) 0))
    (define (g k)
        (define i
            (cond ((= k 0) 1)
                ((= k n) 1)
                ((even k) 2)
                (else 4)))
        (* i (f (+ a (* k h)))))
    (* (/ h 3.0)
       (sum g 0 inc n)))

; 使用
(check-expect (integral-xps cube 0 1 8) 0.25)
(check-expect (integral-xps cube 0 1 10) 0.25)
(check-expect (integral-xps cube 0 1 100) 0.25)

; 1.30 将sum由线性递归改写为线性迭代
; (define (sum term a next b)
;     (define (iter a result)
;         (if (predicate)
;             ()
;             (iter () ())))
;     (iter () ()))
(define (sum-2 term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (+ a 1) (+ result (term a)))))
    (iter a 0))

; 测试 integral-xps
(define (integral-xps-2 f a b n)
    (define h
        (/ (- b a) n))
    (define (even x)
        (= (remainder x 2) 0))
    (define (g k)
        (define i
            (cond ((= k 0) 1)
                ((= k n) 1)
                ((even k) 2)
                (else 4)))
        (* i (f (+ a (* k h)))))
    (* (/ h 3.0)
       (sum-2 g 0 inc n)))
(check-expect 0.25 (integral-xps-2 cube 0 1 8))

; 1.31
; ![image](https://user-images.githubusercontent.com/15604894/35612427-b602fa4a-06a3-11e8-901c-5ff578da141c.png)
(define (product-1 term a next b)
    (if (> a b)
        1
        (* (term a)
           (product-1 term (next a) next b))))
(define (fac-1 n)
    (define (y x)
        (+ 1 (* 2 x)))
    (define (term x)
        (- 1 (/ 1 (* (y x) (y x)))))
    (define (next x)
        (+ x 1))
    (/ (* 4
          (product-1 term 1 next n))
       1.0))

(fac-1 1000) ; 3.142377365093878

(define (product-2 term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* (term a) result))))
    (iter a 1))

(define (fac-2 n)
    (define (y x)
        (+ 1 (* 2 x)))
    (define (term x)
        (- 1 (/ 1 (* (y x) (y x)))))
    (define (next x)
        (+ x 1))
    (/ (* 4
          (product-2 term 1 next n))
       1.0))

(check-expect (fac-1 1000) (fac-2 1000))
(fac-2 1000) ; 3.142377365093878

; 1.32
(define (accumulate-1 combiner null-value term a next b)
    ())

; 1.33

; lambda
; (lambda (x) (+ x 1))
((lambda (x) (+ x 1)) 1)

; let
; f(x, y) = x(1+xy)^2 + y(1-y) + (1+xy)(1-y)
;         = xa^2 + yb + ab
(define (f x y)
    (let ((a (+ 1 (* x y)))
          (b (- 1 y)))
      (+ (* x (* a a))
         (* y b)
         (+ a b))))
(f 1 2)

; 1.34
(define (f g)
    (g 2))
(check-expect (f (lambda (x) (* x x))) 4)
; (f f)

; 求函数零 + error
(define (search f neg-point pos-point)
    (define (close-enough? x y)
        (< (- x y) 0.001))
    (let ((midpoint (/ (+ neg-point pos-point) 2.0)))
        (if (close-enough? neg-point pos-point)
            midpoint
            (let ((test-value (f midpoint)))
                (cond ((> test-value 0) (search f neg-point midpoint))
                      ((< test-value 0) (search f midpoint pos-point))
                      (else (midpoint)))))))
(define (half-interval-method f a b)
    (let ((a-value (f a))
          (b-value (f b)))
        (cond ((and (> a-value 0) (< b-value 0))
               (search f b a))
              ((and (< a-value 0) (> b-value 0))
               (search f a b))
              (else
                (error "Values are not of apposite sign" a b)))))
(check-expect (half-interval-method sin 2.0 4.0) 3.14111328125)
; (half-interval-method sin 1.0 2.0)

; 函数不动点
