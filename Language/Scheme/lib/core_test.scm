(load "lib/core.scm")
(load "lib/assert.scm")

(assert-true (=number? 1 1))
(assert-false (=number? -1 0))
(assert-false (=number? #t 1))
(assert-false (=number? #f #f))
(assert-false (=number? (cons 1 2) 1))
(assert-false (=number? (cons 1 2) (cons 1 2)))
(assert-false (=number? (list) 1))
(assert-false (=number? (list) (list)))
(assert-false (=number? (list 1 2) (list 1 2)))

(assert-true (==? 1 1))
(assert-false (==? -1 0))
(assert-false (==? #t 1))
(assert-true (==? #f #f))
(assert-false (==? (cons 1 2) 1))
(assert-true (==? (cons 1 2) (cons 1 2)))
(assert-false (==? (list) 1))
(assert-true (==? (list) (list)))
(assert-true (==? (list 1 2) (list 1 2)))
(assert-true (==? '(+ (* x y) (* y (+ x 3))) '(+ (* x y) (* y (+ x 3)))))

(define cr (list 1 2 3 4 5 6 7))
(assert-equal (car cr) 1)
(assert-equal (cadr cr) 2)
(assert-equal (caddr cr) 3)
(assert-equal (cadddr cr) 4)
(assert-equal (cdr cr) (list 2 3 4 5 6 7))

(assert-equal (car (cons 1 2)) 1)
(assert-equal (cdr (cons 1 2)) 2)