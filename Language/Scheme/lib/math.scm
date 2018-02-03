; 数学库

(load "lib/assert.scm")

; 立方
(define (cube x) (* x x x))

; 加1
(define (inc x) (+ x 1))

; 平均数
(define (average x y) (/ (+ x y) 2.0))

; >=
(define (>= x y) (not (< x y)))

; <=
(define (<= x y) (not (> x y)))

; 平方
(define (squqre x) (* x x))

; 平方和
(define (sum-of-squqre x y) (+ (squqre x) (squqre y)))

; 绝对值
(define (abs x) (if (< x 0) (- x) x))

; 幂
; 0次幂是1
; 1次幂是它本身
(define (** x n)
    (define (**-iter x n result)
        (cond ((= n 0) result)
              ((= n 1) (* x result))
              (else (**-iter x (- n 1) (* x result)))))
    (**-iter x n 1))

; 平方根
(define (sqrt x)
    (define (sqrt-iter2 guess x)
        (if (good-enough guess x) guess (sqrt-iter2 (improve guess x) x)))
    ; (define (good-enough guess x)
    ;     (< (abs (- (squqre guess) x)) 0.001))
    (define (good-enough guess x)
        ; 这里就是一个变化率
        (< (/ (abs (- (improve guess x) guess)) guess) 0.0000000000001))
    (define (improve guess x)
        (average guess (/ x guess)))
    (sqrt-iter2 1.1 x))

; 立方根
(define (cube-root x)
    (define (cube-iter guess x)
        (if (good-enough-cube guess x) guess (cube-iter (improve-cube guess x) x)))
    (define (improve-cube guess x)
        (average guess (/ (+ (/ x (* guess guess)) (* 2 guess)) 3)))
    (define (good-enough-cube guess x)
        (display (/ (abs (- (improve guess x) guess)) guess))(newline)
        (< (/ (abs (- (improve guess x) guess)) guess) 1))
    (cube-iter 1.1 x))

; 最大公约数
(define (gcd a b)
    (if (= 0 b)
        (abs a)
        (gcd b (remainder a b))))

; 有理数
; (define (make-rat n d)
;     (let ((g (gcd n d)))
;         (cons (/ n g) (/ d g))))
; 2.1
; ![image](https://user-images.githubusercontent.com/15604894/35628501-0f58a756-06d7-11e8-9cb2-4ac082ebe246.png)
(define (make-rat n d)
    (define (make-rat-simple n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))
    (cond ((and (> n 0) (> d 0)) (make-rat-simple n d))
          ((and (< n 0) (< d 0)) (make-rat-simple -n -d))
          (else (make-rat-simple (- (abs n)) (abs d)))))
(define (numer x) (car x))
(define (denom x) (cdr x))

; print有理数
(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

; 有理数计算
(define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
(define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
(define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
(define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
(define (equal-rat? x y)
    (= (* (numer x) (denom y))
       (* (numer y) (denom x))))

; 区间
(define (make-interval x y)
    (cons x y))
; 2.7
; (define (lower-bound interval)
; (min (car interval) (cbr interval)))
; (define (upper-bound interval)
; (max (car interval) (cbr interval)))
(define (lower-bound interval)
    (car interval))
(define (upper-bound interval)
    (cbr interval))
; 区间相加，两端分别相加
(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))
; 2.8
; 区间相减
(define (sub-interval x y)
    (make-interval (- (lower-bound x) (lower-bound y))
                   (- (upper-bound x) (upper-bound y))))
; 区间相乘，区间1与区间2的两端两两相乘，得到四个数，其中最小和最大分别是端点
(define (mul-interval x y)
    (let ((x1 (lower-bound x))
          (x2 (upper-bound x))
          (y1 (lower-bound y))
          (y2 (upper-bound y)))
        (let ((p1 (* x1 y1))
              (p2 (* x1 y2))
              (p3 (* x2 y1))
              (p4 (* x2 y2)))
            (make-interval (min p1 p2 p3 p4)
                           (max p1 p2 p3 p4)))))
; 区间相除，第一个区间与第二个区间的倒区间的乘积；倒区间：两个端点的倒数，然后置换的区间
; 区间相除，第一个区间的两个端点两两与第二个区间的端点相除，得到四个数，其中最小和最大分别是端点
(define (div-interval x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))
; 区间宽度：上界-下界 的一半
(define (width-interval interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2.0))

(define load_lib! #t)