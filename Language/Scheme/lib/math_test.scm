; math test

(load "lib/math.scm")
(load "lib/assert.scm")

; 测试有理数
(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))
(print-rat one-half)
(print-rat (add-rat one-half one-third))
(print-rat (mul-rat one-half one-third))
(print-rat (add-rat one-third one-third))

(assert-equal (** 0 1) 0)
(assert-equal (** 1 1) 1)
(assert-equal (** -1 1) -1)
(assert-equal (** 0 0) 1)
(assert-equal (** 1 0) 1)
(assert-equal (** -1 0) 1)
(assert-equal (** 0 2) 0)
(assert-equal (** 1 2) 1)
(assert-equal (** -1 2) 1)
(assert-equal (** 2 2) 4)
(assert-equal (** -2 2) 4)
(assert-equal (** -2 3) -8)
