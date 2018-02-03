; 测试 assert 库

(load "lib/core.scm")

; assert-equal
(define (assert-equal actual expect)
  (if (==? actual expect)
      (display "  success!  ")
      (error "expect:" expect "actual:" actual "failed!")))

; assert-true
(define (assert-true ok)
  (if ok
      (display "  success!  ")
      ((error "  failed!  "))))

; assert-false
(define (assert-false no-ok)
  (if (not no-ok)
      (display "  success!  ")
      ((error "  failed!  "))))

; assert-equal-func
(define (assert-equal-func func actual expect)
  (if (func expect actual)
      (display "  success!  ")
      (error "  expect:" expect "actual:" actual "failed!  ")))

(define load_assert! #t)
