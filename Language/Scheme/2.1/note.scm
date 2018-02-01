; test
(define (check-expect actual expect)
  (if (= expect actual)
      (display "\t\tsuccess!\n")
      ((display "\t\tfailed!\n") (error "\t\tfailed!\n"))))
; gcd
(define (gcd a b)
    (if (= 0 b)
        (if (not (> a 0)) (- a) a)
        (gcd b (remainder a b))))
(check-expect (gcd 1 1) 1)
(check-expect (gcd 5 10) 5)
(check-expect (gcd 5 -20) 5)
(check-expect (gcd 3 -21) 3)
(check-expect (gcd -7 49) 7)
; neg, pos, neg=, pos=
(define (neg x) (< x 0))
(define (pos x) (> x 0))
(define (neg= x) (not (pos x)))
(define (pos= x) (not (neg x)))

; 数据抽象导引
; 序对
; cons x y
; car z
; cdr z

; 有理数
; make-rat 1
(define (make-rat n d) (cons n d))
; make-rat 2
; (define (make-rat n d)
;     (let ((g (gcd n d)))
;         (cons (/ n g) (/ d g))))
; 2.1 
; ![image](https://user-images.githubusercontent.com/15604894/35628501-0f58a756-06d7-11e8-9cb2-4ac082ebe246.png)
(define (make-rat n d)
    ())
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

; 测试有理数
(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))
(print-rat one-half)
(print-rat (add-rat one-half one-third))
(print-rat (mul-rat one-half one-third))
(print-rat (add-rat one-third one-third))
