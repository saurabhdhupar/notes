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


(define load_lib! #t)