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