; 数据导向的一些utils函数

; get和put 操作一个二维表

(define global-array '())
(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list(make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))

(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))

; attach-tag 以一个标志和实际内容为参数，生成一个带标志的数据对象，这个实际内容可能是表，也可能是过程
; type-tag和contents 分别从数据对象中把类型表示和实际内容取出来

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

; 将通用型操作应用于一些数

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error "no method for these types -- APPLY-GENERIC" (list op type-tags))))))
