(load "lib/lib.scm")

; 抽象数据的多重表示

; 2.4.1
; 复数的表示
; ![image](https://user-images.githubusercontent.com/15604894/35777604-efd8b084-09eb-11e8-8527-9ab81c782611.png)

; ; 直接坐标表示
; (define (make-from-real-imag x y) (cons x y))
; (define (make-from-mag-ang r a) (cons (* r (cos a)) (* r (sin a))))
; (define (real-part z) (car z))
; (define (imag-part z) (cdr z))
; (define (magnitude z) (sqrt (+ (square (real-part z)) (square (imag-part z)))))
; (define (angle z) (atan (imag-part z) (real-part z)))

; ; 极坐标表示
; (define (make-from-mag-ang r a) (cons r a))
; (define (make-from-real-imag x y) (cons (sqrt (+ (square x) (square y))) (atan y x)))
; (define (real-part z) (* (magnitude z) (cos (angle z))))
; (define (imag-part z) (* (magnitude z) (sin (angle z))))
; (define (magnitude z) (car z))
; (define (angle z) (cdr z))

; (define (add-complex z1 z2)
;     (make-from-real-imag (+ (real-part z1) (real-part z2))
;                          (+ (imag-part z1) (imag-part z2))))
; (define (sub-complex z1 z2)
;     (make-from-real-imag (- (real-part z1) (real-part z2))
;                          (- (imag-part z1) (imag-part z2))))
; (define (mul-complex z1 z2)
;     (make-from-mag-ang (* (magnitude z1) (magnitude z2))
;                        (+ (angle z1) (angle z2))))
; (define (div-complex z1 z2)
;     (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
;                        (- (angle z1) (angle z2))))

; attach-tag type-tag contents
; 带标识的数据
(define (attach-tag type-tag contents)
    (cons type-tag contents))
(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "bad tagged datum -- TYPE_TAG" datum)))
(define (contents datum)
    (if (pair? datum)
        (cdr datum)
        (error "bad tagged datum -- CONTENTS" datum)))

(define (rectangular? z)
    (eq? (type-tag z) 'rectangular))
(define (polar? z)
    (eq? (type-tag z) 'polar))

; (define (make-from-mag-ang-rectangular r a)
;     (attach-tag 'rectangular
;                 (cons (* r (cos a))
;                       (* r (sin a)))))

; 2.4.3 数据导向
; (put <op> <type> <iem>)
; (get <op> <type>)

(define (install-rectangular-package)
    ;; internal procedures
    (define (make-from-real-imag x y) (cons x y))
    (define (make-from-mag-ang r a) (cons (* r (cos a)) (* r (sin a))))
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (magnitude z) (sqrt (+ (square (real-part z)) (square (imag-part z)))))
    (define (angle z) (atan (imag-part z) (real-part z)))
    ;;interface to rest of the system
    (define (tag x) (attach-tag 'rectangular x))
    (put 'reac-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag '(rectangular) (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang '(rectangular) (lambda (x y) (tag (make-from-mag-ang x y))))
    'done)

(define (install-polar-package)
    ;; internal procedures
    (define (make-from-mag-ang r a) (cons r a))
    (define (make-from-real-imag x y) (cons (sqrt (+ (square x) (square y))) (atan y x)))
    (define (real-part z) (* (magnitude z) (cos (angle z))))
    (define (imag-part z) (* (magnitude z) (sin (angle z))))
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    ;;interface to rest of the system
    (define (tag x) (attach-tag 'polar x))
    (put 'reac-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag '(polar) (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang '(polar) (lambda (x y) (tag (make-from-mag-ang x y))))
    'done)

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            ((if proc
                 (apply proc (map contents args))
                 (error "no method for these types -- APPLY-GENERIC" (list op type-tags)))))))

(define (make-from-real-imag x y)
    (get 'make-from-real-imag 'rectangular) x y)
(define (make-from-mag-ang r a)
    (get 'make-from-mag-ang 'polar) r a)


(define a (make-from-real-imag 1 2))
