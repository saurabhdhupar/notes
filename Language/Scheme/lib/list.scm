; 取表的第x项
(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))

; 获取表长度
(define (list-length items)
    (define (list-length-iter items result)
        (if (null? items)
            result
            (list-length-iter (cdr items) (+ 1 result))))
    (list-length-iter items 0))

; 比较两个list
(define (list-eq? l1 l2)
    (cond ((and (null? l1) (null? l2)) #t)
          ((and (null? l1) (not (null? l2))) #f)
          ((and (not (null? l1)) (null? l2)) #f)
          (else (and (= (car l1) (car l2))
                     (list-eq? (cdr l1) (cdr l2))))))

; append 组合两个list
(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

; 返回非空list的最后一个元素
(define (last-pair l)
    (define (last-pair-or-default l default)
        (if (null? l)
            default
            (last-pair-or-default (cdr l) l)))
    (last-pair-or-default l ()))

; 往前面插入节点
(define (list-front-insert items item)
    (if (null? items)
        (list item)
        (cons item items)))

; 往后面插入节点
(define (list-end-insert items item)
    (if (null? items)
        (list item)
        (cons (car items) (list-end-insert (cdr items) item))))

; reverse
(define (reverse items)
    (if (null? items)
        items
        (append (reverse (cdr items))
                (list (car items)))))

; ; map
; (define (map proc items)
;     (if (null? items)
;         items
;         (cons (proc (car items))
;               (map proc (cdr items)))))

; filter
(define (filter proc items)
    (cond ((null? items) (list))
          ((proc (car items)) (cons (car items)
                                    (filter proc (cdr items))))
          (else (filter proc (cdr items)))))

; 累积器
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

; 输入list，返回两个list，所有的数字都会在第一个list中
(define (filter-number items)
    (define (add-number? items n)
          (if (number? n)
              (list-end-insert items n)
              items))
    (define (add-not-number? items n)
          (if (not (number? n))
              (list-end-insert items n)
              items))
    (define (filter-number-iter a b items)
          (if (null? items)
              (list a b)
                  (filter-number-iter (add-number? a (car items))
                                      (add-not-number? b (car items))
                                      (cdr items))))
    (filter-number-iter (list) (list) items))

; (define (filter-number-func func init items)
;     (define num-and-nots (filter-number items))
;     (define nums (car num-and-nots))
;     (define nots (cdr num-and-nots))
;     (define (func-iter parameters)
;         ())
;     (list (func-iter func init nums )))