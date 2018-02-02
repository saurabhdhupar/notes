(load "lib/lib.scm")

; ![image](https://user-images.githubusercontent.com/15604894/35681192-96d33456-0797-11e8-8574-ef756f419ac5.png)

; list

; (list a b c)
; 等价
; (cons a 
;       (cons b 
;             (cons c nil)))

; nil == nihil 什么也没有

(define one-to-four (list 1 2 3 4)) ; (1 2 3 4)

; car 取list第一项
; cdr 取list第一项之外的所有项

; 取表的第x项
(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))
(assert-equal (list-ref (list 1 4 9 16 25 36) 3) 16)

; null?
; 检查是不是空表

; 获取表长度
; 递归
; (define (list-length items)
;     (if (null? items)
;         0
;         (+ (list-length (cdr items)) 1)))
(define (list-length items)
    (define (list-length-iter items result)
        (if (null? items)
            result
            (list-length-iter (cdr items) (+ 1 result))))
    (list-length-iter items 0))
(assert-equal (list-length (list 1 3 5 7)) 4)

; 比较两个list
(define (list-eq? l1 l2)
    (cond ((and (null? l1) (null? l2)) #t)
          ((and (null? l1) (not (null? l2))) #f)
          ((and (not (null? l1)) (null? l2)) #f)
          (else (and (= (car l1) (car l2))
                     (list-eq? (cdr l1) (cdr l2))))))
(list-eq? (list) (list))
(list-eq? (list) (list 1))
(list-eq? (list 1) (list))
(list-eq? (list 1) (list 1))
(list-eq? (list 1) (list 1 2))

; append 组合两个list
(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))
(assert-equal-func list-eq? (append () ()) ())
(assert-equal-func list-eq? (append (list 1) ()) (list 1))
(assert-equal-func list-eq? (append (list 1) (list 2)) (list 1 2))
(assert-equal-func list-eq? (append (list 1 3) (list 2)) (list 1 3 2))
(assert-equal-func list-eq? (append (list 1 3) (list 4 2)) (list 1 3 4 2))

; 2.17，返回非空list的最后一个元素
(define (last-pair l)
    (define (last-pair-or-default l default)
        (if (null? l)
            default
            (last-pair-or-default (cdr l) l)))
    (last-pair-or-default l ()))
(assert-equal-func list-eq? (last-pair (list 1)) (list 1))
(assert-equal-func list-eq? (last-pair (list 1 2)) (list 2))

; 往前面插入节点
(define (list-front-insert items item)
    (if (null? items)
        (list item)
        (cons item items)))
(assert-equal-func list-eq? (list-front-insert (list) 0) (list 0))
(assert-equal-func list-eq? (list-front-insert (list 1) 0) (list 0 1))
(assert-equal-func list-eq? (list-front-insert (list 1 2) 0) (list 0 1 2))

; 2.18 reverse
(define (reverse items)
    (if (null? items)
        items
        (append (reverse (cdr items))
                (list (car items)))))
(assert-equal-func list-eq? (reverse (list)) (list))
(assert-equal-func list-eq? (reverse (list 1)) (list 1))
(assert-equal-func list-eq? (reverse (list 1 2 3)) (list 3 2 1))

; Functional programming
; map
(define (map proc items)
    (if (null? items)
        items
        (cons (proc (car items))
              (map proc (cdr items)))))
(assert-equal-func list-eq? (map abs (list -10 2 0 -1.5 1.7)) (list 10 2 0 1.5 1.7))

; 2.21 定义过程 square-list，以一个表为参数，返回每个数的平方构成的表
; 1)
; (define (square-list items)
;     (if (null? items)
;         nil
;         (cons <> <>)))
(define (square-list-1 items)
    (if (null? items)
        ()
        (cons (square (car items)) (square-list-1 (cdr items)))))
; 2)
; (define (square-list items)
;     (map <> <>))
(define (square-list-2 items)
    (map square items))
(assert-equal-func list-eq? (square-list-1 (list -1 -2 0 1 2)) (list 1 4 0 1 4))
(assert-equal-func list-eq? (square-list-2 (list -1 -2 0 1 2)) (list 1 4 0 1 4))

; 2.22
; 把2.21换成迭代的方式去做
; (define (square-list-3 items)
;     (square-list-3-iter))

; 2.23
; todo

; ![image](https://user-images.githubusercontent.com/15604894/35721379-a3640eda-082c-11e8-8b77-b3cb358139a7.png)
; 统计树的叶子节点的个数：car和cdr的叶子节点个数的和
(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1)
          (else (+ (count-leaves (car x)) (count-leaves (cdr x))))))
(assert-equal (count-leaves (list)) 0)
(assert-equal (count-leaves (list 0)) 1)
(assert-equal (count-leaves (list (list 1) 2 3)) 3)
(assert-equal (count-leaves (list (list 0 1) (list 2 3))) 4)

; 2.24
; (list 1 (list 2 (list 3 4)))
; (1 (2 (3 4)))

; 2.25

(define (filter proc items)
    (cond ((null? items) (list))
          ((proc (car items)) (cons (car items)
                                    (filter proc (cdr items))))
          (else (filter proc (cdr items)))))

(assert-equal-func list-eq? (filter (lambda (x) (= 0 (remainder x 2))) (list 1 2 3 4 5 6 7)) (list 2 4 6))
(assert-equal-func list-eq? (filter (lambda (x) (not (= 0 (remainder x 2)))) (list 1 2 3 4 5 6 7)) (list 1 3 5 7))

; 累积器
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))
(assert-equal (accumulate + 0 (list 1 2 3 4 5)) 15)
(assert-equal (accumulate * 1 (list 1 2 3 4 5)) 120)
(assert-equal-func list-eq? (accumulate cons () (list 1 2 3 4 5)) (list 1 2 3 4 5))