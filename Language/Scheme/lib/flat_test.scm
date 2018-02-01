(load "lib/assert.scm")
(load "lib/flat.scm")

; 点 测试
(define px (make-point 0 0))
(define py (make-point 3 4))
(assert-false (eq?point px py))
(assert-true (eq?point py (make-point 3 4)))

(assert-equal (x-point px) 0)
(assert-equal (y-point py) 4)
(print-point px)
(print-point py)

; 线段测试
(define seg1 (make-segment px py))
(define seg2 (make-segment px (make-point 1 1)))
(print-point (midpoint-segment seg1))
(assert-false (eq?segment seg1 seg2))
(assert-true (eq?segment seg1 (make-segment (make-point 0 0) (make-point 3 4))))
(assert-equal (length-segment seg1) 5)
