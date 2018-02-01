; 测试 assert 库

; assert-equal
(define (assert-equal actual expect)
  (if (= expect actual)
      (display "\t\tsuccess!\n")
      (error "\t\texpect:" expect "actual:" actual "failed!\n")))

; assert-true
(define (assert-true ok)
  (if ok
      (display "\t\tsuccess!\n")
      ((display "\t\tfailed!\n") (error "\t\tfailed!\n"))))

; assert-false
(define (assert-false no-ok)
  (if (not no-ok)
      (display "\t\tsuccess!\n")
      ((display "\t\tfailed!\n") (error "\t\tfailed!\n"))))

(define load_assert! #t)
