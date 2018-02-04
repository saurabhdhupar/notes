; 核心库
; 所有被其他多个库所依赖的都应该放在这里

; define

; =
; >
; <

; if
; cond

; cons car cdr cadr caddr

; lambda

; number?
; symbol?
; pair?
; eq?

; 都是数字然后相等
(define (=number? n1 n2) (and (number? n1) (number? n2) (= n1 n2)))

; 泛化的相等
(define (==? a b)
    (cond ((and (pair? a) (pair? b)) (equal? a b))
          ((or (pair? a) (pair? b)) #f)
          ((and (number? a) (number? b)) (= a b))
          (else (eq? a b))))
; (define (==? a b)
;     (cond ((and (pair? a) (pair? b))
;            (let ((a1 (car a))
;                  (a2 (cdr a))
;                  (b1 (car b))
;                  (b2 (cdr b)))
;                 (and (==? a1 b1) (==? a2 b2))))
;           ((or (pair? a) (pair? b)) #f)
;           ((and (number? a) (number? b)) (= a b))
;           (else (eq? a b))))

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

(define loaded_core! #t)